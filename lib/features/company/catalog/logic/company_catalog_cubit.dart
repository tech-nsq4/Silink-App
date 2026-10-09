import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/network_exceptions.dart';
import '../../../../core/utils/app_overlay.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../profile_completion/data/models/catalog_model.dart';
import '../data/catalog_item_draft.dart';
import '../data/catalog_section_store.dart';
import '../data/company_catalog_repo.dart';

part 'company_catalog_state.dart';

class CompanyCatalogCubit extends Cubit<CompanyCatalogState> {
  CompanyCatalogCubit(this._repo, this._sections)
      : super(const CompanyCatalogInitial());

  static const String itemKind = 'product';
  static const String offerKind = 'service';

  final CompanyCatalogRepo _repo;
  final CatalogSectionStore _sections;

  CompanyCatalogSuccess? get _ready {
    final current = state;
    return current is CompanyCatalogSuccess ? current : null;
  }

  String _message(Object e) => e is NetworkException ? e.message : e.toString();

  Future<void> load() async {
    if (_ready == null) emit(const CompanyCatalogLoading());
    try {
      final catalog = await _repo.getCatalog();
      if (isClosed) return;
      emit(CompanyCatalogSuccess(
        items: catalog.items,
        actionTypes: catalog.actionTypes,
        sections: _sections.all(),
        productsEnabled: catalog.productsEnabled,
        servicesEnabled: catalog.servicesEnabled,
      ));
    } catch (e) {
      if (isClosed) return;
      final msg = _message(e);
      AppOverlay.showError(msg);
      if (_ready == null) emit(CompanyCatalogError(msg));
    }
  }

  Future<void> _ensureEnabled(String kind) async {
    final current = _ready!;
    final isOffer = kind == offerKind;
    if (isOffer ? current.servicesEnabled : current.productsEnabled) return;
    await _repo.enableKinds(
      productsEnabled: current.productsEnabled || !isOffer,
      servicesEnabled: current.servicesEnabled || isOffer,
    );
    emit(_ready!.copyWith(
      productsEnabled: current.productsEnabled || !isOffer,
      servicesEnabled: current.servicesEnabled || isOffer,
    ));
  }

  Future<bool> save(CatalogItemDraft draft,
      {CatalogItemModel? existing}) async {
    final current = _ready;
    if (current == null) return false;
    try {
      CatalogItemModel? saved;
      if (existing == null) {
        await _ensureEnabled(draft.kind);
        saved =
            await _repo.create(draft, current.ofKind(draft.kind).length + 1);
      } else {
        saved = await _repo.update(existing, draft: draft);
      }
      if (saved != null) {
        await _sections.save(
            saved.id, draft.kind == itemKind ? draft.section : '');
      }
      AppOverlay.showSuccess(LocaleKeys.products_itemSaved.tr());
      await load();
      return true;
    } catch (e) {
      AppOverlay.showError(_message(e));
      return false;
    }
  }

  Future<void> toggleActive(CatalogItemModel item) async {
    final current = _ready;
    if (current == null || current.busyId != null) return;
    final updated = item.copyWith(isActive: !item.isActive);
    emit(current.copyWith(
      busyId: item.id,
      items: [for (final i in current.items) i.id == item.id ? updated : i],
    ));
    try {
      await _repo.update(updated);
      emit(_ready!.copyWith(clearBusy: true));
    } catch (e) {
      AppOverlay.showError(_message(e));
      emit(_ready!.copyWith(
        clearBusy: true,
        items: [for (final i in _ready!.items) i.id == item.id ? item : i],
      ));
    }
  }

  Future<void> move(CatalogItemModel item, int offset) async {
    final current = _ready;
    if (current == null || current.busyId != null) return;
    final group = current.ofKind(item.kind);
    final index = group.indexWhere((i) => i.id == item.id);
    final target = index + offset;
    if (index < 0 || target < 0 || target >= group.length) return;
    final reordered = [...group];
    final moved = reordered.removeAt(index);
    reordered.insert(target, moved);
    final renumbered = [
      for (final (position, entry) in reordered.indexed)
        entry.copyWith(sortOrder: position + 1),
    ];
    final changed = [
      for (final entry in renumbered)
        if (group.firstWhere((g) => g.id == entry.id).sortOrder !=
            entry.sortOrder)
          entry,
    ];
    emit(current.copyWith(
      busyId: item.id,
      items: [
        for (final i in current.items)
          renumbered.firstWhere((r) => r.id == i.id, orElse: () => i),
      ],
    ));
    try {
      for (final entry in changed) {
        await _repo.update(entry);
      }
      emit(_ready!.copyWith(clearBusy: true));
    } catch (e) {
      AppOverlay.showError(_message(e));
      await load();
      emit(_ready!.copyWith(clearBusy: true));
    }
  }

  Future<void> delete(CatalogItemModel item) async {
    final current = _ready;
    if (current == null) return;
    emit(current.copyWith(busyId: item.id));
    try {
      await _repo.delete(item);
      await _sections.remove(item.id);
      emit(_ready!.copyWith(
        clearBusy: true,
        items: _ready!.items.where((i) => i.id != item.id).toList(),
      ));
    } catch (e) {
      AppOverlay.showError(_message(e));
      emit(_ready!.copyWith(clearBusy: true));
    }
  }
}

import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/network/network_exceptions.dart';
import '../../../core/utils/app_overlay.dart';
import '../../../core/utils/locale_keys.dart';
import 'package:easy_localization/easy_localization.dart';

import '../data/models/appearance_model.dart';
import '../data/models/arrangement_section_model.dart';
import '../data/models/catalog_model.dart';
import '../data/models/channel_model.dart';
import '../data/models/link_model.dart';
import '../data/models/template_model.dart';
import '../data/profile_completion_repo.dart';

part 'profile_completion_state.dart';

class ProfileCompletionCubit extends Cubit<ProfileCompletionState> {
  ProfileCompletionCubit(this._repo) : super(const ProfileCompletionState());

  final ProfileCompletionRepo _repo;

  String _errorMessage(Object e) =>
      e is NetworkException ? e.message : e.toString();

  // ─── Channels ─────────────────────────────────────────────────────────────

  Future<void> loadChannels({bool force = false}) async {
    if (state.channelsLoaded && !force) return;
    emit(state.copyWith(channelsLoading: true, clearChannelsError: true));
    try {
      final channels = await _repo.getChannels();
      emit(state.copyWith(channelsLoading: false, channels: channels));
    } catch (e) {
      emit(state.copyWith(
        channelsLoading: false,
        channelsError: _errorMessage(e),
      ));
    }
  }

  void toggleChannelVisible(String type, bool visible) {
    emit(state.copyWith(
      channels: [
        for (final c in state.channels)
          if (c.type == type) c.copyWith(visible: visible) else c,
      ],
    ));
  }

  void updateChannelValue(String type, String value) {
    emit(state.copyWith(
      channels: [
        for (final c in state.channels)
          if (c.type == type)
            c.copyWith(value: value, visible: value.trim().isNotEmpty)
          else
            c,
      ],
    ));
  }

  Future<bool> saveChannels() async {
    emit(state.copyWith(isSavingStep: true));
    try {
      final payload = [
        for (final c in state.channels)
          c.value.trim().isEmpty ? c.copyWith(visible: false) : c,
      ];
      final channels = await _repo.saveChannels(payload);
      emit(state.copyWith(isSavingStep: false, channels: channels));
      return true;
    } catch (e) {
      emit(state.copyWith(isSavingStep: false));
      AppOverlay.showError(_errorMessage(e));
      return false;
    }
  }

  // ─── Links ────────────────────────────────────────────────────────────────

  Future<void> loadLinks({bool force = false}) async {
    if (state.linksLoaded && !force) return;
    emit(state.copyWith(linksLoading: true, clearLinksError: true));
    try {
      final links = await _repo.getLinks();
      emit(state.copyWith(linksLoading: false, links: links));
    } catch (e) {
      emit(state.copyWith(linksLoading: false, linksError: _errorMessage(e)));
    }
  }

  void toggleLinkVisible(String type, bool visible) {
    emit(state.copyWith(
      links: [
        for (final l in state.links)
          if (l.type == type) l.copyWith(visible: visible) else l,
      ],
    ));
  }

  void updateLinkValue(String type, String value) {
    emit(state.copyWith(
      links: [
        for (final l in state.links)
          if (l.type == type)
            l.copyWith(value: value, visible: value.trim().isNotEmpty)
          else
            l,
      ],
    ));
  }

  Future<bool> saveLinks() async {
    emit(state.copyWith(isSavingStep: true));
    try {
      final payload = [
        for (final l in state.links)
          l.value.trim().isEmpty ? l.copyWith(visible: false) : l,
      ];
      final links = await _repo.saveLinks(payload);
      emit(state.copyWith(isSavingStep: false, links: links));
      return true;
    } catch (e) {
      emit(state.copyWith(isSavingStep: false));
      AppOverlay.showError(_errorMessage(e));
      return false;
    }
  }

  // ─── Catalog ──────────────────────────────────────────────────────────────

  Future<void> loadCatalog({bool force = false}) async {
    if (state.catalogLoaded && !force) return;
    emit(state.copyWith(catalogLoading: true, clearCatalogError: true));
    try {
      final catalog = await _repo.getCatalog();
      emit(state.copyWith(catalogLoading: false, catalog: catalog));
    } catch (e) {
      emit(state.copyWith(
        catalogLoading: false,
        catalogError: _errorMessage(e),
      ));
    }
  }

  void toggleCatalogSection(String type, bool enabled) {
    final catalog = state.catalog;
    if (catalog == null) return;
    emit(state.copyWith(
      catalog: catalog.copyWith(
        productsEnabled: type == 'product' ? enabled : catalog.productsEnabled,
        servicesEnabled: type == 'service' ? enabled : catalog.servicesEnabled,
        sections: [
          for (final s in catalog.sections)
            if (s.type == type) s.copyWith(enabled: enabled) else s,
        ],
      ),
    ));
  }

  Future<bool> saveCatalogSettings() async {
    final catalog = state.catalog;
    if (catalog == null) return true;
    emit(state.copyWith(isSavingStep: true));
    try {
      final result = await _repo.saveCatalogSettings(
        productsEnabled: catalog.productsEnabled,
        servicesEnabled: catalog.servicesEnabled,
      );
      emit(state.copyWith(isSavingStep: false, catalog: result));
      return true;
    } catch (e) {
      emit(state.copyWith(isSavingStep: false));
      AppOverlay.showError(_errorMessage(e));
      return false;
    }
  }

  Future<bool> addCatalogItem({
    required String kind,
    required String name,
    required String description,
    required String priceLabel,
    required String price,
    required String actionType,
    required String actionUrl,
    File? image,
  }) async {
    if (state.catalog == null) return false;
    emit(state.copyWith(isSavingCatalogItem: true));
    try {
      final catalog = await _repo.addCatalogItem(
        kind: kind,
        name: name,
        description: description,
        priceLabel: priceLabel,
        price: price,
        actionType: actionType,
        actionUrl: actionUrl,
        image: image,
      );
      emit(state.copyWith(isSavingCatalogItem: false, catalog: catalog));
      AppOverlay.showSuccess(LocaleKeys.products_itemSaved.tr());
      return true;
    } catch (e) {
      emit(state.copyWith(isSavingCatalogItem: false));
      AppOverlay.showError(_errorMessage(e));
      return false;
    }
  }

  Future<bool> updateCatalogItem({
    required String id,
    required String kind,
    required String name,
    required String description,
    required String priceLabel,
    required String price,
    required String actionType,
    required String actionUrl,
    File? image,
  }) async {
    final catalog = state.catalog;
    if (catalog == null) return false;
    emit(state.copyWith(savingCatalogItemId: id));
    try {
      final item = await _repo.updateCatalogItem(
        id: id,
        kind: kind,
        name: name,
        description: description,
        priceLabel: priceLabel,
        price: price,
        actionType: actionType,
        actionUrl: actionUrl,
        image: image,
      );
      emit(state.copyWith(
        clearSavingCatalogItemId: true,
        catalog: catalog.copyWith(items: [
          for (final i in catalog.items) if (i.id == id) item else i,
        ]),
      ));
      AppOverlay.showSuccess(LocaleKeys.products_itemSaved.tr());
      return true;
    } catch (e) {
      emit(state.copyWith(clearSavingCatalogItemId: true));
      AppOverlay.showError(_errorMessage(e));
      return false;
    }
  }

  Future<bool> deleteCatalogItem({required String id, required String kind}) async {
    final catalog = state.catalog;
    if (catalog == null) return false;
    emit(state.copyWith(savingCatalogItemId: id));
    try {
      await _repo.deleteCatalogItem(id: id, kind: kind);
      emit(state.copyWith(
        clearSavingCatalogItemId: true,
        catalog: catalog.copyWith(
          items: catalog.items.where((i) => i.id != id).toList(),
        ),
      ));
      return true;
    } catch (e) {
      emit(state.copyWith(clearSavingCatalogItemId: true));
      AppOverlay.showError(_errorMessage(e));
      return false;
    }
  }

  // ─── Arrangement ──────────────────────────────────────────────────────────

  Future<void> loadArrangement({bool force = false}) async {
    if (state.arrangementLoaded && !force) return;
    emit(
        state.copyWith(arrangementLoading: true, clearArrangementError: true));
    try {
      final sections = await _repo.getArrangement();
      emit(state.copyWith(arrangementLoading: false, arrangement: sections));
    } catch (e) {
      emit(state.copyWith(
        arrangementLoading: false,
        arrangementError: _errorMessage(e),
      ));
    }
  }

  void toggleArrangementVisible(String type, bool visible) {
    emit(state.copyWith(
      arrangement: [
        for (final s in state.arrangement)
          if (s.type == type && !s.locked) s.copyWith(visible: visible) else s,
      ],
    ));
  }

  void moveArrangementSection(String type, int delta) {
    final list = List<ArrangementSectionModel>.from(state.arrangement);
    final index = list.indexWhere((s) => s.type == type);
    if (index == -1) return;
    final target = index + delta;
    if (target < 0 || target >= list.length) return;
    if (list[index].locked || list[target].locked) return;
    final item = list.removeAt(index);
    list.insert(target, item);
    emit(state.copyWith(arrangement: list));
  }

  Future<bool> saveArrangement() async {
    emit(state.copyWith(isSavingStep: true));
    try {
      final sections = await _repo.saveArrangement(state.arrangement);
      emit(state.copyWith(isSavingStep: false, arrangement: sections));
      return true;
    } catch (e) {
      emit(state.copyWith(isSavingStep: false));
      AppOverlay.showError(_errorMessage(e));
      return false;
    }
  }

  // ─── Templates ────────────────────────────────────────────────────────────

  Future<void> loadTemplates({bool force = false}) async {
    if (state.templatesLoaded && !force) return;
    emit(state.copyWith(templatesLoading: true, clearTemplatesError: true));
    try {
      final templates = await _repo.getTemplates();
      emit(state.copyWith(templatesLoading: false, templates: templates));
    } catch (e) {
      emit(state.copyWith(
        templatesLoading: false,
        templatesError: _errorMessage(e),
      ));
    }
  }

  void selectTemplate(String id) {
    final templates = state.templates;
    if (templates == null) return;
    emit(state.copyWith(templates: templates.copyWith(selectedId: id)));
  }

  Future<bool> saveTemplate() async {
    final templates = state.templates;
    if (templates == null) return true;
    emit(state.copyWith(isSavingStep: true));
    try {
      final result = await _repo.saveTemplate(templates.selectedId);
      emit(state.copyWith(isSavingStep: false, templates: result));
      return true;
    } catch (e) {
      emit(state.copyWith(isSavingStep: false));
      AppOverlay.showError(_errorMessage(e));
      return false;
    }
  }

  // ─── Appearance ───────────────────────────────────────────────────────────

  Future<void> loadAppearance({bool force = false}) async {
    if (state.appearanceLoaded && !force) return;
    emit(state.copyWith(appearanceLoading: true, clearAppearanceError: true));
    try {
      final appearance = await _repo.getAppearance();
      emit(state.copyWith(appearanceLoading: false, appearance: appearance));
    } catch (e) {
      emit(state.copyWith(
        appearanceLoading: false,
        appearanceError: _errorMessage(e),
      ));
    }
  }

  void updateAppearanceDraft({
    String? primaryColor,
    String? coverColor,
    String? background,
    String? buttonShape,
    String? fontId,
  }) {
    final appearance = state.appearance;
    if (appearance == null) return;
    emit(state.copyWith(
      appearance: appearance.copyWith(
        primaryColor: primaryColor,
        coverColor: coverColor,
        background: background,
        buttonShape: buttonShape,
        fontId: fontId,
      ),
    ));
  }

  Future<bool> saveAppearance() async {
    final appearance = state.appearance;
    if (appearance == null) return true;
    emit(state.copyWith(isSavingStep: true));
    try {
      final result = await _repo.saveAppearance(appearance);
      emit(state.copyWith(isSavingStep: false, appearance: result));
      return true;
    } catch (e) {
      emit(state.copyWith(isSavingStep: false));
      AppOverlay.showError(_errorMessage(e));
      return false;
    }
  }

  // ─── Wizard step dispatcher ───────────────────────────────────────────────

  Future<bool> saveStep(int step) {
    switch (step) {
      case 1:
        return saveChannels();
      case 2:
        return saveLinks();
      case 3:
        return saveCatalogSettings();
      case 4:
        return saveArrangement();
      case 5:
        return saveTemplate();
      case 6:
        return saveAppearance();
      default:
        return Future.value(true);
    }
  }
}

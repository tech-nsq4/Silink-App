import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/network/network_exceptions.dart';
import '../../../core/utils/app_overlay.dart';
import '../../../core/utils/locale_keys.dart';
import '../data/client_extras_store.dart';
import '../data/clients_repo.dart';
import '../data/models/client_category_model.dart';
import '../data/models/client_extras.dart';
import '../data/models/client_model.dart';
import '../data/models/client_request.dart';

part 'client_details_state.dart';

class ClientDetailsCubit extends Cubit<ClientDetailsState> {
  ClientDetailsCubit(this._repo, this._extras)
      : super(const ClientDetailsInitial());

  final ClientsRepo _repo;
  final ClientExtrasStore _extras;

  ClientDetailsSuccess _withExtras(
    ClientModel client,
    List<ClientCategoryModel> categories,
  ) =>
      ClientDetailsSuccess(
        client: client,
        categories: categories,
        followUp: _extras.followUp(client.id),
        notes: _extras.notes(client.id),
      );

  bool _changed = false;

  bool get hasChanges => _changed;

  String _errorMessage(Object e) =>
      e is NetworkException ? e.message : e.toString();

  ClientDetailsSuccess? get _success {
    final current = state;
    return current is ClientDetailsSuccess ? current : null;
  }

  Future<void> getClient(String id, {ClientModel? initial}) async {
    if (initial != null) {
      final categories = await _repo
          .getCategories()
          .catchError((_) => <ClientCategoryModel>[]);
      if (isClosed) return;
      emit(_withExtras(initial, categories));
    } else {
      emit(const ClientDetailsLoading());
    }
    try {
      final results = await Future.wait([
        _repo.getClient(id),
        _repo.getCategories(),
      ]);
      if (isClosed) return;
      emit(_withExtras(
        results[0] as ClientModel,
        results[1] as List<ClientCategoryModel>,
      ));
    } catch (e) {
      if (isClosed) return;
      final msg = _errorMessage(e);
      AppOverlay.showError(msg);
      if (initial == null) emit(ClientDetailsError(msg));
    }
  }

  void replaceClient(ClientModel client) {
    final current = _success;
    if (current == null) return;
    _changed = true;
    emit(current.copyWith(client: client));
  }

  Future<void> toggleCategory(ClientCategoryModel category) async {
    final current = _success;
    if (current == null || current.isUpdating) return;
    final client = current.client;
    final selected = client.categoryIds.contains(category.id);
    final updatedCategories = selected
        ? client.categories.where((c) => c.id != category.id).toList()
        : [...client.categories, category];
    emit(current.copyWith(
      client: client.copyWith(categories: updatedCategories),
      isUpdating: true,
    ));
    try {
      final updated = await _repo.updateClient(
        client.id,
        ClientRequest.fromClient(
          client,
          categoryIds: updatedCategories.map((c) => c.id).toList(),
        ),
      );
      _changed = true;
      emit(_success!.copyWith(client: updated, isUpdating: false));
    } catch (e) {
      emit(_success!.copyWith(client: client, isUpdating: false));
      AppOverlay.showError(_errorMessage(e));
    }
  }

  Future<void> deleteClient() async {
    final current = _success;
    if (current == null || current.isUpdating) return;
    emit(current.copyWith(isUpdating: true));
    try {
      await _repo.deleteClient(current.client.id);
      await _extras.removeClient(current.client.id);
      _changed = true;
      AppOverlay.showSuccess(LocaleKeys.clients_deleted.tr());
      emit(const ClientDetailsDeleted());
    } catch (e) {
      emit(current.copyWith(isUpdating: false));
      AppOverlay.showError(_errorMessage(e));
    }
  }

  Future<void> saveFollowUp(ClientFollowUp? followUp) async {
    final current = _success;
    if (current == null) return;
    await _extras.saveFollowUp(current.client.id, followUp);
    _changed = true;
    emit(_success!
        .copyWith(followUp: followUp, clearFollowUp: followUp == null));
  }

  Future<void> addNote(String text) async {
    final current = _success;
    final trimmed = text.trim();
    if (current == null || trimmed.isEmpty) return;
    await _extras.addNote(
      current.client.id,
      ClientNote(text: trimmed, createdAt: DateTime.now()),
    );
    emit(_success!.copyWith(notes: _extras.notes(current.client.id)));
  }
}

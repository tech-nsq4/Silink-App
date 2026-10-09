import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/network/network_exceptions.dart';
import '../../../core/utils/app_overlay.dart';
import '../data/client_extras_store.dart';
import '../data/clients_repo.dart';
import '../data/models/client_category_model.dart';
import '../data/models/client_model.dart';

part 'clients_state.dart';

class ClientsCubit extends Cubit<ClientsState> {
  ClientsCubit(this._repo, this._extras) : super(const ClientsInitial());

  final ClientsRepo _repo;
  final ClientExtrasStore _extras;

  int pendingFollowUps(Iterable<String> clientIds) =>
      _extras.pendingFollowUps(clientIds);

  Future<void> getClients({bool silent = false}) async {
    final showLoading = !silent || state is! ClientsSuccess;
    if (showLoading) emit(const ClientsLoading());
    try {
      final results = await Future.wait([
        _repo.getClients(),
        _repo.getCategories(),
      ]);
      if (isClosed) return;
      emit(ClientsSuccess(
        clients: results[0] as List<ClientModel>,
        categories: results[1] as List<ClientCategoryModel>,
      ));
    } catch (e) {
      if (isClosed) return;
      final msg = e is NetworkException ? e.message : e.toString();
      AppOverlay.showError(msg);
      if (showLoading) emit(ClientsError(msg));
    }
  }
}

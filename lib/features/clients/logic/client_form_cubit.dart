import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/network/network_exceptions.dart';
import '../../../core/utils/app_overlay.dart';
import '../../../core/utils/locale_keys.dart';
import '../data/clients_repo.dart';
import '../data/models/client_model.dart';
import '../data/models/client_request.dart';

part 'client_form_state.dart';

class ClientFormCubit extends Cubit<ClientFormState> {
  ClientFormCubit(this._repo) : super(const ClientFormInitial());

  final ClientsRepo _repo;

  Future<void> submit(ClientRequest request, {String? clientId}) async {
    if (state is ClientFormLoading) return;
    emit(const ClientFormLoading());
    try {
      final client = clientId == null
          ? await _repo.createClient(request)
          : await _repo.updateClient(clientId, request);
      AppOverlay.showSuccess(LocaleKeys.clients_saved.tr());
      emit(ClientFormSuccess(client));
    } catch (e) {
      final msg = e is NetworkException ? e.message : e.toString();
      AppOverlay.showError(msg);
      emit(ClientFormError(msg));
    }
  }
}

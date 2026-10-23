import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/network/network_exceptions.dart';
import '../../../core/utils/app_overlay.dart';
import '../../auth/data/models/user_model.dart';
import '../data/employee_invitation_repo.dart';
import '../data/models/invitation_details_model.dart';

part 'employee_invitation_state.dart';

class EmployeeInvitationCubit extends Cubit<EmployeeInvitationState> {
  EmployeeInvitationCubit(this._repo)
      : super(const EmployeeInvitationInitial());

  final EmployeeInvitationRepo _repo;
  String _inviteToken = '';

  Future<void> load(String inviteToken) async {
    _inviteToken = inviteToken;
    emit(const EmployeeInvitationLoading());
    try {
      final details = await _repo.getInvitation(inviteToken);
      emit(EmployeeInvitationLoaded(details));
    } catch (e) {
      emit(EmployeeInvitationError(_message(e)));
    }
  }

  Future<void> retry() => load(_inviteToken);

  Future<void> accept({
    required String name,
    required String email,
    required String phone,
    required String position,
    required String password,
  }) async {
    final current = state;
    if (current is! EmployeeInvitationLoaded) return;
    emit(EmployeeInvitationSubmitting(current.details));
    try {
      final user = await _repo.acceptInvitation(
        inviteToken: _inviteToken,
        name: name,
        email: email,
        phone: phone,
        position: position,
        password: password,
      );
      emit(EmployeeInvitationAccepted(user));
    } catch (e) {
      AppOverlay.showError(_message(e));
      emit(EmployeeInvitationLoaded(current.details));
    }
  }

  String _message(Object e) => e is NetworkException ? e.message : e.toString();
}

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/network_exceptions.dart';
import '../../../../core/utils/app_overlay.dart';
import '../data/company_team_repo.dart';
import '../data/models/company_employee_model.dart';

part 'company_team_member_state.dart';

class CompanyTeamMemberCubit extends Cubit<CompanyTeamMemberState> {
  CompanyTeamMemberCubit(this._repo) : super(const CompanyTeamMemberInitial());

  final CompanyTeamRepo _repo;

  Future<void> createMember({
    required String name,
    required String email,
    required String phone,
    required String position,
    String department = '',
  }) async {
    emit(const CompanyTeamMemberLoading());
    try {
      final member = await _repo.createMember(
        name: name,
        email: email,
        phone: phone,
        position: position,
        department: department,
      );
      emit(CompanyTeamMemberSaved(member));
    } catch (e) {
      _emitError(e);
    }
  }

  Future<void> updateMember(
    CompanyEmployeeModel employee, {
    required String name,
    required String email,
    required String phone,
    required String whatsapp,
    required String position,
    String? password,
  }) async {
    emit(const CompanyTeamMemberLoading());
    try {
      final updated = await _repo.updateMember(
        id: employee.id,
        name: name,
        email: email,
        phone: phone,
        whatsapp: whatsapp,
        position: position,
        password: password,
      );
      emit(CompanyTeamMemberSaved(
        updated.copyWith(
          hasProfile: employee.hasProfile,
          hasNfc: employee.hasNfc,
          visits: employee.visits,
          leads: employee.leads,
        ),
      ));
    } catch (e) {
      _emitError(e);
    }
  }

  Future<void> deleteMember(String id) async {
    emit(const CompanyTeamMemberLoading());
    try {
      await _repo.deleteMember(id);
      emit(CompanyTeamMemberDeleted(id));
    } catch (e) {
      _emitError(e);
    }
  }

  Future<void> setSuspended(
    CompanyEmployeeModel employee, {
    required bool suspended,
  }) async {
    emit(const CompanyTeamMemberLoading());
    try {
      await _repo.updateMemberStatus(employee.id, active: !suspended);
      emit(CompanyTeamMemberStatusChanged(
        employee.copyWith(
          status: suspended
              ? CompanyEmployeeStatus.suspended
              : CompanyEmployeeStatus.active,
        ),
      ));
    } catch (e) {
      _emitError(e);
    }
  }

  Future<void> resendInvitation(CompanyEmployeeModel employee) async {
    emit(const CompanyTeamMemberLoading());
    try {
      final invitation = await _repo.resendInvitation(employee.id);
      emit(CompanyTeamMemberInvitationResent(
        employee.copyWith(invitation: invitation),
      ));
    } catch (e) {
      _emitError(e);
    }
  }

  void reset() => emit(const CompanyTeamMemberInitial());

  void _emitError(Object e) {
    final msg = e is NetworkException ? e.message : e.toString();
    AppOverlay.showError(msg);
    emit(CompanyTeamMemberError(msg));
  }
}

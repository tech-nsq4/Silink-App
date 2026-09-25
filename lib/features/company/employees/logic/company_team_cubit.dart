import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/network_exceptions.dart';
import '../../../../core/utils/app_overlay.dart';
import '../data/company_team_repo.dart';
import '../data/models/company_employee_model.dart';

part 'company_team_state.dart';

class CompanyTeamCubit extends Cubit<CompanyTeamState> {
  CompanyTeamCubit(this._repo) : super(const CompanyTeamInitial());

  final CompanyTeamRepo _repo;

  List<CompanyEmployeeModel> get _members {
    final current = state;
    return current is CompanyTeamSuccess ? current.members : const [];
  }

  Future<void> getTeam() async {
    emit(const CompanyTeamLoading());
    try {
      final members = await _repo.getTeam();
      emit(CompanyTeamSuccess(members));
    } catch (e) {
      final msg = e is NetworkException ? e.message : e.toString();
      AppOverlay.showError(msg);
      emit(CompanyTeamError(msg));
    }
  }

  void upsertMember(CompanyEmployeeModel member) {
    final exists = _members.any((m) => m.id == member.id);
    emit(CompanyTeamSuccess(
      exists
          ? [for (final m in _members) m.id == member.id ? member : m]
          : [..._members, member],
    ));
  }

  void removeMember(String id) {
    emit(CompanyTeamSuccess(_members.where((m) => m.id != id).toList()));
  }
}

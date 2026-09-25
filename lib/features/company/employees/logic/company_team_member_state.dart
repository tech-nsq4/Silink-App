part of 'company_team_member_cubit.dart';

sealed class CompanyTeamMemberState extends Equatable {
  const CompanyTeamMemberState();

  @override
  List<Object?> get props => [];
}

final class CompanyTeamMemberInitial extends CompanyTeamMemberState {
  const CompanyTeamMemberInitial();
}

final class CompanyTeamMemberLoading extends CompanyTeamMemberState {
  const CompanyTeamMemberLoading();
}

final class CompanyTeamMemberSaved extends CompanyTeamMemberState {
  final CompanyEmployeeModel member;
  const CompanyTeamMemberSaved(this.member);

  @override
  List<Object?> get props => [member];
}

final class CompanyTeamMemberDeleted extends CompanyTeamMemberState {
  final String id;
  const CompanyTeamMemberDeleted(this.id);

  @override
  List<Object?> get props => [id];
}

final class CompanyTeamMemberError extends CompanyTeamMemberState {
  final String message;
  const CompanyTeamMemberError(this.message);

  @override
  List<Object?> get props => [message];
}

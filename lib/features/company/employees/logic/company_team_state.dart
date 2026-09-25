part of 'company_team_cubit.dart';

sealed class CompanyTeamState extends Equatable {
  const CompanyTeamState();

  @override
  List<Object?> get props => [];
}

final class CompanyTeamInitial extends CompanyTeamState {
  const CompanyTeamInitial();
}

final class CompanyTeamLoading extends CompanyTeamState {
  const CompanyTeamLoading();
}

final class CompanyTeamSuccess extends CompanyTeamState {
  final List<CompanyEmployeeModel> members;
  const CompanyTeamSuccess(this.members);

  @override
  List<Object?> get props => [members];
}

final class CompanyTeamError extends CompanyTeamState {
  final String message;
  const CompanyTeamError(this.message);

  @override
  List<Object?> get props => [message];
}

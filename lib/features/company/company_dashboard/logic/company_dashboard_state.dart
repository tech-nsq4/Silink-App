part of 'company_dashboard_cubit.dart';

sealed class CompanyDashboardState extends Equatable {
  const CompanyDashboardState();

  @override
  List<Object?> get props => [];
}

final class CompanyDashboardInitial extends CompanyDashboardState {
  const CompanyDashboardInitial();
}

final class CompanyDashboardLoading extends CompanyDashboardState {
  const CompanyDashboardLoading();
}

final class CompanyDashboardSuccess extends CompanyDashboardState {
  final CompanyDashboardInfo info;
  const CompanyDashboardSuccess(this.info);

  @override
  List<Object?> get props => [info];
}

final class CompanyDashboardError extends CompanyDashboardState {
  final String message;
  const CompanyDashboardError(this.message);

  @override
  List<Object?> get props => [message];
}

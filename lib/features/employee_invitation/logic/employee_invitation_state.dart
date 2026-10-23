part of 'employee_invitation_cubit.dart';

sealed class EmployeeInvitationState extends Equatable {
  const EmployeeInvitationState();

  @override
  List<Object?> get props => [];
}

final class EmployeeInvitationInitial extends EmployeeInvitationState {
  const EmployeeInvitationInitial();
}

final class EmployeeInvitationLoading extends EmployeeInvitationState {
  const EmployeeInvitationLoading();
}

final class EmployeeInvitationLoaded extends EmployeeInvitationState {
  final InvitationDetailsModel details;
  const EmployeeInvitationLoaded(this.details);

  @override
  List<Object?> get props => [details];
}

final class EmployeeInvitationSubmitting extends EmployeeInvitationState {
  final InvitationDetailsModel details;
  const EmployeeInvitationSubmitting(this.details);

  @override
  List<Object?> get props => [details];
}

final class EmployeeInvitationAccepted extends EmployeeInvitationState {
  final UserModel user;
  const EmployeeInvitationAccepted(this.user);

  @override
  List<Object?> get props => [user];
}

final class EmployeeInvitationError extends EmployeeInvitationState {
  final String message;
  const EmployeeInvitationError(this.message);

  @override
  List<Object?> get props => [message];
}

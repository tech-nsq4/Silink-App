part of 'account_edit_cubit.dart';

sealed class AccountEditState extends Equatable {
  const AccountEditState();

  @override
  List<Object?> get props => [];
}

final class AccountEditInitial extends AccountEditState {
  const AccountEditInitial();
}

final class AccountEditLoading extends AccountEditState {
  const AccountEditLoading();
}

final class AccountEditSuccess extends AccountEditState {
  final UserModel user;
  const AccountEditSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

final class AccountEditError extends AccountEditState {
  final String message;
  const AccountEditError(this.message);

  @override
  List<Object?> get props => [message];
}

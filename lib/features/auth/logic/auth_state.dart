part of 'auth_cubit.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

final class AuthInitial extends AuthState {
  const AuthInitial();
}

final class AuthLoading extends AuthState {
  const AuthLoading();
}

final class AuthSuccess extends AuthState {
  final UserModel user;
  const AuthSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

final class AuthRegistrationPending extends AuthState {
  final String registrationId;
  final String phone;
  final DateTime? expiresAt;

  const AuthRegistrationPending({
    required this.registrationId,
    required this.phone,
    this.expiresAt,
  });

  @override
  List<Object?> get props => [registrationId, phone, expiresAt];
}

final class AuthError extends AuthState {
  final String message;
  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}

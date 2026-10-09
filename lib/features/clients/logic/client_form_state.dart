part of 'client_form_cubit.dart';

sealed class ClientFormState extends Equatable {
  const ClientFormState();

  @override
  List<Object?> get props => [];
}

final class ClientFormInitial extends ClientFormState {
  const ClientFormInitial();
}

final class ClientFormLoading extends ClientFormState {
  const ClientFormLoading();
}

final class ClientFormSuccess extends ClientFormState {
  final ClientModel? client;
  const ClientFormSuccess(this.client);

  @override
  List<Object?> get props => [client];
}

final class ClientFormError extends ClientFormState {
  final String message;
  const ClientFormError(this.message);

  @override
  List<Object?> get props => [message];
}

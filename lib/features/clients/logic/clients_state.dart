part of 'clients_cubit.dart';

sealed class ClientsState extends Equatable {
  const ClientsState();

  @override
  List<Object?> get props => [];
}

final class ClientsInitial extends ClientsState {
  const ClientsInitial();
}

final class ClientsLoading extends ClientsState {
  const ClientsLoading();
}

final class ClientsSuccess extends ClientsState {
  final List<ClientModel> clients;
  final List<ClientCategoryModel> categories;

  const ClientsSuccess({required this.clients, required this.categories});

  @override
  List<Object?> get props => [clients, categories];
}

final class ClientsError extends ClientsState {
  final String message;
  const ClientsError(this.message);

  @override
  List<Object?> get props => [message];
}

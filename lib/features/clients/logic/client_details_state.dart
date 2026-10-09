part of 'client_details_cubit.dart';

sealed class ClientDetailsState extends Equatable {
  const ClientDetailsState();

  @override
  List<Object?> get props => [];
}

final class ClientDetailsInitial extends ClientDetailsState {
  const ClientDetailsInitial();
}

final class ClientDetailsLoading extends ClientDetailsState {
  const ClientDetailsLoading();
}

final class ClientDetailsSuccess extends ClientDetailsState {
  final ClientModel client;
  final List<ClientCategoryModel> categories;
  final bool isUpdating;
  final ClientFollowUp? followUp;
  final List<ClientNote> notes;

  const ClientDetailsSuccess({
    required this.client,
    required this.categories,
    this.isUpdating = false,
    this.followUp,
    this.notes = const [],
  });

  ClientDetailsSuccess copyWith({
    ClientModel? client,
    bool? isUpdating,
    ClientFollowUp? followUp,
    bool clearFollowUp = false,
    List<ClientNote>? notes,
  }) =>
      ClientDetailsSuccess(
        client: client ?? this.client,
        categories: categories,
        isUpdating: isUpdating ?? this.isUpdating,
        followUp: clearFollowUp ? null : (followUp ?? this.followUp),
        notes: notes ?? this.notes,
      );

  @override
  List<Object?> get props => [client, categories, isUpdating, followUp, notes];
}

final class ClientDetailsDeleted extends ClientDetailsState {
  const ClientDetailsDeleted();
}

final class ClientDetailsError extends ClientDetailsState {
  final String message;
  const ClientDetailsError(this.message);

  @override
  List<Object?> get props => [message];
}

part of 'profile_card_cubit.dart';

sealed class ProfileCardState extends Equatable {
  const ProfileCardState();

  @override
  List<Object?> get props => [];
}

final class ProfileCardInitial extends ProfileCardState {
  const ProfileCardInitial();
}

final class ProfileCardLoading extends ProfileCardState {
  const ProfileCardLoading();
}

final class ProfileCardSuccess extends ProfileCardState {
  final ProfileCardModel card;
  const ProfileCardSuccess(this.card);

  @override
  List<Object?> get props => [card];
}

final class ProfileCardError extends ProfileCardState {
  final String message;
  const ProfileCardError(this.message);

  @override
  List<Object?> get props => [message];
}

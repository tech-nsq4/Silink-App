part of 'contact_cubit.dart';

sealed class ContactState extends Equatable {
  const ContactState();

  @override
  List<Object?> get props => [];
}

final class ContactInitial extends ContactState {
  const ContactInitial();
}

final class ContactSending extends ContactState {
  const ContactSending();
}

final class ContactSent extends ContactState {
  const ContactSent();
}

final class ContactError extends ContactState {
  const ContactError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

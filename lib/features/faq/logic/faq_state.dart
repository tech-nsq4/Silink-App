part of 'faq_cubit.dart';

sealed class FaqState extends Equatable {
  const FaqState();

  @override
  List<Object?> get props => [];
}

final class FaqInitial extends FaqState {
  const FaqInitial();
}

final class FaqLoading extends FaqState {
  const FaqLoading();
}

final class FaqSuccess extends FaqState {
  final List<Faq> faqs;
  const FaqSuccess(this.faqs);

  @override
  List<Object?> get props => [faqs];
}

final class FaqError extends FaqState {
  final String message;
  const FaqError(this.message);

  @override
  List<Object?> get props => [message];
}

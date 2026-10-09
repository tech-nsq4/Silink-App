part of 'card_assistant_cubit.dart';

enum AssistantSource { description, link }

sealed class CardAssistantState extends Equatable {
  const CardAssistantState();

  @override
  List<Object?> get props => [];
}

final class CardAssistantInitial extends CardAssistantState {
  const CardAssistantInitial();
}

final class CardAssistantLoading extends CardAssistantState {
  final int completedSteps;
  const CardAssistantLoading(this.completedSteps);

  @override
  List<Object?> get props => [completedSteps];
}

final class CardAssistantSuccess extends CardAssistantState {
  final AssistantDraft draft;
  final AssistantSource source;
  const CardAssistantSuccess({required this.draft, required this.source});

  CardAssistantSuccess copyWith({AssistantDraft? draft}) =>
      CardAssistantSuccess(draft: draft ?? this.draft, source: source);

  @override
  List<Object?> get props => [draft, source];
}

final class CardAssistantError extends CardAssistantState {
  final String message;
  const CardAssistantError(this.message);

  @override
  List<Object?> get props => [message];
}

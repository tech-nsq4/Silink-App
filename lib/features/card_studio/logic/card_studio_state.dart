part of 'card_studio_cubit.dart';

enum StudioNextResult { moved, finished, blocked }

sealed class CardStudioState extends Equatable {
  const CardStudioState();

  @override
  List<Object?> get props => [];
}

final class CardStudioInitial extends CardStudioState {
  const CardStudioInitial();
}

final class CardStudioLoading extends CardStudioState {
  const CardStudioLoading();
}

final class CardStudioSuccess extends CardStudioState {
  final StudioDraft draft;
  final int step;
  final int minStep;
  final bool isRemote;
  final RegistrationTicket? ticket;
  final StudioDesignOptions? designOptions;
  final bool saving;
  final String? busyItemId;
  final String? error;

  const CardStudioSuccess({
    required this.draft,
    required this.step,
    required this.isRemote,
    this.minStep = 0,
    this.ticket,
    this.designOptions,
    this.saving = false,
    this.busyItemId,
    this.error,
  });

  CardStudioSuccess copyWith({
    StudioDraft? draft,
    int? step,
    int? minStep,
    bool? isRemote,
    RegistrationTicket? ticket,
    bool clearTicket = false,
    StudioDesignOptions? designOptions,
    bool? saving,
    String? busyItemId,
    bool clearBusyItem = false,
    String? error,
    bool clearError = false,
  }) =>
      CardStudioSuccess(
        draft: draft ?? this.draft,
        step: step ?? this.step,
        minStep: minStep ?? this.minStep,
        isRemote: isRemote ?? this.isRemote,
        ticket: clearTicket ? null : ticket ?? this.ticket,
        designOptions: designOptions ?? this.designOptions,
        saving: saving ?? this.saving,
        busyItemId: clearBusyItem ? null : busyItemId ?? this.busyItemId,
        error: clearError ? null : error ?? this.error,
      );

  @override
  List<Object?> get props => [
        draft,
        step,
        minStep,
        isRemote,
        ticket,
        designOptions,
        saving,
        busyItemId,
        error,
      ];
}

final class CardStudioError extends CardStudioState {
  final String message;
  const CardStudioError(this.message);

  @override
  List<Object?> get props => [message];
}

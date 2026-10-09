import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/locale_keys.dart';
import '../data/assistant_draft_parser.dart';
import '../data/models/assistant_draft.dart';

part 'card_assistant_state.dart';

class CardAssistantCubit extends Cubit<CardAssistantState> {
  CardAssistantCubit(this._parser) : super(const CardAssistantInitial());

  static const int processingSteps = 3;
  static const int _minDescriptionLength = 10;
  static const Duration _stepDuration = Duration(milliseconds: 450);
  static const Duration _processingDuration = Duration(milliseconds: 1500);

  final AssistantDraftParser _parser;
  Timer? _stepTimer;
  Timer? _doneTimer;

  Future<void> buildDraft({
    required AssistantSource source,
    required String description,
    required String link,
  }) async {
    final AssistantDraft draft;
    if (source == AssistantSource.description) {
      if (description.trim().length < _minDescriptionLength) {
        emit(CardAssistantError(
            LocaleKeys.cardAssistant_descriptionTooShort.tr()));
        return;
      }
      draft = _parser.fromDescription(description);
    } else {
      final uri = _parseLink(link);
      if (uri == null) {
        emit(CardAssistantError(LocaleKeys.cardAssistant_invalidLink.tr()));
        return;
      }
      final linked = _parser.fromLink(uri);
      if (linked == null) {
        emit(CardAssistantError(LocaleKeys.cardAssistant_linkUnavailable.tr()));
        return;
      }
      draft = linked;
    }
    _runProcessing(draft, source);
  }

  void _runProcessing(AssistantDraft draft, AssistantSource source) {
    _cancelTimers();
    var completed = 0;
    emit(const CardAssistantLoading(0));
    _stepTimer = Timer.periodic(_stepDuration, (_) {
      completed = (completed + 1).clamp(0, processingSteps - 1);
      emit(CardAssistantLoading(completed));
    });
    _doneTimer = Timer(_processingDuration, () {
      _stepTimer?.cancel();
      emit(CardAssistantSuccess(draft: draft, source: source));
    });
  }

  Uri? _parseLink(String value) {
    final text = value.trim();
    if (text.isEmpty) return null;
    final withScheme =
        RegExp(r'^https?://', caseSensitive: false).hasMatch(text)
            ? text
            : 'https://$text';
    final uri = Uri.tryParse(withScheme);
    if (uri == null || !uri.host.contains('.')) return null;
    return uri;
  }

  void updateDraft(AssistantDraft draft) {
    final current = state;
    if (current is CardAssistantSuccess) emit(current.copyWith(draft: draft));
  }

  void clearError() {
    if (state is CardAssistantError) emit(const CardAssistantInitial());
  }

  void backToInput() {
    _cancelTimers();
    emit(const CardAssistantInitial());
  }

  void _cancelTimers() {
    _stepTimer?.cancel();
    _doneTimer?.cancel();
  }

  @override
  Future<void> close() {
    _cancelTimers();
    return super.close();
  }
}

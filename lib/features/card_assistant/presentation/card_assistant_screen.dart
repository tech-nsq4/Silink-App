import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:Silink/core/utils/app_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/router/navigation_services.dart';
import '../../../app/router/routes.dart';
import '../../../core/di/injection.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/locale_keys.dart';
import '../../../core/widgets/creation_footer.dart';
import '../../../core/widgets/creation_header.dart';
import '../../../core/widgets/processing_steps_view.dart';
import '../data/assistant_draft_parser.dart';
import '../logic/card_assistant_cubit.dart';
import 'widgets/assistant_edit_sheet.dart';
import 'widgets/assistant_input_view.dart';
import 'widgets/assistant_preview_view.dart';

class CardAssistantScreen extends StatefulWidget {
  const CardAssistantScreen({super.key, required this.usageIntent});

  final String usageIntent;

  @override
  State<CardAssistantScreen> createState() => _CardAssistantScreenState();
}

class _CardAssistantScreenState extends State<CardAssistantScreen> {
  late final CardAssistantCubit _cubit = getIt<CardAssistantCubit>();
  final _descriptionCtrl = TextEditingController();
  final _linkCtrl = TextEditingController();
  AssistantSource _source = AssistantSource.description;

  @override
  void dispose() {
    _descriptionCtrl.dispose();
    _linkCtrl.dispose();
    _cubit.close();
    super.dispose();
  }

  bool get _hasInput => (_source == AssistantSource.description
          ? _descriptionCtrl.text
          : _linkCtrl.text)
      .trim()
      .isNotEmpty;

  void _onInputChanged(String _) {
    _cubit.clearError();
    setState(() {});
  }

  void _selectSource(AssistantSource source) {
    _cubit.clearError();
    setState(() => _source = source);
  }

  void _useSample(TextEditingController controller, String value) {
    controller.text = value;
    _onInputChanged(value);
  }

  void _build() {
    FocusScope.of(context).unfocus();
    _cubit.buildDraft(
      source: _source,
      description: _descriptionCtrl.text,
      link: _linkCtrl.text,
    );
  }

  Future<void> _edit(CardAssistantSuccess state, {String? error}) async {
    final updated = await AssistantEditSheet.show(context,
        draft: state.draft, error: error);
    if (updated != null) _cubit.updateDraft(updated);
  }

  void _approve(CardAssistantSuccess state) {
    if (!state.draft.isComplete) {
      _edit(state, error: LocaleKeys.cardAssistant_draftIncomplete.tr());
      return;
    }
    NavigationService.push(
      kIsGuest ? Routes.cardStudioScreen : Routes.portfolioStudioScreen,
      arguments: {'draft': state.draft.toStudioDraft()},
    );
  }

  void _onBack(CardAssistantState state) {
    if (state is CardAssistantSuccess) {
      _cubit.backToInput();
    } else {
      Navigator.of(context).maybePop();
    }
  }

  String _sourceNote(CardAssistantSuccess state) =>
      state.source == AssistantSource.description
          ? LocaleKeys.cardAssistant_noteFromDescription.tr()
          : LocaleKeys.cardAssistant_noteFromLink.tr();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CardAssistantCubit, CardAssistantState>(
      bloc: _cubit,
      builder: (context, state) {
        final isPreview = state is CardAssistantSuccess;
        final isLoading = state is CardAssistantLoading;
        return PopScope(
          canPop: !isPreview && !isLoading,
          onPopInvokedWithResult: (didPop, _) {
            if (!didPop && isPreview) _cubit.backToInput();
          },
          child: Scaffold(
            backgroundColor: AppColors.backgroundColor.themeColor,
            body: Column(
              children: [
                CreationHeader(
                  eyebrow: LocaleKeys.cardAssistant_headerEyebrow.tr(),
                  compact: isPreview,
                  title: switch (state) {
                    CardAssistantSuccess() =>
                      LocaleKeys.cardAssistant_titlePreview.tr(),
                    CardAssistantLoading() =>
                      LocaleKeys.cardAssistant_titleProcessing.tr(),
                    _ => LocaleKeys.cardAssistant_titleInput.tr(),
                  },
                  badge: isPreview
                      ? LocaleKeys.cardAssistant_badgeDraft.tr()
                      : LocaleKeys.cardAssistant_badgeSmart.tr(),
                  onBack: isLoading ? null : () => _onBack(state),
                ),
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    child: switch (state) {
                      CardAssistantLoading(:final completedSteps) =>
                        ProcessingStepsView(
                          key: const ValueKey('processing'),
                          title: LocaleKeys.cardAssistant_processingTitle.tr(),
                          body: LocaleKeys.cardAssistant_processingBody.tr(),
                          steps: [
                            LocaleKeys.cardAssistant_processingStep1.tr(),
                            LocaleKeys.cardAssistant_processingStep2.tr(),
                            LocaleKeys.cardAssistant_processingStep3.tr(),
                          ],
                          completedSteps: completedSteps,
                        ),
                      CardAssistantSuccess() => AssistantPreviewView(
                          key: const ValueKey('preview'),
                          draft: state.draft,
                          onEdit: () => _edit(state),
                        ),
                      _ => AssistantInputView(
                          key: const ValueKey('input'),
                          source: _source,
                          descriptionController: _descriptionCtrl,
                          linkController: _linkCtrl,
                          onSourceChanged: _selectSource,
                          onChanged: _onInputChanged,
                          onUseSampleDescription: () => _useSample(
                            _descriptionCtrl,
                            AssistantDraftParser.sampleDescription,
                          ),
                          onUseSampleLink: () => _useSample(
                            _linkCtrl,
                            AssistantDraftParser.sampleLink,
                          ),
                          error: state is CardAssistantError
                              ? state.message
                              : null,
                        ),
                    },
                  ),
                ),
                switch (state) {
                  CardAssistantLoading() => const SizedBox.shrink(),
                  CardAssistantSuccess() => CreationFooter(
                      title: LocaleKeys.cardAssistant_approveCta.tr(),
                      note: _sourceNote(state),
                      onTap: () => _approve(state),
                    ),
                  _ => CreationFooter(
                      title: LocaleKeys.cardAssistant_buildCta.tr(),
                      note: LocaleKeys.cardAssistant_buildNote.tr(),
                      icon: Icons.auto_awesome_outlined,
                      enabled: _hasInput,
                      onTap: _build,
                    ),
                },
              ],
            ),
          ),
        );
      },
    );
  }
}

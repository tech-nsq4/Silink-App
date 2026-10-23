import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/router/routes.dart';
import '../../../core/di/injection.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/locale_keys.dart';
import '../../../core/widgets/flow_footer.dart';
import '../../../core/widgets/flow_top_bar.dart';
import '../../../core/widgets/screen_state_layout.dart';
import '../data/models/studio_draft.dart';
import '../../profile/logic/profile_cubit.dart';
import '../data/models/studio_item.dart';
import '../logic/card_studio_cubit.dart';
import 'widgets/studio_contact_step.dart';
import 'widgets/studio_content_step.dart';
import 'widgets/studio_design_step.dart';
import 'widgets/studio_identity_step.dart';
import 'widgets/studio_item_sheet.dart';
import 'widgets/studio_live_identity.dart';
import 'widgets/studio_saving_badge.dart';
import 'widgets/studio_stepper.dart';
import 'widgets/studio_verify_step.dart';

class CardStudioScreen extends StatefulWidget {
  const CardStudioScreen({
    super.key,
    this.remote = false,
    this.resume = false,
    this.initialDraft,
    this.cubit,
    this.portfolioMode = false,
    this.onFinished,
  });

  final bool remote;
  final bool resume;
  final StudioDraft? initialDraft;
  final CardStudioCubit? cubit;
  final bool portfolioMode;
  final VoidCallback? onFinished;

  @override
  State<CardStudioScreen> createState() => _CardStudioScreenState();
}

class _CardStudioScreenState extends State<CardStudioScreen> {
  late final CardStudioCubit _cubit = widget.cubit ?? getIt<CardStudioCubit>();
  String _otpCode = '';

  List<String> get _stepLabels => [
        LocaleKeys.cardStudio_stepIdentity.tr(),
        LocaleKeys.cardStudio_stepVerify.tr(),
        LocaleKeys.cardStudio_stepContact.tr(),
        LocaleKeys.cardStudio_stepContent.tr(),
        LocaleKeys.cardStudio_stepDesign.tr(),
      ];

  List<int> get _visibleSteps => [
        for (var step = 0; step < _stepLabels.length; step++)
          if (!((widget.remote || widget.portfolioMode) &&
              step == CardStudioCubit.verifyStep))
            step,
      ];

  int _displayIndex(int step) {
    final index = _visibleSteps.indexOf(step);
    return index < 0 ? 0 : index;
  }

  @override
  void initState() {
    super.initState();
    if (widget.remote) {
      _cubit.startRemote(resume: widget.resume);
    } else {
      _cubit.startLocal(initial: widget.initialDraft);
    }
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  Future<void> _next() async {
    if (_cubit.needsAccount) {
      await _cubit.register();
      return;
    }
    if (_cubit.needsVerification) {
      final user = await _cubit.verify(_otpCode);
      if (user != null && mounted) context.read<ProfileCubit>().setUser(user);
      return;
    }
    final result = await _cubit.next();
    if (result != StudioNextResult.finished || !mounted) return;
    final onFinished = widget.onFinished;
    if (onFinished != null) {
      onFinished();
      return;
    }
    Navigator.pushReplacementNamed(
      context,
      Routes.profileCardScreen,
      arguments: {'fromStudio': true},
    );
  }

  void _back() {
    if (!_cubit.back()) Navigator.of(context).maybePop();
  }

  Future<void> _addItem() async {
    final item = await StudioItemSheet.show(context);
    if (item != null) _cubit.addItem(item);
  }

  Future<void> _editItem(StudioItem item) async {
    final updated = await StudioItemSheet.show(context, item: item);
    if (updated != null) _cubit.updateItem(updated);
  }

  Widget _stepView(CardStudioSuccess state) {
    final draft = state.draft;
    return switch (state.step) {
      CardStudioCubit.identityStep => StudioIdentityStep(
          key: ValueKey('identity-${state.isRemote}'),
          draft: draft,
          withAccount: !state.isRemote && !widget.portfolioMode,
          onChanged: _cubit.update,
        ),
      CardStudioCubit.verifyStep => StudioVerifyStep(
          key: const ValueKey('verify'),
          phone: state.ticket?.phone ?? draft.phone,
          expiresAt: state.ticket?.expiresAt,
          codeLength: CardStudioCubit.otpLength,
          onChanged: (code) => _otpCode = code,
        ),
      CardStudioCubit.contactStep => StudioContactStep(
          key: const ValueKey('contact'),
          draft: draft,
          onChanged: _cubit.update,
        ),
      CardStudioCubit.contentStep => StudioContentStep(
          key: const ValueKey('content'),
          items: draft.items,
          servicesEnabled: draft.servicesEnabled,
          productsEnabled: draft.productsEnabled,
          onToggleCatalog: _cubit.toggleCatalog,
          busyItemId: state.busyItemId,
          onAdd: _addItem,
          onEdit: _editItem,
          onDelete: _cubit.removeItem,
          onReorder: _cubit.reorderItems,
        ),
      _ => StudioDesignStep(
          key: const ValueKey('design'),
          draft: draft,
          options: state.designOptions,
          loadingOptions: state.isRemote && state.designOptions == null,
          onTemplateSelected: _cubit.selectTemplate,
          onAppearanceChanged: _cubit.updateAppearance,
          onChanged: _cubit.update,
          onReorderSections: _cubit.reorderSections,
        ),
    };
  }

  String _nextLabel(int step) {
    final next = _cubit.nextStep;
    if (step >= CardStudioCubit.lastStep || next == null) {
      return LocaleKeys.cardStudio_reviewCardCta.tr();
    }
    return LocaleKeys.cardStudio_nextPrefix.tr(args: [_stepLabels[next]]);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CardStudioCubit, CardStudioState>(
      bloc: _cubit,
      builder: (context, state) {
        final ready = state is CardStudioSuccess ? state : null;
        final step = ready?.step ?? 0;
        return PopScope(
          canPop: step <= (ready?.minStep ?? 0),
          onPopInvokedWithResult: (didPop, _) {
            if (!didPop) _cubit.back();
          },
          child: Scaffold(
            backgroundColor: AppColors.backgroundColor.themeColor,
            body: Column(
              children: [
                SafeArea(
                  bottom: false,
                  child: FlowTopBar(
                    eyebrow: LocaleKeys.cardStudio_headerStep.tr(args: [
                      '${_displayIndex(step) + 1}',
                      '${_visibleSteps.length}',
                    ]),
                    title: LocaleKeys.cardStudio_headerTitle.tr(),
                    onBack: _back,
                    action: StudioSavingBadge(
                      label: LocaleKeys.cardStudio_draftBadge.tr(),
                    ),
                  ),
                ),
                Expanded(
                  child: CustomScreenStateLayout(
                    isLoading: state is CardStudioLoading ||
                        state is CardStudioInitial,
                    error: state is CardStudioError
                        ? ErrorModel(
                            code: ErrorEnum.otherError,
                            errorMessage: state.message,
                          )
                        : null,
                    onRetry: () => _cubit.startRemote(resume: widget.resume),
                    builder: (context) => ListView(
                      padding: EdgeInsets.fromLTRB(22.w, 12.h, 22.w, 25.h),
                      children: [
                        if (step < CardStudioCubit.lastStep)
                          StudioLiveIdentity(draft: ready!.draft),
                        StudioStepper(
                          labels: [
                            for (final visible in _visibleSteps)
                              _stepLabels[visible],
                          ],
                          current: _displayIndex(step),
                          onTap: (index) => _cubit.goTo(_visibleSteps[index]),
                        ),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 220),
                          child: _stepView(ready!),
                        ),
                      ],
                    ),
                  ),
                ),
                if (ready != null)
                  FlowFooter(
                    title: _nextLabel(step),
                    loading: ready.saving,
                    error: ready.error,
                    onTap: _next,
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

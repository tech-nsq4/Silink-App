import 'dart:ui' as ui;

import 'package:Silink/app/router/routes.dart';
import 'package:Silink/core/di/injection.dart';
import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/app_constants.dart';
import 'package:Silink/core/utils/app_overlay.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_button.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:Silink/features/profile_completion/logic/profile_completion_cubit.dart';
import 'package:Silink/features/profile_completion/data/models/profile_completion_data.dart';
import 'package:Silink/features/profile_completion/presentation/appearance_screen.dart';
import 'package:Silink/features/profile_completion/presentation/contact_channels_screen.dart';
import 'package:Silink/features/profile_completion/presentation/contact_links_screen.dart';
import 'package:Silink/features/profile_completion/presentation/content_ranking_screen.dart';
import 'package:Silink/features/profile_completion/presentation/products_screen.dart';
import 'package:Silink/features/profile_completion/presentation/publish_screen.dart';
import 'package:Silink/features/profile_completion/presentation/template_selection_screen.dart';
import 'package:Silink/features/profile_completion/presentation/widgets/publish_toolbar.dart';
import 'package:Silink/core/widgets/step_header.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';

class ProfileCompletionScreen extends StatefulWidget {
  const ProfileCompletionScreen({super.key});

  @override
  State<ProfileCompletionScreen> createState() =>
      _ProfileCompletionScreenState();
}

class _ProfileCompletionScreenState extends State<ProfileCompletionScreen> {
  static const int totalSteps = 7;

  final ProfileCompletionData _data = ProfileCompletionData();
  final GlobalKey _shareCardKey = GlobalKey();
  late final ProfileCompletionCubit _cubit = getIt<ProfileCompletionCubit>();
  int _currentStep = 1;
  bool _isSharing = false;
  late final Set<int> _visitedSteps = {0};
  late final List<Widget> _stepWidgets = [
    const ContactChannelsStep(),
    const ContactLinksStep(),
    const ProductsStep(),
    const ContentRankingStep(),
    const TemplateSelectionStep(),
    AppearanceStep(data: _data),
    PublishStep(
      data: _data,
      repaintKey: _shareCardKey,
      onViewAllProducts: () => setState(() => _currentStep = 3),
    ),
  ];

  String get _headerTitle {
    switch (_currentStep) {
      case 1:
        return LocaleKeys.channels_title.tr();
      case 2:
        return LocaleKeys.links_title.tr();
      case 3:
        return LocaleKeys.products_title.tr();
      case 4:
        return LocaleKeys.ranking_title.tr();
      case 5:
        return LocaleKeys.template_title.tr();
      case 6:
        return LocaleKeys.appearance_title.tr();
      default:
        return '';
    }
  }

  String get _nextButtonLabel {
    if (_currentStep == totalSteps - 1) {
      return LocaleKeys.appearance_previewProfile.tr();
    }
    return LocaleKeys.onboarding_next.tr();
  }

  String get _profileHandle {
    final trimmed = _data.fullName.trim();
    return trimmed.isEmpty ? 'demo-profile' : trimmed.replaceAll(' ', '-');
  }

  Future<void> _handleNext() async {
    final ok = await _cubit.saveStep(_currentStep);
    if (!ok || !mounted) return;
    if (_currentStep < totalSteps) {
      setState(() {
        _currentStep++;
        _visitedSteps.add(_currentStep - 1);
      });
    }
  }

  void _handleBack() {
    if (_currentStep > 1) {
      setState(() => _currentStep--);
    } else {
      Navigator.of(context).maybePop();
    }
  }

  void _handleCopyLink() {
    Clipboard.setData(ClipboardData(text: 'silink.sa/$_profileHandle'));
    AppOverlay.showSuccess(LocaleKeys.publish_linkCopied.tr());
  }

  void _handleViewAsVisitor() {
    AppOverlay.showSuccess(LocaleKeys.common_comingSoon.tr());
  }

  void _handleFinish() {
    context.pushNamedAndRemoveUntil(
      Routes.layoutScreen,
      predicate: (_) => false,
    );
  }

  Future<void> _handleShare() async {
    if (_isSharing) return;
    setState(() => _isSharing = true);
    try {
      await WidgetsBinding.instance.endOfFrame;
      final boundary = _shareCardKey.currentContext?.findRenderObject()
          as RenderRepaintBoundary?;
      if (boundary == null) {
        throw StateError('card not ready');
      }
      final image = await boundary.toImage(pixelRatio: 3);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData == null) throw StateError('failed to encode image');
      final bytes = byteData.buffer.asUint8List();

      final email = kUserModel?.email;
      final caption = [
        _data.fullName.trim().isEmpty ? AppConstants.appName : _data.fullName.trim(),
        if (email != null && email.trim().isNotEmpty) email.trim(),
        AppConstants.appName,
        'silink.sa/$_profileHandle',
      ].join('\n');

      await Share.shareXFiles(
        [XFile.fromData(bytes, name: 'silink-card.png', mimeType: 'image/png')],
        text: caption,
        fileNameOverrides: const ['silink-card.png'],
      );
    } catch (_) {
      if (mounted) AppOverlay.showError(LocaleKeys.common_somethingWentWrong.tr());
    } finally {
      if (mounted) setState(() => _isSharing = false);
    }
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  PreferredSizeWidget get _appBar {
    if (_currentStep == totalSteps) {
      return PublishToolbar(
        onBack: _handleBack,
        onViewAsVisitor: _handleViewAsVisitor,
        onCopyLink: _handleCopyLink,
        onFinish: _handleFinish,
      );
    }
    return StepHeader(
      title: _headerTitle,
      step: _currentStep,
      totalSteps: totalSteps,
      onBack: _handleBack,
      onClose: () => Navigator.of(context).maybePop(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        appBar: _appBar,
        body: IndexedStack(
          index: _currentStep - 1,
          children: [
            for (int i = 0; i < totalSteps; i++)
              _visitedSteps.contains(i) ? _stepWidgets[i] : const SizedBox.shrink(),
          ],
        ),
        bottomNavigationBar: _currentStep == totalSteps
            ? Container(
                color: AppColors.white.themeColor,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                  child: CustomButton(
                    onTap: _handleShare,
                    height: 54,
                    radius: 14,
                    loading: _isSharing,
                    child: _isSharing
                        ? null
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.ios_share,
                                  size: 18, color: Colors.white),
                              SizedBox(width: 8.w),
                              AppText(
                                LocaleKeys.publish_shareCta.tr(),
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ],
                          ),
                  ),
                ),
              )
            : Container(
                color: AppColors.white.themeColor,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
                  child: BlocBuilder<ProfileCompletionCubit, ProfileCompletionState>(
                    builder: (context, state) => CustomButton(
                      onTap: _handleNext,
                      title: state.isSavingStep ? null : _nextButtonLabel,
                      loading: state.isSavingStep,
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}

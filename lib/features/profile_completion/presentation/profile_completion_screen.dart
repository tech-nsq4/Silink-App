import 'package:Silink/app/router/navigation_services.dart';
import 'package:Silink/app/router/routes.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/app_overlay.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_button.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:Silink/features/profile_completion/models/profile_completion_data.dart';
import 'package:Silink/features/profile_completion/presentation/appearance_screen.dart';
import 'package:Silink/features/profile_completion/presentation/contact_channels_screen.dart';
import 'package:Silink/features/profile_completion/presentation/contact_links_screen.dart';
import 'package:Silink/features/profile_completion/presentation/content_ranking_screen.dart';
import 'package:Silink/features/profile_completion/presentation/products_screen.dart';
import 'package:Silink/features/profile_completion/presentation/publish_screen.dart';
import 'package:Silink/features/profile_completion/presentation/template_selection_screen.dart';
import 'package:Silink/features/profile_completion/presentation/widgets/publish_toolbar.dart';
import 'package:Silink/features/profile_completion/presentation/widgets/step_header.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileCompletionScreen extends StatefulWidget {
  const ProfileCompletionScreen({super.key});

  @override
  State<ProfileCompletionScreen> createState() =>
      _ProfileCompletionScreenState();
}

class _ProfileCompletionScreenState extends State<ProfileCompletionScreen> {
  static const int totalSteps = 7;

  final ProfileCompletionData _data = ProfileCompletionData();
  int _currentStep = 1;

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

  void _handleNext() {
    if (_currentStep < totalSteps) {
      setState(() => _currentStep++);
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
    final handle = _data.fullName.trim().isEmpty
        ? 'demo-profile'
        : _data.fullName.trim().replaceAll(' ', '-');
    Clipboard.setData(ClipboardData(text: 'silink.app/$handle'));
    AppOverlay.showSuccess(LocaleKeys.publish_linkCopied.tr());
  }

  void _handleSaveAndPublish() {
    AppOverlay.showSuccess(LocaleKeys.publish_publishedSuccess.tr());
    NavigationService.push(Routes.publishCardScreen , arguments: {'data': _data});
  }

  void _handleViewAsVisitor() {
    AppOverlay.showSuccess(LocaleKeys.common_comingSoon.tr());
  }

  PreferredSizeWidget get _appBar {
    if (_currentStep == totalSteps) {
      return PublishToolbar(
        onBack: _handleBack,
        onSaveAndPublish: _handleSaveAndPublish,
        onViewAsVisitor: _handleViewAsVisitor,
        onCopyLink: _handleCopyLink,
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
    return Scaffold(
      appBar: _appBar,
      body: IndexedStack(
        index: _currentStep - 1,
        children: [
          ContactChannelsStep(data: _data),
          ContactLinksStep(data: _data),
          ProductsStep(data: _data),
          ContentRankingStep(data: _data),
          TemplateSelectionStep(data: _data),
          AppearanceStep(data: _data),
          PublishStep(
            data: _data,
            onViewAllProducts: () => setState(() => _currentStep = 3),
          ),
        ],
      ),
      bottomNavigationBar: _currentStep == totalSteps
          ? Container(
              color: AppColors.white.themeColor,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                child: CustomButton(
                  onTap: _handleCopyLink,
                  height: 54,
                  radius: 14,
                  child: Row(
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
                child: CustomButton(
                  onTap: _handleNext,
                  title: _nextButtonLabel,
                  // height: 54,
                  // radius: 14,
                ),
              ),
            ),
    );
  }
}

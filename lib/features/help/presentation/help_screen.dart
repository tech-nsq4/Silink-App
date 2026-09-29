import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/di/injection.dart';
import '../../../core/extensions/extensions.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_images.dart';
import '../../../core/utils/app_overlay.dart';
import '../../../core/utils/locale_keys.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/screen_header_bar.dart';
import '../../account/widgets/account_menu_tile.dart';
import '../../account/widgets/account_section_card.dart';
import '../../faq/logic/faq_cubit.dart';
import '../../faq/widgets/faq_section.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  /// App version shown at the bottom of the screen (mirrors pubspec.yaml).
  static const String appVersion = '1.0.0';

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  late final TextEditingController _subjectController;
  late final TextEditingController _messageController;
  late final FaqCubit _faqCubit = getIt<FaqCubit>()..getFaqs();

  @override
  void initState() {
    super.initState();
    _subjectController = TextEditingController()..addListener(_rebuild);
    _messageController = TextEditingController()..addListener(_rebuild);
  }

  void _rebuild() => setState(() {});

  bool get _canSend =>
      _subjectController.text.trim().isNotEmpty &&
      _messageController.text.trim().isNotEmpty;

  @override
  void dispose() {
    _subjectController.dispose();
    _messageController.dispose();
    _faqCubit.close();
    super.dispose();
  }

  void _showComingSoon() {
    AppOverlay.showSuccess(LocaleKeys.common_comingSoon.tr());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ScreenHeaderBar(title: LocaleKeys.help_title.tr()),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _faqCubit.refresh,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 19.w, vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    FaqSection(cubit: _faqCubit),
                    // ── Contact form ───────────────────────────────────
                    AppText(
                      LocaleKeys.help_contactSection.tr(),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textSecondaryColor.themeColor,
                    ),
                    10.height,
                    AccountSectionCard(
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      children: [
                        Column(
                          children: [
                            CustomTextField(
                              controller: _subjectController,
                              hint: LocaleKeys.help_subjectHint.tr(),
                            ),
                            12.height,
                            CustomTextField(
                              controller: _messageController,
                              hint: LocaleKeys.help_messageHint.tr(),
                              maxLines: 5,
                            ),
                            14.height,
                            CustomButton(
                              onTap: _canSend ? _showComingSoon : () {},
                              title: LocaleKeys.help_send.tr(),
                              color: _canSend
                                  ? null
                                  : Color(0xFFcbd5e1).withValues(alpha: 0.5),
                              textColor:
                                  _canSend ? null : AppColors.white.themeColor,
                            ),
                          ],
                        ),
                      ],
                    ),
                    18.height,
                    // ── Quick links ────────────────────────────────────
                    AccountSectionCard(
                      children: [
                        AccountMenuTile(
                          icon: AppImages.iconsCard,
                          label: LocaleKeys.help_nfcGuide.tr(),
                          onTap: _showComingSoon,
                        ),
                        AccountMenuTile(
                          icon: AppImages.iconsInfo,
                          label: LocaleKeys.help_reportProblem.tr(),
                          onTap: _showComingSoon,
                        ),
                        AccountMenuTile(
                          icon: AppImages.iconsDoc,
                          label: LocaleKeys.help_termsOfUse.tr(),
                          onTap: _showComingSoon,
                        ),
                        AccountMenuTile(
                          icon: AppImages.iconsPrivacy,
                          label: LocaleKeys.help_privacyPolicy.tr(),
                          onTap: _showComingSoon,
                        ),
                      ],
                    ),
                    24.height,
                    AppText(
                      '${LocaleKeys.help_version.tr()} ${HelpScreen.appVersion}',
                      fontSize: 12,
                      color: AppColors.textSecondaryColor.themeColor,
                      textAlign: TextAlign.center,
                    ),
                    24.height,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

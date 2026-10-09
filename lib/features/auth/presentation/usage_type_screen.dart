import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/router/navigation_services.dart';
import '../../../app/router/routes.dart';
import '../../../core/extensions/extensions.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/locale_keys.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/gradient_action_button.dart';
import 'widgets/auth_top_bar.dart';
import 'widgets/usage_option_card.dart';
import 'widgets/usage_path_preview.dart';

class UsageTypeScreen extends StatefulWidget {
  const UsageTypeScreen({super.key});

  @override
  State<UsageTypeScreen> createState() => _UsageTypeScreenState();
}

class _UsageTypeScreenState extends State<UsageTypeScreen> {
  bool _isPersonal = true;

  void _continue() {
    if (_isPersonal) {
      NavigationService.push(
        Routes.newCardStartScreen,
        arguments: {'usageIntent': 'personal'},
      );
      return;
    }
    NavigationService.push(Routes.registerScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor.themeColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AuthTopBar(tagline: LocaleKeys.role_headerTagline.tr()),
            Expanded(
              child: ListView(
                padding: EdgeInsets.fromLTRB(24.w, 10.h, 24.w, 24.h),
                children: [
                  AppText(
                    LocaleKeys.role_eyebrow.tr(),
                    fontSize: 9.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.accentTeal.themeColor,
                  ),
                  SizedBox(height: 16.h),
                  AppText(
                    LocaleKeys.role_headline.tr(),
                    fontSize: 39.sp,
                    fontWeight: FontWeight.w800,
                    height: 1.2,
                    letterSpacing: -1,
                  ),
                  SizedBox(height: 13.h),
                  AppText(
                    LocaleKeys.role_intro.tr(),
                    fontSize: 10.sp,
                    height: 1.8,
                    color: AppColors.pathBody.themeColor,
                  ),
                  SizedBox(height: 27.h),
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: UsageOptionCard(
                            number: '01',
                            icon: Icons.work_outline_rounded,
                            title: LocaleKeys.role_personalOption.tr(),
                            body: LocaleKeys.role_personalOptionBody.tr(),
                            selected: _isPersonal,
                            onTap: () => setState(() => _isPersonal = true),
                          ),
                        ),
                        10.width,
                        Expanded(
                          child: UsageOptionCard(
                            number: '02',
                            icon: Icons.apartment_outlined,
                            title: LocaleKeys.role_teamOption.tr(),
                            body: LocaleKeys.role_teamOptionBody.tr(),
                            selected: !_isPersonal,
                            onTap: () => setState(() => _isPersonal = false),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 27.h),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: UsagePathPreview(
                      key: ValueKey(_isPersonal),
                      icon: _isPersonal
                          ? Icons.auto_awesome_outlined
                          : Icons.group_outlined,
                      title: _isPersonal
                          ? LocaleKeys.role_personalPathTitle.tr()
                          : LocaleKeys.role_teamPathTitle.tr(),
                      steps: _isPersonal
                          ? LocaleKeys.role_personalPathSteps.tr()
                          : LocaleKeys.role_teamPathSteps.tr(),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  GradientActionButton(
                    title: _isPersonal
                        ? LocaleKeys.role_personalCta.tr()
                        : LocaleKeys.role_teamCta.tr(),
                    onTap: _continue,
                  ),
                  SizedBox(height: 11.h),
                  AppText(
                    LocaleKeys.role_controlNote.tr(),
                    fontSize: 8.sp,
                    textAlign: TextAlign.center,
                    color: AppColors.choiceBody.themeColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

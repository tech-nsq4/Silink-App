import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/extensions/extensions.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_overlay.dart';
import '../../../core/utils/locale_keys.dart';
import '../../../app/router/routes.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/custom_tap_effect.dart';
import '../../../core/widgets/screen_header_bar.dart';
import 'widgets/security_card.dart';
import 'widgets/security_row.dart';
import 'widgets/settings_account_actions.dart';
import 'widgets/settings_group_title.dart';

class PrivacySecurityScreen extends StatelessWidget {
  const PrivacySecurityScreen({super.key});

  void _comingSoon() =>
      AppOverlay.showSuccess(LocaleKeys.common_comingSoon.tr());

  String get _deviceName => switch (defaultTargetPlatform) {
        TargetPlatform.iOS => 'iPhone',
        TargetPlatform.android => 'Android',
        TargetPlatform.macOS => 'Mac',
        _ => 'Web',
      };

  Widget _switch(bool value) => Transform.scale(
        scale: 0.8,
        child: Switch.adaptive(
          value: value,
          activeTrackColor: AppColors.accentTeal.themeColor,
          onChanged: (_) => _comingSoon(),
        ),
      );

  Widget _chevron() => Icon(
        Icons.chevron_left_rounded,
        size: 18.sp,
        color: AppColors.studioRowIcon.themeColor,
      );

  @override
  Widget build(BuildContext context) {
    final accent = AppColors.accentTeal.themeColor;
    final error = AppColors.errorColor.themeColor;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor.themeColor,
      body: Column(
        children: [
          ScreenHeaderBar(title: LocaleKeys.settings_privacySecurity.tr()),
          Expanded(
            child: ListView(
              padding: EdgeInsets.fromLTRB(19.w, 16.h, 19.w, 28.h),
              children: [
                SecurityCard(
                  children: [
                    SecurityRow(
                      icon: Icons.lock_outline_rounded,
                      title: LocaleKeys.securityHub_password.tr(),
                      onTap: () =>
                          context.pushNamed(Routes.changePasswordScreen),
                      trailing: AppText(
                        LocaleKeys.securityHub_change.tr(),
                        fontSize: 9.5.sp,
                        fontWeight: FontWeight.w800,
                        color: accent,
                      ),
                    ),
                    SecurityRow(
                      icon: Icons.shield_outlined,
                      title: LocaleKeys.securityHub_twoFactor.tr(),
                      subtitle: LocaleKeys.securityHub_disabled.tr(),
                      trailing: _switch(false),
                    ),
                  ],
                ),
                12.height,
                SecurityCard(
                  children: [
                    SecurityRow(
                      icon: Icons.visibility_outlined,
                      title: LocaleKeys.securityHub_profilePrivacy.tr(),
                      subtitle: LocaleKeys.securityHub_publicProfile.tr(),
                      trailing: _switch(true),
                    ),
                  ],
                ),
                20.height,
                SettingsGroupTitle(LocaleKeys.securityHub_devices.tr()),
                SecurityCard(
                  children: [
                    SecurityRow(
                      icon: Icons.smartphone_rounded,
                      title: _deviceName,
                      subtitle: LocaleKeys.securityHub_now.tr(),
                      badge: LocaleKeys.securityHub_currentDevice.tr(),
                    ),
                  ],
                ),
                12.height,
                CustomTapEffect(
                  onTap: _comingSoon,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 13.h),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: error.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(14.r),
                      border: Border.all(color: error.withValues(alpha: 0.25)),
                    ),
                    child: AppText(
                      LocaleKeys.securityHub_logoutAll.tr(),
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w800,
                      color: error,
                    ),
                  ),
                ),
                20.height,
                SettingsGroupTitle(LocaleKeys.securityHub_dataSection.tr()),
                SecurityCard(
                  children: [
                    SecurityRow(
                      icon: Icons.download_outlined,
                      title: LocaleKeys.securityHub_downloadData.tr(),
                      onTap: _comingSoon,
                      trailing: _chevron(),
                    ),
                    SecurityRow(
                      icon: Icons.delete_outline_rounded,
                      title: LocaleKeys.settings_deleteAccount.tr(),
                      destructive: true,
                      onTap: () =>
                          SettingsAccountActions.deleteAccount(context),
                      trailing: _chevron(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

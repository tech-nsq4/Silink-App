import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/router/routes.dart';
import '../../../core/extensions/extensions.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/locale_keys.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/screen_header_bar.dart';
import '../widgets/account_guest_actions.dart';

class AccountGuestScreen extends StatelessWidget {
  const AccountGuestScreen({super.key, this.showBack = true});

  final bool showBack;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ScreenHeaderBar(
              title: LocaleKeys.account_guestTitle.tr(),
              showBack: showBack,
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 19.w, vertical: 24.h),
                child: Column(
                  children: [
                    40.height,
                    const _GuestAvatar(),
                    24.height,
                    AppText(
                      LocaleKeys.account_welcome.tr(),
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                    10.height,
                    AppText(
                      LocaleKeys.account_guestSubtitle.tr(),
                      fontSize: 13,
                      height: 1.7,
                      color: AppColors.textSecondaryColor.themeColor,
                      textAlign: TextAlign.center,
                    ),
                    32.height,
                    AccountGuestActions(
                      onCreateAccountTap: () =>
                          context.pushNamed(Routes.registerScreen),
                      onSignInTap: () => context.pushNamed(Routes.loginScreen),
                      onContinueAsGuestTap: () =>
                          context.pushNamedAndRemoveUntil(
                            Routes.layoutScreen,
                            predicate: (_) => false,
                          ),
                      onChangeUsageTypeTap: () =>
                          context.pushNamed(Routes.usageTypeScreen),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Light circular avatar with a person icon (guest placeholder).
class _GuestAvatar extends StatelessWidget {
  const _GuestAvatar();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.w,
      height: 80.w,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Color(0xFFE2E8F0),
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.person_outline_rounded,
        size: 34.sp,
        color: AppColors.textSecondaryColor.themeColor,
      ),
    );
  }
}

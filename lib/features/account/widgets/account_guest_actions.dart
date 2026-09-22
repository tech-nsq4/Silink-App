import 'package:Silink/core/utils/locale_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/extensions/extensions.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/custom_tap_effect.dart';
import '../../auth/presentation/widgets/dashed_guest_button.dart';

class AccountGuestActions extends StatelessWidget {
  const AccountGuestActions({
    super.key,
    this.onCreateAccountTap,
    this.onSignInTap,
    this.onContinueAsGuestTap,
    this.onChangeUsageTypeTap,
  });

  final VoidCallback? onCreateAccountTap;
  final VoidCallback? onSignInTap;
  final VoidCallback? onContinueAsGuestTap;
  final VoidCallback? onChangeUsageTypeTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Create account — brand gradient (blue → teal) as in the design.
        CustomTapEffect(
          onTap: onCreateAccountTap ?? () {},
          child: Container(
            height: 54.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              gradient: const LinearGradient(
                colors: [Color(0xff2368E2), Color(0xff2C9092)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: AppText(
              LocaleKeys.auth_register.tr(),
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
        14.height,
        // Sign in — white button with light border.
        DashedGuestButton(
          label: LocaleKeys.auth_login.tr(),
          onTap: onSignInTap ?? () {},
        ),
        28.height,
        // Continue as guest — plain text action.
        CustomTapEffect(
          onTap: onContinueAsGuestTap ?? () {},
          child: AppText(
            LocaleKeys.account_continueAsGuest.tr(),
            fontSize: 13.5,
            fontWeight: FontWeight.w700,
          ),
        ),
        32.height,
        // Change usage type — green text action.
        CustomTapEffect(
          onTap: onChangeUsageTypeTap ?? () {},
          child: AppText(
            LocaleKeys.account_changeUsageType.tr(),
            fontSize: 13.5,
            fontWeight: FontWeight.w700,
            color: AppColors.mint.themeColor,
          ),
        ),
      ],
    );
  }
}

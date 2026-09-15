import 'package:easy_localization/easy_localization.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterTermsNotice extends StatelessWidget {
  const RegisterTermsNotice({super.key});

  @override
  Widget build(BuildContext context) {
    final baseStyle = TextStyle(
      fontFamily: 'Tajawal',
      fontSize: 12.sp,
      fontWeight: FontWeight.w500,
      color: AppColors.textSecondaryColor.themeColor,
    );
    final linkStyle = baseStyle.copyWith(
      color: AppColors.mint.themeColor,
      fontWeight: FontWeight.w700,
    );

    return Center(
      child: Text.rich(
        TextSpan(
          style: baseStyle,
          children: [
            TextSpan(text: '${LocaleKeys.auth_termsAgreePrefix.tr()} '),
            TextSpan(
                text: LocaleKeys.auth_termsOfService.tr(), style: linkStyle),
            TextSpan(text: ' ${LocaleKeys.auth_termsAnd.tr()} '),
            TextSpan(
                text: LocaleKeys.auth_privacyPolicy.tr(), style: linkStyle),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

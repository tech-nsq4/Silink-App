import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_text.dart';

class AuthTermsNote extends StatelessWidget {
  const AuthTermsNote({super.key});

  @override
  Widget build(BuildContext context) {
    return AppText(
      LocaleKeys.auth_termsNote.tr(),
      fontSize: 8.sp,
      height: 1.8,
      textAlign: TextAlign.center,
      color: AppColors.subtleText.themeColor,
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'auth_logo_badge.dart';

class RegisterHeader extends StatelessWidget {
  const RegisterHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AuthLogoBadge(),
        24.height,
        AppText(
          LocaleKeys.auth_register.tr(),
          fontSize: 24.sp,
          fontWeight: FontWeight.w800,
        ),
        6.height,
        AppText(
          LocaleKeys.auth_registerSubtitle.tr(),
          fontSize: 13.sp,
          color: AppColors.textSecondaryColor.themeColor,
          fontWeight: FontWeight.w500,
        ),
      ],
    );
  }
}

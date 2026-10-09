import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_text.dart';

class AuthAssuranceNote extends StatelessWidget {
  const AuthAssuranceNote({super.key});

  @override
  Widget build(BuildContext context) {
    final color = AppColors.subtleText.themeColor;
    return Container(
      margin: EdgeInsets.only(top: 14.h),
      padding: EdgeInsets.only(top: 18.h),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: AppColors.softDivider.themeColor),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shield_outlined, size: 14.sp, color: color),
          6.width,
          AppText(
            LocaleKeys.brand_assurance.tr(),
            fontSize: 8.sp,
            color: color,
          ),
        ],
      ),
    );
  }
}

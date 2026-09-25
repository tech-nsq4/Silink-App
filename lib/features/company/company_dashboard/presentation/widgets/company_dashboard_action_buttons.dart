import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/locale_keys.dart';

/// Single full-width button: العودة إلى الحساب الشخصي (Q0).
class CompanyBackToPersonalButton extends StatelessWidget {
  const CompanyBackToPersonalButton({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: onTap,
        icon: Icon(
          Icons.swap_horiz_rounded,
          size: 16.sp,
          color: AppColors.blue.themeColor,
        ),
        label: Text(
          LocaleKeys.company_back_to_personal.tr(),
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700),
        ),
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.blue.themeColor,
          side: BorderSide(
            color: AppColors.blue.themeColor.withValues(alpha: 0.25),
          ),
          backgroundColor: AppColors.blue.themeColor.withValues(alpha: 0.05),
          padding: EdgeInsets.symmetric(vertical: 14.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
        ),
      ),
    );
  }
}

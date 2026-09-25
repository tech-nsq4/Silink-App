import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/widgets/app_text.dart';

class CompanyPublicPageAboutCard extends StatelessWidget {
  const CompanyPublicPageAboutCard({super.key, required this.about});

  final String about;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.cardColor.themeColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.borderColor.themeColor),
      ),
      child: AppText(
        about,
        fontSize: 12.5.sp,
        height: 1.7,
        color: AppColors.textPrimaryColor.themeColor,
        textAlign: TextAlign.center,
      ),
    );
  }
}

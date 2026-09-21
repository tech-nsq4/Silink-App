import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/widgets/app_text.dart';

class CompanyStepHeader extends StatelessWidget {
  const CompanyStepHeader({
    super.key,
    required this.step,
    required this.total,
    required this.title,
    required this.subtitle,
  });

  final int step;
  final int total;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppText(
              title,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
            AppText(
              '$step / $total',
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.mint.themeColor,
            ),
          ],
        ),
        6.height,
        AppText(
          subtitle,
          fontSize: 12.5.sp,
          color: AppColors.textSecondaryColor.themeColor,
        ),
        10.height,
        ClipRRect(
          borderRadius: BorderRadius.circular(8.r),
          child: LinearProgressIndicator(
            value: step / total,
            minHeight: 6.h,
            backgroundColor: AppColors.mintSoft.themeColor,
            valueColor:
                AlwaysStoppedAnimation<Color>(AppColors.mint.themeColor),
          ),
        ),
      ],
    );
  }
}

class CompanyInfoRow extends StatelessWidget {
  const CompanyInfoRow({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: AppText(
              label,
              fontSize: 12.5.sp,
              color: AppColors.textSecondaryColor.themeColor,
            ),
          ),
          8.width,
          Expanded(
            flex: 2,
            child: AppText(
              value,
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}

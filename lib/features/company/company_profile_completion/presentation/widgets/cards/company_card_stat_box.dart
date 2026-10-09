import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/widgets/app_text.dart';

class CompanyCardStatBox extends StatelessWidget {
  const CompanyCardStatBox({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 4.w),
        decoration: BoxDecoration(
          color: AppColors.white.themeColor,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColors.studioPanelBorder.themeColor),
        ),
        child: Column(
          children: [
            AppText(
              '$value',
              fontSize: 17.sp,
              fontWeight: FontWeight.w800,
              color: AppColors.studioCardStart.themeColor,
            ),
            SizedBox(height: 4.h),
            AppText(
              label,
              fontSize: 8.sp,
              color: AppColors.textSecondaryColor.themeColor,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

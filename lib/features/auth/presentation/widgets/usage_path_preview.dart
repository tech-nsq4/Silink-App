import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/app_text.dart';

class UsagePathPreview extends StatelessWidget {
  const UsagePathPreview({
    super.key,
    required this.icon,
    required this.title,
    required this.steps,
  });

  final IconData icon;
  final String title;
  final String steps;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20.h),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: AppColors.softDivider.themeColor),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 34.w,
            height: 34.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.pathIconBackground.themeColor,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(
              icon,
              size: 19.sp,
              color: AppColors.accentBlue.themeColor,
            ),
          ),
          11.width,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(title, fontSize: 11.sp, fontWeight: FontWeight.w700),
                SizedBox(height: 6.h),
                AppText(
                  steps,
                  fontSize: 8.sp,
                  height: 1.8,
                  color: AppColors.pathBody.themeColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

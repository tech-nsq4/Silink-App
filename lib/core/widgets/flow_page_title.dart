import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';
import 'app_text.dart';

class FlowPageTitle extends StatelessWidget {
  const FlowPageTitle({
    super.key,
    required this.eyebrow,
    required this.title,
    this.subtitle,
  });

  final String eyebrow;
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 7.h, bottom: 25.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            eyebrow,
            fontSize: 10.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.accentTeal.themeColor,
          ),
          SizedBox(height: 8.h),
          AppText(
            title,
            fontSize: 31.sp,
            fontWeight: FontWeight.w800,
            height: 1.25,
            letterSpacing: -1,
          ),
          if (subtitle != null) ...[
            SizedBox(height: 11.h),
            AppText(
              subtitle!,
              fontSize: 11.sp,
              height: 1.8,
              color: AppColors.pageSubtitle.themeColor,
            ),
          ],
        ],
      ),
    );
  }
}

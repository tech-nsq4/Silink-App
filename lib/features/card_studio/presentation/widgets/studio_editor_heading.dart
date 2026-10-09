import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/app_text.dart';

class StudioEditorHeading extends StatelessWidget {
  const StudioEditorHeading({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 23.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            title,
            fontSize: 25.sp,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
          ),
          SizedBox(height: 7.h),
          AppText(
            subtitle,
            fontSize: 11.sp,
            height: 1.8,
            color: AppColors.studioEditorSubtitle.themeColor,
          ),
        ],
      ),
    );
  }
}

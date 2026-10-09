import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/app_colors.dart';
import '../app_text.dart';

class PublicProfileSectionHead extends StatelessWidget {
  const PublicProfileSectionHead({
    super.key,
    required this.eyebrow,
    required this.title,
  });

  final String eyebrow;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 17.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            eyebrow,
            fontSize: 8.sp,
            color: AppColors.profileSectionEyebrow.themeColor,
          ),
          SizedBox(height: 8.h),
          AppText(
            title,
            fontSize: 21.sp,
            fontWeight: FontWeight.w800,
            height: 1.5,
            letterSpacing: -0.4,
            color: AppColors.profileSectionTitle.themeColor,
          ),
        ],
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/extensions/extensions.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/locale_keys.dart';
import '../../../core/widgets/app_text.dart';

class AboutMeCard extends StatelessWidget {
  const AboutMeCard({super.key, required this.bio});

  final String bio;

  @override
  Widget build(BuildContext context) {
    if (bio.trim().isEmpty) return const SizedBox.shrink();
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white.themeColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            LocaleKeys.publish_aboutMe.tr(),
            fontSize: 11.sp,
            fontWeight: FontWeight.w800,
            color: AppColors.textSecondaryColor.themeColor,
          ),
          6.height,
          AppText(
            bio,
            fontSize: 14.sp,
          ),
        ],
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/app_text.dart';
import '../../data/models/onboarding_slide.dart';

class OnboardingSlideCopy extends StatelessWidget {
  const OnboardingSlideCopy({super.key, required this.slide});

  final OnboardingSlide slide;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(27.w, 10.h, 27.w, 22.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            slide.tagKey.tr(),
            fontSize: 10.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.accentTeal.themeColor,
          ),
          SizedBox(height: 15.h),
          AppText(
            slide.titleKey.tr(),
            fontSize: 33.sp,
            fontWeight: FontWeight.w800,
            height: 1.3,
            letterSpacing: -0.8,
          ),
          SizedBox(height: 15.h),
          AppText(
            slide.bodyKey.tr(),
            fontSize: 11.sp,
            height: 1.9,
            color: AppColors.textSecondaryColor.themeColor,
          ),
        ],
      ),
    );
  }
}

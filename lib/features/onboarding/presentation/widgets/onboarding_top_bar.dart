import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/silink_brand.dart';

class OnboardingTopBar extends StatelessWidget {
  const OnboardingTopBar({super.key, required this.onSkip});

  final VoidCallback onSkip;

  @override
  Widget build(BuildContext context) {
    final color = AppColors.skipText.themeColor;
    return Padding(
      padding: EdgeInsets.fromLTRB(24.w, 0.h, 24.w, 20.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SilinkBrand(fontSize: 26.sp),
          GestureDetector(
            onTap: onSkip,
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 6.h),
              child: Row(
                children: [
                  AppText(
                    LocaleKeys.onboarding_skip.tr(),
                    fontSize: 10.sp,
                    color: color,
                  ),
                  5.width,
                  Icon(Icons.arrow_forward_rounded, size: 13.sp, color: color),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

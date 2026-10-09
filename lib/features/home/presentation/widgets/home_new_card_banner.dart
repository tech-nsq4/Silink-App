import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/custom_tap_effect.dart';

class HomeNewCardBanner extends StatelessWidget {
  const HomeNewCardBanner({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final blue = AppColors.homeBannerAccent.themeColor;
    return CustomTapEffect(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: AppColors.homeBannerFill.themeColor,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColors.homeBannerBorder.themeColor),
        ),
        child: Row(
          children: [
            Container(
              width: 36.w,
              height: 36.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.homeBannerIcon.themeColor,
                borderRadius: BorderRadius.circular(11.r),
              ),
              child:
                  Icon(Icons.auto_awesome_outlined, size: 18.sp, color: blue),
            ),
            12.width,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(title, fontSize: 11.sp, fontWeight: FontWeight.w800),
                  SizedBox(height: 5.h),
                  AppText(
                    subtitle,
                    fontSize: 8.5.sp,
                    color: AppColors.textSecondaryColor.themeColor,
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_back_rounded, size: 18.sp, color: blue),
          ],
        ),
      ),
    );
  }
}

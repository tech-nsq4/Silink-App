import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../core/widgets/custom_tap_effect.dart';

class HubStatCard extends StatelessWidget {
  const HubStatCard({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    this.onTap,
  });

  final IconData icon;
  final int value;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return CustomTapEffect(
      isClickable: onTap != null,
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(18.w),
        decoration: BoxDecoration(
          color: AppColors.white.themeColor,
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(color: AppColors.studioPanelBorder.themeColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 19.sp, color: AppColors.accentTeal.themeColor),
            SizedBox(height: 10.h),
            AppText(
              '$value',
              fontSize: 22.sp,
              fontWeight: FontWeight.w800,
              color: AppColors.studioCardStart.themeColor,
            ),
            SizedBox(height: 12.h),
            AppText(
              label,
              fontSize: 8.5.sp,
              color: AppColors.textSecondaryColor.themeColor,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/app_text.dart';

class NewCardMethodCard extends StatelessWidget {
  const NewCardMethodCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final accent = AppColors.accentTeal.themeColor;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        constraints: BoxConstraints(minHeight: 122.h),
        padding: EdgeInsets.all(17.w),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.methodSelected.themeColor
              : AppColors.white.themeColor,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: selected ? accent : AppColors.methodBorder.themeColor,
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  size: 22.sp,
                  color: selected ? accent : AppColors.methodIcon.themeColor,
                ),
                SizedBox(height: 9.h),
                AppText(
                  title,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.methodTitle.themeColor,
                ),
                SizedBox(height: 9.h),
                AppText(
                  subtitle,
                  fontSize: 9.sp,
                  color: AppColors.methodBody.themeColor,
                ),
              ],
            ),
            if (selected)
              PositionedDirectional(
                top: -1.h,
                end: -5.w,
                child: Icon(Icons.check_rounded, size: 14.sp, color: accent),
              ),
          ],
        ),
      ),
    );
  }
}

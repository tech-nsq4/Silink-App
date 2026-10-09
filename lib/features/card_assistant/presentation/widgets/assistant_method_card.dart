import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/app_text.dart';

class AssistantMethodCard extends StatelessWidget {
  const AssistantMethodCard({
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
        constraints: BoxConstraints(minHeight: 128.h),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 17.h),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.assistantMethodSelected.themeColor
              : AppColors.white.themeColor,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: selected ? accent : AppColors.assistantLine.themeColor,
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
                  size: 21.sp,
                  color: selected
                      ? accent
                      : AppColors.assistantMethodIcon.themeColor,
                ),
                SizedBox(height: 11.h),
                AppText(
                  title,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.assistantMethodTitle.themeColor,
                ),
                SizedBox(height: 11.h),
                AppText(
                  subtitle,
                  fontSize: 8.sp,
                  color: AppColors.assistantMethodBody.themeColor,
                ),
              ],
            ),
            if (selected)
              PositionedDirectional(
                top: -3.h,
                end: -1.w,
                child: Icon(Icons.check_rounded, size: 13.sp, color: accent),
              ),
          ],
        ),
      ),
    );
  }
}

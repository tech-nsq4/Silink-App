import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/app_text.dart';

class UsageOptionCard extends StatelessWidget {
  const UsageOptionCard({
    super.key,
    required this.number,
    required this.icon,
    required this.title,
    required this.body,
    required this.selected,
    required this.onTap,
  });

  final String number;
  final IconData icon;
  final String title;
  final String body;
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
        constraints: BoxConstraints(minHeight: 207.h),
        padding: EdgeInsets.fromLTRB(14.w, 19.h, 14.w, 15.h),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.choiceSelected.themeColor
              : AppColors.white.themeColor,
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(
            color: selected ? accent : AppColors.borderColor.themeColor,
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              number,
              fontSize: 9.sp,
              color: AppColors.choiceNumber.themeColor,
            ),
            SizedBox(height: 21.h),
            Icon(icon, size: 23.sp, color: accent),
            SizedBox(height: 13.h),
            AppText(
              title,
              fontSize: 19.sp,
              fontWeight: FontWeight.w800,
              color: AppColors.choiceTitle.themeColor,
            ),
            SizedBox(height: 9.h),
            AppText(
              body,
              fontSize: 9.sp,
              height: 1.9,
              color: AppColors.choiceBody.themeColor,
            ),
            SizedBox(height: 14.h),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 18.w,
              height: 18.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: selected ? accent : Colors.transparent,
                shape: BoxShape.circle,
                border: selected
                    ? null
                    : Border.all(color: AppColors.choiceRadioBorder.themeColor),
              ),
              child: selected
                  ? Icon(
                      Icons.check_rounded,
                      size: 13.sp,
                      color: AppColors.white.light,
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

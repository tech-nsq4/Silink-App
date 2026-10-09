import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/widgets/app_text.dart';

class EmployeeActionTile extends StatelessWidget {
  const EmployeeActionTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.destructive = false,
    this.showDivider = true,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool destructive;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final color = destructive
        ? AppColors.errorColor.themeColor
        : AppColors.textPrimaryColor.themeColor;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          border: showDivider
              ? Border(
                  bottom:
                      BorderSide(color: AppColors.studioStepLine.themeColor),
                )
              : null,
        ),
        child: Row(
          children: [
            Container(
              width: 36.w,
              height: 36.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: destructive
                    ? color.withValues(alpha: 0.08)
                    : AppColors.studioSelectFill.themeColor,
                borderRadius: BorderRadius.circular(11.r),
              ),
              child: Icon(
                icon,
                size: 18.sp,
                color: destructive
                    ? color
                    : AppColors.textSecondaryColor.themeColor,
              ),
            ),
            12.width,
            Expanded(
              child: AppText(
                title,
                fontSize: 11.sp,
                fontWeight: FontWeight.w800,
                color: color,
              ),
            ),
            Icon(
              Icons.chevron_left_rounded,
              size: 18.sp,
              color: AppColors.studioRowIcon.themeColor,
            ),
          ],
        ),
      ),
    );
  }
}

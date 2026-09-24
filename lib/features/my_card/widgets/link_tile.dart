import 'package:Silink/core/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/app_text.dart';

class LinkTile extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool filled;
  final VoidCallback onTap;

  const LinkTile({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
    this.filled = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14.r),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 13.h),
        decoration: BoxDecoration(
          color: filled
              ? AppColors.mint.themeColor
              : AppColors.white.themeColor,
          borderRadius: BorderRadius.circular(14.r),
          border: filled
              ? null
              : Border.all(color: AppColors.borderColor.themeColor),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 16.sp,
              color:
                  filled ? Colors.white : AppColors.textSecondaryColor.themeColor,
            ),
            10.width,
            Expanded(
              child: AppText(
                label,
                fontSize: 13.sp,
                fontWeight: FontWeight.w700,
                color: filled ? Colors.white : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
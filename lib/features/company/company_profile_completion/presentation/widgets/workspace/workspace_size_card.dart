import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/widgets/app_text.dart';
import '../../../../../../core/widgets/custom_tap_effect.dart';

class WorkspaceSizeCard extends StatelessWidget {
  const WorkspaceSizeCard({
    super.key,
    required this.label,
    required this.caption,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final String caption;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final accent = AppColors.accentTeal.themeColor;
    return CustomTapEffect(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
        decoration: BoxDecoration(
          color: selected
              ? accent.withValues(alpha: 0.08)
              : AppColors.white.themeColor,
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(
            color: selected ? accent : AppColors.studioPanelBorder.themeColor,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.groups_outlined,
                size: 20.sp,
                color: selected ? accent : AppColors.studioRowIcon.themeColor),
            SizedBox(height: 8.h),
            Directionality(
              textDirection: TextDirection.ltr,
              child: AppText(
                label,
                fontSize: 20.sp,
                fontWeight: FontWeight.w800,
                color: selected ? accent : null,
              ),
            ),
            SizedBox(height: 6.h),
            AppText(
              caption,
              fontSize: 8.5.sp,
              color: AppColors.textSecondaryColor.themeColor,
            ),
          ],
        ),
      ),
    );
  }
}

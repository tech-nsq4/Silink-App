import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/widgets/app_text.dart';
import '../../../../../../core/widgets/custom_tap_effect.dart';

class WorkspaceChoiceCard extends StatelessWidget {
  const WorkspaceChoiceCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.selected,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final accent = AppColors.accentTeal.themeColor;
    return CustomTapEffect(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.fromLTRB(14.w, 16.h, 14.w, 14.h),
        decoration: BoxDecoration(
          color: selected
              ? accent.withValues(alpha: 0.08)
              : AppColors.white.themeColor,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: selected ? accent : AppColors.studioPanelBorder.themeColor,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              title,
              fontSize: 12.sp,
              fontWeight: FontWeight.w800,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 6.h),
            AppText(
              subtitle,
              fontSize: 8.5.sp,
              height: 1.5,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              color: AppColors.textSecondaryColor.themeColor,
            ),
            SizedBox(height: 12.h),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Icon(
                selected
                    ? Icons.check_circle_rounded
                    : Icons.radio_button_unchecked_rounded,
                size: 18.sp,
                color: selected ? accent : AppColors.studioStepLine.themeColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

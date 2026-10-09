import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/app_text.dart';

class HomeStatusBadge extends StatelessWidget {
  const HomeStatusBadge({super.key, required this.label, required this.active});

  final String label;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final color = active
        ? AppColors.accentTeal.themeColor
        : AppColors.textSecondaryColor.themeColor;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: AppText(
        label,
        fontSize: 8.5.sp,
        fontWeight: FontWeight.w700,
        color: color,
      ),
    );
  }
}

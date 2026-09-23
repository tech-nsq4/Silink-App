import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/app_text.dart';

/// Small pill used to show a plan status (active / your current plan).
class PlanStatusChip extends StatelessWidget {
  const PlanStatusChip({
    super.key,
    required this.label,
    this.color,
  });

  final String label;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final tone = color ?? AppColors.mint.themeColor;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: AppText(
        label,
        fontSize: 11.5,
        fontWeight: FontWeight.w700,
        // Always render the label in the solid version of the tone, so
        // semi-transparent tones (e.g. Color(0x1064748B)) stay readable.
        color: tone.withValues(alpha: 1),
      ),
    );
  }
}

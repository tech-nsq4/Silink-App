import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';
import 'app_text.dart';

class FlowStepperDot extends StatelessWidget {
  const FlowStepperDot({
    super.key,
    required this.number,
    required this.done,
    required this.active,
  });

  final int number;
  final bool done;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final accent = AppColors.accentTeal.themeColor;
    final white = AppColors.white.light;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOut,
      width: 26.w,
      height: 26.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: done || active
            ? accent
            : AppColors.studioStepIdleBadge.themeColor,
        boxShadow: active
            ? [
                BoxShadow(
                  color: accent.withValues(alpha: 0.35),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ]
            : const [],
      ),
      child: done
          ? Icon(Icons.check_rounded, size: 15.sp, color: white)
          : AppText(
              '$number',
              fontSize: 11.sp,
              fontWeight: FontWeight.w800,
              color: active ? white : AppColors.studioStepIdle.themeColor,
            ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';

class FlowStepperLine extends StatelessWidget {
  const FlowStepperLine(
      {super.key, required this.visible, required this.filled});

  final bool visible;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        height: 2.5.h,
        decoration: BoxDecoration(
          color: !visible
              ? Colors.transparent
              : filled
                  ? AppColors.accentTeal.themeColor
                  : AppColors.studioStepLine.themeColor,
          borderRadius: BorderRadius.circular(2.r),
        ),
      ),
    );
  }
}

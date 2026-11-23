import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';
import 'app_text.dart';
import 'flow_stepper_dot.dart';
import 'flow_stepper_line.dart';

class FlowStepper extends StatelessWidget {
  const FlowStepper({
    super.key,
    required this.labels,
    required this.current,
    required this.onTap,
  });

  final List<String> labels;
  final int current;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final accent = AppColors.accentTeal.themeColor;
    final last = labels.length - 1;
    return Padding(
      padding: EdgeInsets.only(top: 6.h, bottom: 26.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final (index, label) in labels.indexed)
            Expanded(
              child: GestureDetector(
                onTap: index < current ? () => onTap(index) : null,
                behavior: HitTestBehavior.opaque,
                child: Column(
                  children: [
                    Row(
                      children: [
                        FlowStepperLine(
                          visible: index > 0,
                          filled: index <= current,
                        ),
                        FlowStepperDot(
                          number: index + 1,
                          done: index < current,
                          active: index == current,
                        ),
                        FlowStepperLine(
                          visible: index < last,
                          filled: index < current,
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.w),
                      child: AppText(
                        label,
                        fontSize: 9.5.sp,
                        height: 1.3,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: index == current
                            ? FontWeight.w800
                            : FontWeight.w600,
                        color: index == current
                            ? accent
                            : AppColors.studioStepIdle.themeColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

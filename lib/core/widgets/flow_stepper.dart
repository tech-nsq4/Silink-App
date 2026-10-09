import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../extensions/extensions.dart';
import '../utils/app_colors.dart';
import 'app_text.dart';

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
    final white = AppColors.white.light;
    return Padding(
      padding: EdgeInsets.only(top: 6.h, bottom: 26.h),
      child: Row(
        children: [
          for (final (index, label) in labels.indexed) ...[
            if (index > 0) 8.width,
            Expanded(
              child: GestureDetector(
                onTap: index < current ? () => onTap(index) : null,
                behavior: HitTestBehavior.opaque,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: 20.w,
                          height: 20.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: index <= current
                                ? accent
                                : AppColors.studioStepIdleBadge.themeColor,
                          ),
                          child: index < current
                              ? Icon(Icons.check_rounded,
                                  size: 12.sp, color: white)
                              : AppText(
                                  '${index + 1}',
                                  fontSize: 9.sp,
                                  color: index == current
                                      ? white
                                      : AppColors.studioStepIdle.themeColor,
                                ),
                        ),
                        6.width,
                        Flexible(
                          child: AppText(
                            label,
                            fontSize: 10.sp,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: index == current
                                ? FontWeight.w800
                                : FontWeight.w500,
                            color: index == current
                                ? accent
                                : AppColors.studioStepIdle.themeColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      height: 2.h,
                      decoration: BoxDecoration(
                        color: index <= current
                            ? accent
                            : AppColors.studioStepLine.themeColor,
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

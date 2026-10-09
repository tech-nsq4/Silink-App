import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../extensions/extensions.dart';
import '../utils/app_colors.dart';
import 'app_text.dart';

class ProcessingStepRow extends StatelessWidget {
  const ProcessingStepRow({
    super.key,
    required this.label,
    required this.number,
    required this.active,
    required this.done,
  });

  final String label;
  final int number;
  final bool active;
  final bool done;

  @override
  Widget build(BuildContext context) {
    final white = AppColors.white.light;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            width: 23.w,
            height: 23.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: active
                  ? AppColors.accentTeal.themeColor
                  : AppColors.assistantStepIdleBadge.themeColor,
              shape: BoxShape.circle,
            ),
            child: done
                ? Icon(Icons.check_rounded, size: 13.sp, color: white)
                : AppText(
                    '$number',
                    fontSize: 9.sp,
                    color:
                        active ? white : AppColors.assistantStepIdle.themeColor,
                  ),
          ),
          10.width,
          AppText(
            label,
            fontSize: 11.sp,
            color: active
                ? AppColors.assistantStepActive.themeColor
                : AppColors.assistantStepIdle.themeColor,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/app_text.dart';

class StudioStepper extends StatelessWidget {
  const StudioStepper({
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
    return Container(
      margin: EdgeInsets.only(bottom: 26.h),
      padding: EdgeInsets.only(top: 8.h, bottom: 17.h),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.studioStepLine.themeColor),
        ),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        alignment: AlignmentDirectional.centerStart,
        child: Row(
          children: [
            for (final (index, label) in labels.indexed) ...[
              if (index > 0) SizedBox(width: 14.w),
              GestureDetector(
                onTap: index < current ? () => onTap(index) : null,
                behavior: HitTestBehavior.opaque,
                child: Row(
                  children: [
                    Container(
                      width: 21.w,
                      height: 21.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: index <= current
                            ? accent
                            : AppColors.studioStepIdleBadge.themeColor,
                      ),
                      child: index < current
                          ? Icon(Icons.check_rounded,
                              size: 12.sp, color: AppColors.white.light)
                          : AppText(
                              '${index + 1}',
                              fontSize: 10.sp,
                              color: index == current
                                  ? AppColors.white.light
                                  : AppColors.studioStepIdle.themeColor,
                            ),
                    ),
                    5.width,
                    AppText(
                      label,
                      fontSize: 10.sp,
                      fontWeight:
                          index == current ? FontWeight.w800 : FontWeight.w500,
                      color: index == current
                          ? accent
                          : index < current
                              ? AppColors.studioStepComplete.themeColor
                              : AppColors.studioStepIdle.themeColor,
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

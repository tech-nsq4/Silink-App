import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/app_text.dart';

class StudioModeTabs extends StatelessWidget {
  const StudioModeTabs({
    super.key,
    required this.labels,
    required this.index,
    required this.color,
    required this.onChanged,
  });

  final List<String> labels;
  final int index;
  final Color color;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: AppColors.studioFieldFill.themeColor,
        borderRadius: BorderRadius.circular(11.r),
      ),
      child: Row(
        children: [
          for (final (i, label) in labels.indexed)
            Expanded(
              child: GestureDetector(
                onTap: () => onChanged(i),
                behavior: HitTestBehavior.opaque,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  curve: Curves.easeOut,
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: i == index
                        ? AppColors.white.themeColor
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(9.r),
                    boxShadow: i == index
                        ? [
                            BoxShadow(
                              color: color.withValues(alpha: 0.18),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ]
                        : const [],
                  ),
                  child: AppText(
                    label,
                    fontSize: 10.sp,
                    fontWeight:
                        i == index ? FontWeight.w800 : FontWeight.w600,
                    color: i == index
                        ? color
                        : AppColors.studioFieldHint.themeColor,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

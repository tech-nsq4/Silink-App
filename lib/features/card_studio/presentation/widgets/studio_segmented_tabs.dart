import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/app_text.dart';

class StudioSegmentedTabs extends StatelessWidget {
  const StudioSegmentedTabs({
    super.key,
    required this.labels,
    required this.selected,
    required this.onSelected,
  });

  final List<String> labels;
  final int selected;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppColors.studioTabs.themeColor,
        borderRadius: BorderRadius.circular(11.r),
      ),
      child: Row(
        children: [
          for (final (index, label) in labels.indexed) ...[
            if (index > 0) SizedBox(width: 5.w),
            Expanded(
              child: GestureDetector(
                onTap: () => onSelected(index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  constraints: BoxConstraints(minHeight: 35.h),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: index == selected
                        ? AppColors.white.themeColor
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(8.r),
                    boxShadow: index == selected
                        ? [
                            BoxShadow(
                              color: AppColors.studioTabActive.themeColor
                                  .withValues(alpha: 0.03),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ]
                        : null,
                  ),
                  child: AppText(
                    label,
                    fontSize: 11.sp,
                    fontWeight:
                        index == selected ? FontWeight.w800 : FontWeight.w400,
                    color: index == selected
                        ? AppColors.studioTabActive.themeColor
                        : AppColors.studioTabText.themeColor,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

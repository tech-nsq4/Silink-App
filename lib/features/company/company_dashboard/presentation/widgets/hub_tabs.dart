import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/widgets/app_text.dart';

class HubTabs extends StatelessWidget {
  const HubTabs({
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
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppColors.studioStepIdleBadge.themeColor,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Row(
        children: [
          for (final (index, label) in labels.indexed)
            Expanded(
              child: GestureDetector(
                onTap: () => onSelected(index),
                behavior: HitTestBehavior.opaque,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  padding: EdgeInsets.symmetric(vertical: 11.h),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: index == selected
                        ? AppColors.white.themeColor
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(11.r),
                  ),
                  child: AppText(
                    label,
                    fontSize: 9.5.sp,
                    fontWeight:
                        index == selected ? FontWeight.w800 : FontWeight.w500,
                    color: index == selected
                        ? AppColors.textPrimaryColor.themeColor
                        : AppColors.textSecondaryColor.themeColor,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/app_text.dart';
import '../../data/models/file_category_model.dart';

class MyFileCategoryChips extends StatelessWidget {
  const MyFileCategoryChips({
    super.key,
    required this.categories,
    required this.selectedIds,
    required this.onToggle,
  });

  final List<FileCategoryModel> categories;
  final Set<String> selectedIds;
  final ValueChanged<String> onToggle;

  @override
  Widget build(BuildContext context) {
    final mint = AppColors.mint.themeColor;
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: [
        for (final category in categories)
          InkWell(
            onTap: () => onToggle(category.id),
            borderRadius: BorderRadius.circular(20.r),
            child: Builder(builder: (context) {
              final selected = selectedIds.contains(category.id);
              return AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: selected
                      ? mint.withValues(alpha: 0.08)
                      : AppColors.white.themeColor,
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color: selected ? mint : AppColors.dividerColor.themeColor,
                    width: selected ? 1.6 : 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (selected) ...[
                      Icon(Icons.check_rounded, size: 14.sp, color: mint),
                      SizedBox(width: 4.w),
                    ],
                    AppText(
                      category.name,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      color: selected
                          ? mint
                          : AppColors.textPrimaryColor.themeColor,
                    ),
                  ],
                ),
              );
            }),
          ),
      ],
    );
  }
}

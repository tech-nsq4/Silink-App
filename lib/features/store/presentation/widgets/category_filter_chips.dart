import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/app_text.dart';

class CategoryFilterChips extends StatelessWidget {
  final List<String> categories;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const CategoryFilterChips({
    super.key,
    required this.categories,
    required this.selectedIndex,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => SizedBox(width: 8.w),
        itemBuilder: (context, index) {
          final selected = index == selectedIndex;
          return InkWell(
            onTap: () => onSelected(index),
            borderRadius: BorderRadius.circular(20.r),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: selected ? const Color(0xFF1F8A70) : AppColors.white.themeColor,
                borderRadius: BorderRadius.circular(20.r),
                border: selected ? null : Border.all(color: AppColors.borderColor.themeColor),
              ),
              child: AppText(
                categories[index],
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
                color: selected ? Colors.white : AppColors.textSecondaryColor.themeColor,
              ),
            ),
          );
        },
      ),
    );
  }
}

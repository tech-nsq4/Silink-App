import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmployeesFilterChips extends StatelessWidget {
  const EmployeesFilterChips({
    super.key,
    required this.filters,
    required this.selected,
    required this.onSelected,
  });

  final List<(String, String)> filters;
  final String selected;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 8.h),
        itemCount: filters.length,
        separatorBuilder: (_, __) => 8.width,
        itemBuilder: (context, index) {
          final (id, labelKey) = filters[index];
          final isSelected = selected == id;
          return InkWell(
            onTap: () => onSelected(id),
            borderRadius: BorderRadius.circular(20.r),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 7.h),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.mint.themeColor
                    : AppColors.cardColor.themeColor,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: isSelected
                      ? Colors.transparent
                      : AppColors.borderColor.themeColor,
                ),
              ),
              child: AppText(
                labelKey.tr(),
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
                color: isSelected
                    ? Colors.white
                    : AppColors.textSecondaryColor.themeColor,
              ),
            ),
          );
        },
      ),
    );
  }
}

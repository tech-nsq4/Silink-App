import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/app_text.dart';
import '../../logic/product_filters.dart';

class SortDropdownButton extends StatelessWidget {
  const SortDropdownButton({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  final SortOption selected;
  final ValueChanged<SortOption> onChanged;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<SortOption>(
      initialValue: selected,
      onSelected: onChanged,
      color: AppColors.dropdownSurface.themeColor,
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      padding: EdgeInsets.symmetric(vertical: 6.h),
      offset: Offset(0, 44.h),
      itemBuilder: (context) => [
        for (final option in SortOption.values)
          PopupMenuItem<SortOption>(
            value: option,
            height: 40.h,
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  option.labelKey.tr(),
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.overlayOnDark.themeColor,
                ),
                if (option == selected)
                  Icon(
                    Icons.check,
                    size: 16.sp,
                    color: AppColors.overlayOnDark.themeColor,
                  ),
              ],
            ),
          ),
      ],
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: AppColors.white.themeColor,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: AppColors.borderColor.themeColor),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppText(
              selected.labelKey.tr(),
              fontSize: 12.5.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimaryColor.themeColor,
            ),
            4.width,
            Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 18.sp,
              color: AppColors.textSecondaryColor.themeColor,
            ),
          ],
        ),
      ),
    );
  }
}

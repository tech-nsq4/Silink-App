import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/locale_keys.dart';
import '../../../core/widgets/app_text.dart';
import '../data/models/product.dart';

class CategoryFilterChips extends StatelessWidget {
  const CategoryFilterChips({
    super.key,
    required this.categories,
    required this.selected,
    required this.onSelected,
  });

  final List<ProductCategory> categories;

  final ProductCategory? selected;
  final ValueChanged<ProductCategory?> onSelected;

  @override
  Widget build(BuildContext context) {
    final options = <ProductCategory?>[null, ...categories];

    return SizedBox(
      height: 36.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: options.length,
        separatorBuilder: (_, __) => SizedBox(width: 8.w),
        itemBuilder: (context, index) {
          final category = options[index];
          final isSelected = category == selected;
          final label = category == null
              ? LocaleKeys.store_category_all.tr()
              : category.labelKey.tr();

          return InkWell(
            onTap: () => onSelected(category),
            borderRadius: BorderRadius.circular(20.r),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.successColor.themeColor
                    : AppColors.cardColor.themeColor,
                borderRadius: BorderRadius.circular(20.r),
                border: isSelected
                    ? null
                    : Border.all(
                        color: AppColors.borderColor.themeColor
                            .withValues(alpha: 0.12),
                      ),
              ),
              child: AppText(
                label,
                fontSize: 12.5.sp,
                fontWeight: FontWeight.w700,
                color: isSelected
                    ? AppColors.overlayOnDark.themeColor
                    : AppColors.textSecondaryColor.themeColor,
              ),
            ),
          );
        },
      ),
    );
  }
}

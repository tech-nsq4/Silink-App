import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:Silink/features/company/data/models/company_catalog_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CatalogCategoryChips extends StatelessWidget {
  const CatalogCategoryChips({
    super.key,
    required this.categories,
    required this.selectedId,
    required this.onSelected,
  });

  final List<CompanyCatalogCategory> categories;
  final String? selectedId;
  final ValueChanged<String?> onSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 34.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length + 1,
        separatorBuilder: (_, __) => 8.width,
        itemBuilder: (context, index) {
          final category = index == 0 ? null : categories[index - 1];
          final isSelected =
              category == null ? selectedId == null : selectedId == category.id;
          return _Chip(
            label: category == null
                ? LocaleKeys.company_filter_all.tr()
                : category.labelKey.tr(),
            icon: category == null ? Icons.grid_view_rounded : category.icon,
            selected: isSelected,
            onTap: () => onSelected(category?.id),
          );
        },
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected
        ? AppColors.companyBrand.themeColor
        : AppColors.textSecondaryColor.themeColor;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(17.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected
              ? AppColors.companyBrand.themeColor.withValues(alpha: 0.07)
              : AppColors.cardColor.themeColor,
          borderRadius: BorderRadius.circular(17.r),
          border: Border.all(
            color: selected
                ? AppColors.companyBrand.themeColor
                : AppColors.borderColor.themeColor,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 13.sp, color: color),
            5.width,
            AppText(
              label,
              fontSize: 12.sp,
              fontWeight: FontWeight.w800,
              color: color,
            ),
          ],
        ),
      ),
    );
  }
}

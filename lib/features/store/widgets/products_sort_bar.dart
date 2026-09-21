import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/locale_keys.dart';
import '../../../core/widgets/app_text.dart';
import '../models/product_filters.dart';
import 'sort_dropdown_button.dart';

class ProductsSortBar extends StatelessWidget {
  const ProductsSortBar({
    super.key,
    required this.sortOption,
    required this.onSortChanged,
    required this.productsCount,
  });

  final SortOption sortOption;
  final ValueChanged<SortOption> onSortChanged;
  final int productsCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SortDropdownButton(selected: sortOption, onChanged: onSortChanged),
        AppText(
          LocaleKeys.store_product_count
              .tr(namedArgs: {'count': '$productsCount'}),
          fontSize: 12.5.sp,
          color: AppColors.textSecondaryColor.themeColor,
        ),
      ],
    );
  }
}

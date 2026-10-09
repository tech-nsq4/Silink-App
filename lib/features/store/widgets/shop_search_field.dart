import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/locale_keys.dart';
import '../../../core/widgets/app_text_field.dart';

class ShopSearchField extends StatelessWidget {
  const ShopSearchField({super.key, required this.onChanged});

  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      hint: LocaleKeys.shop_searchHint.tr(),
      onChanged: onChanged,
      borderRadius: 14.r,
      fillColor: AppColors.white.themeColor,
      borderColor: AppColors.studioPanelBorder.themeColor,
      focusedBorderColor: AppColors.accentTeal.themeColor,
      prefixIcon: Icon(Icons.search_rounded,
          size: 19.sp, color: AppColors.textSecondaryColor.themeColor),
    );
  }
}

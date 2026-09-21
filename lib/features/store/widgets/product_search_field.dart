import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/locale_keys.dart';
import '../../../core/widgets/app_text_field.dart';

class ProductSearchField extends StatelessWidget {
  const ProductSearchField({super.key, required this.onChanged});

  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      hint: LocaleKeys.store_search_hint.tr(),
      onChanged: onChanged,
      prefixIcon: Icon(
        Icons.search,
        size: 20.sp,
        color: AppColors.textSecondaryColor.themeColor,
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_text.dart';

class ProductsEmptyView extends StatelessWidget {
  const ProductsEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 32.paddingVert,
      child: Column(
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 44.sp,
            color: AppColors.textSecondaryColor.themeColor,
          ),
          12.height,
          AppText(
            LocaleKeys.store_empty_products.tr(),
            fontSize: 13.sp,
            color: AppColors.textSecondaryColor.themeColor,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

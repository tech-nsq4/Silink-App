import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_text.dart';

class CartEmptyView extends StatelessWidget {
  const CartEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 32.paddingVert,
      child: Column(
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 52.sp,
            color: AppColors.textSecondaryColor.themeColor,
          ),
          12.height,
          AppText(
            LocaleKeys.store_cart_empty.tr(),
            fontSize: 15.sp,
            fontWeight: FontWeight.w700,
            textAlign: TextAlign.center,
          ),
          6.height,
          AppText(
            LocaleKeys.store_cart_empty_hint.tr(),
            fontSize: 12.5.sp,
            color: AppColors.textSecondaryColor.themeColor,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

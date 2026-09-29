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
    return Center(
      child: Padding(
        padding: 32.paddingAll,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 88.w,
              height: 88.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color:
                    AppColors.successColor.themeColor.withValues(alpha: 0.10),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.shopping_cart_outlined,
                size: 40.sp,
                color: AppColors.successColor.themeColor,
              ),
            ),
            16.height,
            AppText(
              LocaleKeys.store_cart_empty.tr(),
              fontSize: 16.sp,
              fontWeight: FontWeight.w800,
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
      ),
    );
  }
}

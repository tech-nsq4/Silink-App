import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/convert_helper.dart';
import '../../../core/utils/locale_keys.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/product_thumb.dart';
import '../data/models/product.dart';
import 'product_badge_pill.dart';

class ProductDetailsHero extends StatelessWidget {
  const ProductDetailsHero({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 210.h,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ProductThumb(
            gradient: product.imageGradient,
            imageUrl: product.image,
            radius: 0,
            iconSize: 60,
          ),
          if (product.badge != ProductBadge.none)
            PositionedDirectional(
              top: 14.h,
              start: 16.w,
              child: ProductBadgePill(badge: product.badge),
            ),
          if (product.isDiscounted)
            PositionedDirectional(
              top: 14.h,
              end: 16.w,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color: AppColors.saleRed.themeColor,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: AppText(
                  LocaleKeys.store_save_amount.tr(namedArgs: {
                    'amount':
                        '${ConvertHelper.formatPrice(product.oldPrice! - product.price)} ${LocaleKeys.store_currency.tr()}',
                  }),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w800,
                  color: AppColors.overlayOnDark.themeColor,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

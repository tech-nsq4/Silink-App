import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/convert_helper.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_text.dart';
import '../../data/models/product.dart';
import 'product_badge_pill.dart';
import 'product_color_dots.dart';
import 'product_thumb.dart';

class ProductGridCard extends StatelessWidget {
  const ProductGridCard({super.key, required this.product, this.onTap});

  final Product product;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final card = Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: AppColors.cardColor.themeColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.borderColor.themeColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 1.35,
                child: ProductThumb(gradient: product.imageGradient),
              ),
              if (product.badge != ProductBadge.none)
                PositionedDirectional(
                  top: 8.h,
                  start: 8.w,
                  child: ProductBadgePill(
                    badge: product.badge,
                    compact: true,
                  ),
                ),
            ],
          ),
          8.height,
          AppText(
            product.name,
            fontSize: 12.sp,
            fontWeight: FontWeight.w700,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          6.height,
          ProductColorDots(product: product),
          4.height,
          Row(
            children: [
              AppText(
                '${ConvertHelper.formatPrice(product.price)} ${LocaleKeys.store_currency.tr()}',
                fontSize: 12.sp,
                fontWeight: FontWeight.w800,
                color: AppColors.mint.themeColor,
              ),
              if (product.isDiscounted) ...[
                6.width,
                AppText(
                  ConvertHelper.formatPrice(product.oldPrice!),
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondaryColor.themeColor,
                  decoration: TextDecoration.lineThrough,
                ),
              ],
            ],
          ),
          if (product.customizable) ...[
            6.height,
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
              decoration: BoxDecoration(
                color: AppColors.mintSoft.themeColor,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: AppText(
                LocaleKeys.store_customizable.tr(),
                fontSize: 10.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.mint.themeColor,
              ),
            ),
          ],
        ],
      ),
    );

    if (onTap == null) return card;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: card,
    );
  }
}

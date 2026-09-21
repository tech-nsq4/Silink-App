import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/extensions/extensions.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/convert_helper.dart';
import '../../../core/utils/locale_keys.dart';
import '../../../core/widgets/app_text.dart';
import '../models/product.dart';
import 'product_badge_pill.dart';
import 'product_thumb.dart';

class SpecialOfferCard extends StatelessWidget {
  const SpecialOfferCard({super.key, required this.product, this.onTap});

  final Product product;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final card = Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.cardColor.themeColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.borderColor.themeColor),
      ),
      child: Row(
        children: [
          ProductThumb(
            gradient: product.imageGradient,
            width: 64,
            height: 64,
          ),
          12.width,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: AppText(
                        product.name,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    8.width,
                    const ProductBadgePill(
                      badge: ProductBadge.specialOffer,
                      compact: true,
                    ),
                  ],
                ),
                4.height,
                Row(
                  children: [
                    AppText(
                      '${ConvertHelper.formatPrice(product.price)} ${LocaleKeys.store_currency.tr()}',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.mint.themeColor,
                    ),
                    if (product.isDiscounted) ...[
                      6.width,
                      AppText(
                        '${ConvertHelper.formatPrice(product.oldPrice!)} ${LocaleKeys.store_currency.tr()}',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textSecondaryColor.themeColor,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ],
                  ],
                ),
                if (product.hasRating) ...[
                  4.height,
                  Row(
                    children: [
                      Icon(
                        Icons.star_rounded,
                        size: 15.sp,
                        color: AppColors.ratingGold.themeColor,
                      ),
                      3.width,
                      AppText(
                        '${product.rating} (${product.reviewCount ?? 0})',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textSecondaryColor.themeColor,
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          8.width,
          Icon(
            Directionality.of(context) == ui.TextDirection.rtl
                ? Icons.arrow_back_ios_new
                : Icons.arrow_forward_ios,
            size: 16.w,
            color: AppColors.textSecondaryColor.themeColor,
          ),
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

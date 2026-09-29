import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/extensions/extensions.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/convert_helper.dart';
import '../../../core/utils/locale_keys.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/product_thumb.dart';
import '../data/models/product.dart';
import 'product_badge_pill.dart';

class SpecialOfferCard extends StatelessWidget {
  const SpecialOfferCard({super.key, required this.product, this.onTap});

  final Product product;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final currency = LocaleKeys.store_currency.tr();

    return AppCard(
      onTap: onTap,
      padding: EdgeInsets.all(12.w),
      child: Row(
        children: [
          ProductThumb(
            gradient: product.imageGradient,
            imageUrl: product.image,
            width: 64,
            height: 64,
            radius: 14,
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
                        fontSize: 13.5.sp,
                        fontWeight: FontWeight.w800,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    8.width,
                    const ProductBadgePill(
                      badge: ProductBadge.specialOffer,
                      compact: true,
                      tinted: true,
                    ),
                  ],
                ),
                4.height,
                Row(
                  children: [
                    AppText(
                      '${ConvertHelper.formatPrice(product.price)} $currency',
                      fontSize: 13.5.sp,
                      fontWeight: FontWeight.w800,
                      color: AppColors.successColor.themeColor,
                    ),
                    if (product.isDiscounted) ...[
                      8.width,
                      AppText(
                        '${ConvertHelper.formatPrice(product.oldPrice!)} $currency',
                        fontSize: 11.5.sp,
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
                        fontSize: 11.5.sp,
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
                ? Icons.chevron_left_rounded
                : Icons.chevron_right_rounded,
            size: 22.sp,
            color: AppColors.textSecondaryColor.themeColor,
          ),
        ],
      ),
    );
  }
}

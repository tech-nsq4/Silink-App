import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/extensions/extensions.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/convert_helper.dart';
import '../../../core/utils/locale_keys.dart';
import '../../../core/widgets/app_text.dart';
import '../models/product.dart';

class ProductDetailsSummary extends StatelessWidget {
  const ProductDetailsSummary({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final currency = LocaleKeys.store_currency.tr();

    return Padding(
      padding: 19.paddingHorizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          16.height,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: AppText(
                  product.name,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                ),
              ),
              if (product.hasRating) ...[
                8.width,
                Row(
                  children: [
                    Icon(
                      Icons.star_rounded,
                      size: 15.sp,
                      color: AppColors.ratingGold.themeColor,
                    ),
                    2.width,
                    AppText(
                      '${product.rating}',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    4.width,
                    AppText(
                      '(${product.reviewCount ?? 0})',
                      fontSize: 12.sp,
                      color: AppColors.textSecondaryColor.themeColor,
                    ),
                  ],
                ),
              ],
            ],
          ),
          6.height,
          AppText(
            product.category.labelKey.tr(),
            fontSize: 12.sp,
            color: AppColors.textSecondaryColor.themeColor,
          ),
          6.height,
          Row(
            children: [
              AppText(
                ConvertHelper.formatPrice(product.price),
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.mint.themeColor,
              ),
              4.width,
              AppText(
                currency,
                fontSize: 14.sp,
                color: AppColors.mint.themeColor,
              ),
              if (product.isDiscounted) ...[
                10.width,
                AppText(
                  '${ConvertHelper.formatPrice(product.oldPrice!)} $currency',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondaryColor.themeColor,
                  decoration: TextDecoration.lineThrough,
                ),
              ],
            ],
          ),
          if (product.description.trim().isNotEmpty) ...[
            8.height,
            AppText(
              product.description,
              fontSize: 13.sp,
              color: AppColors.textSecondaryColor.themeColor,
              textAlign: TextAlign.start,
            ),
          ],
        ],
      ),
    );
  }
}

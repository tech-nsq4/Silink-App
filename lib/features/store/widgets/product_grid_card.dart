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
import 'product_color_dots.dart';

class ProductGridCard extends StatelessWidget {
  const ProductGridCard({super.key, required this.product, this.onTap});

  final Product product;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final radius = Radius.circular(16.r);

    return AppCard(
      onTap: onTap,
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                ProductThumb(
                  gradient: product.imageGradient,
                  imageUrl: product.image,
                  borderRadius: BorderRadius.vertical(top: radius),
                  iconSize: 30,
                ),
                if (product.badge != ProductBadge.none)
                  PositionedDirectional(
                    top: 8.h,
                    end: 8.w,
                    child: ProductBadgePill(
                      badge: product.badge,
                      compact: true,
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  product.name,
                  fontSize: 12.5.sp,
                  fontWeight: FontWeight.w800,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                6.height,
                ProductColorDots(product: product),
                6.height,
                Row(
                  children: [
                    AppText(
                      '${ConvertHelper.formatPrice(product.price)} ${LocaleKeys.store_currency.tr()}',
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w800,
                      color: AppColors.successColor.themeColor,
                    ),
                    if (product.isDiscounted) ...[
                      6.width,
                      AppText(
                        ConvertHelper.formatPrice(product.oldPrice!),
                        fontSize: 10.sp,
                        color: AppColors.textSecondaryColor.themeColor,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ],
                  ],
                ),
                if (product.customizable) ...[
                  6.height,
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                    decoration: BoxDecoration(
                      color: AppColors.mintSoft.themeColor,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: AppText(
                      LocaleKeys.store_customizable.tr(),
                      fontSize: 9.5.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.successColor.themeColor,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

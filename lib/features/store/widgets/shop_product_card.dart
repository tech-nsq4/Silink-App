import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/extensions/extensions.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/convert_helper.dart';
import '../../../core/utils/locale_keys.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/custom_tap_effect.dart';
import '../data/models/product.dart';
import 'shop_badge.dart';
import 'shop_product_visual.dart';

class ShopProductCard extends StatelessWidget {
  const ShopProductCard({
    super.key,
    required this.product,
    required this.onTap,
    required this.onAdd,
  });

  final Product product;
  final VoidCallback onTap;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    final accent = AppColors.accentTeal.themeColor;
    final category = product.category?.labelKey.tr() ?? '';
    return CustomTapEffect(
      onTap: onTap,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: AppColors.white.themeColor,
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(color: AppColors.studioPanelBorder.themeColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 125.h,
              color: AppColors.studioSelectFill.themeColor,
              padding: EdgeInsets.all(12.w),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ShopProductVisual(
                      product: product,
                      cardWidth: 105.w,
                    ),
                  ),
                  if (product.badge != ProductBadge.none)
                    PositionedDirectional(
                      top: 0,
                      start: 0,
                      child: ShopBadge(label: product.badge.labelKey.tr()),
                    ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (category.isNotEmpty)
                    AppText(
                      category,
                      fontSize: 8.sp,
                      color: AppColors.textSecondaryColor.themeColor,
                    ),
                  SizedBox(height: 6.h),
                  AppText(
                    product.name,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w800,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      AppText(
                        ConvertHelper.formatPrice(product.price),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w800,
                      ),
                      4.width,
                      AppText(
                        LocaleKeys.store_currency.tr(),
                        fontSize: 8.sp,
                        color: AppColors.textSecondaryColor.themeColor,
                      ),
                      const Spacer(),
                      CustomTapEffect(
                        onTap: onAdd,
                        child: Container(
                          width: 28.w,
                          height: 28.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: accent.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Icon(Icons.add_rounded,
                              size: 18.sp, color: accent),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

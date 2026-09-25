import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/convert_helper.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:Silink/core/widgets/image/custom_image.dart';
import 'package:Silink/features/profile_card/data/models/profile_card_product.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileCardProductCard extends StatelessWidget {
  const ProfileCardProductCard({
    super.key,
    required this.product,
    required this.primaryColor,
    required this.fontFamily,
    required this.onTap,
    this.cardWidth,
  });

  final ProfileCardProduct product;
  final Color primaryColor;
  final String? fontFamily;
  final VoidCallback onTap;
  final double? cardWidth;

  static double get width => 168.w;
  static double get imageHeight => 132.h;

  String get _price {
    if (product.price.trim().isEmpty) return '';
    final price = ConvertHelper.formatPriceWithCurrency(product.price);
    return product.priceLabel.trim().isEmpty
        ? price
        : '${product.priceLabel.trim()} $price';
  }

  @override
  Widget build(BuildContext context) {
    final resolvedWidth = cardWidth ?? width;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18.r),
      child: Container(
        width: resolvedWidth,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: AppColors.white.themeColor,
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(color: AppColors.dividerColor.themeColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            product.hasImage
                ? CustomImage(
                    image: product.imageUrl!,
                    width: resolvedWidth,
                    height: imageHeight,
                  )
                : Container(
                    width: resolvedWidth,
                    height: imageHeight,
                    alignment: Alignment.center,
                    color: primaryColor.withValues(alpha: 0.06),
                    child: Icon(
                      product.kind == 'service'
                          ? Icons.miscellaneous_services_outlined
                          : Icons.work_outline_rounded,
                      size: 30.sp,
                      color: primaryColor,
                    ),
                  ),
            Padding(
              padding: EdgeInsets.fromLTRB(12.w, 10.h, 12.w, 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    product.name,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w800,
                    fontFamily: fontFamily,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  2.height,
                  AppText(
                    product.kind == 'service'
                        ? LocaleKeys.publish_itemKindService.tr()
                        : LocaleKeys.publish_itemKindProduct.tr(),
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondaryColor.themeColor,
                  ),
                  if (_price.isNotEmpty) ...[
                    8.height,
                    AppText(
                      _price,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      color: primaryColor,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

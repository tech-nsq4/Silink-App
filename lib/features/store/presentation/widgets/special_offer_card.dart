import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_images.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/app_text.dart';
import '../../models/product.dart';

class SpecialOfferCard extends StatelessWidget {
  final Product product;
  final VoidCallback? onTap;

  const SpecialOfferCard({super.key, required this.product, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () {},
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: AppColors.white.themeColor,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColors.borderColor.themeColor),
        ),
        child: Row(
          children: [
            Container(
              width: 64.w,
              height: 64.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                gradient: LinearGradient(
                  colors: product.imageGradient,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: SvgPicture.asset(
                AppImages.iconsCard,
                height: 24.h,
                width: 24.w,
                colorFilter: ColorFilter.mode(
                  AppColors.white.themeColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
            12.width,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      AppText(
                        product.name,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                      ),
                      8.width,
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFEAEA),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: AppText(
                          LocaleKeys.store_special_offer.tr(),
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFFE0563E),
                        ),
                      ),
                    ],
                  ),
                  4.height,
                  Row(
                    children: [
                      AppText(
                        '${product.price.toStringAsFixed(0)} ر.س',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.mint.themeColor,
                      ),
                      SizedBox(width: 6.w),
                      if (product.oldPrice != null)
                        AppText(
                          '${product.oldPrice!.toStringAsFixed(0)} ر.س',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.lineThrough,
                        ),
                    ],
                  ),
                  if (product.rating != null) ...[
                    4.height,
                    Row(
                      children: [
                        Icon(Icons.star_rounded,
                            size: 15.sp, color: const Color(0xFFFFB020)),
                        SizedBox(width: 3.w),
                        AppText(
                          '${product.rating} (${product.reviewCount})',
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
              Icons.arrow_forward_ios,
              size: 16.w,
              color: AppColors.textSecondaryColor.themeColor,
            ),
          ],
        ),
      ),
    );
  }
}

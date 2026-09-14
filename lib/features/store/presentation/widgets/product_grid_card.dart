import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/app_text.dart';
import '../../models/product.dart';

class ProductGridCard extends StatelessWidget {
  final Product product;
  final VoidCallback? onTap;

  const ProductGridCard({super.key, required this.product, this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDarkBadge = product.badge == ProductBadge.bestSeller;

    return InkWell(
      onTap: onTap ?? () {},
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: AppColors.white.themeColor,
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
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      gradient: LinearGradient(
                        colors: product.imageGradient,
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    alignment: Alignment.center,
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
                ),
                if (product.badge != ProductBadge.none)
                  PositionedDirectional(
                    top: 8.h,
                    start: 8.w,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                      decoration: BoxDecoration(
                        color: isDarkBadge ? Colors.black : Colors.white,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: AppText(
                        product.badge == ProductBadge.bestSeller
                            ? 'الأكثر مبيعًا'
                            : 'عرض خاص',
                        fontSize: 8.sp,
                        fontWeight: FontWeight.w700,
                        color: isDarkBadge
                            ? Colors.white
                            : const Color(0xFFE0563E),
                      ),
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
            ),
            6.height,
            if (product.colorOptions.isNotEmpty)
              Row(
                children: [
                  for (int i = 0; i < product.colorOptions.length; i++) ...[
                    Container(
                      width: 14.w,
                      height: 14.w,
                      decoration: BoxDecoration(
                        color: product.colorOptions[i],
                        shape: BoxShape.circle,
                        border: i == product.selectedColorIndex
                            ? Border.all(
                                color: AppColors.textPrimaryColor.themeColor,
                                width: 1.6)
                            : Border.all(
                                color: AppColors.borderColor.themeColor,
                                width: 1),
                      ),
                    ),
                    if (i != product.colorOptions.length - 1)
                     4.width,
                  ],
                ],
              ),
            4.height,
            AppText(
              '${product.price.toStringAsFixed(0)} ر.س',
              fontSize: 12.sp,
              fontWeight: FontWeight.w800,
              color: AppColors.mint.themeColor,
            ),
            if (product.customizable) ...[
             6.height,
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFE7F8F0),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: AppText(
                  'قابل للتخصيص',
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.mint.themeColor,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

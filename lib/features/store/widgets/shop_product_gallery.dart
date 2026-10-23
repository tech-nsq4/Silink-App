import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/app_colors.dart';
import '../data/models/product.dart';
import 'shop_product_visual.dart';
import 'shop_tilted_card.dart';

class ShopProductGallery extends StatelessWidget {
  const ShopProductGallery({
    super.key,
    required this.product,
    required this.controller,
    required this.page,
    required this.colorIndex,
    required this.onPageChanged,
  });

  final Product product;
  final PageController controller;
  final int page;
  final int colorIndex;
  final ValueChanged<int> onPageChanged;

  @override
  Widget build(BuildContext context) {
    final images = product.gallery;
    if (images.isEmpty) {
      return ShopProductVisual(
        product: product,
        cardWidth: 190.w,
        colorIndex: colorIndex,
      );
    }
    final accent = AppColors.accentTeal.themeColor;
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            controller: controller,
            itemCount: images.length,
            onPageChanged: onPageChanged,
            itemBuilder: (context, index) => Image.network(
              images[index],
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => Center(
                child: ShopTiltedCard(
                  color: product.colorAt(colorIndex),
                  width: 190.w,
                ),
              ),
            ),
          ),
        ),
        if (images.length > 1) ...[
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var index = 0; index < images.length; index++)
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: EdgeInsets.symmetric(horizontal: 3.w),
                  width: index == page ? 18.w : 6.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: index == page
                        ? accent
                        : AppColors.studioStepLine.themeColor,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
            ],
          ),
        ],
      ],
    );
  }
}

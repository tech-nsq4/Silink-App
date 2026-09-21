import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/models/product.dart';
import 'product_badge_pill.dart';
import 'product_thumb.dart';

class ProductDetailsHero extends StatelessWidget {
  const ProductDetailsHero({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          child: ProductThumb(
            gradient: product.imageGradient,
            height: 200,
            radius: 0,
            iconSize: 60,
          ),
        ),
        if (product.badge != ProductBadge.none)
          PositionedDirectional(
            top: 14.h,
            start: 19.w,
            child: ProductBadgePill(badge: product.badge),
          ),
      ],
    );
  }
}

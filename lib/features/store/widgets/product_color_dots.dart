import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/extensions/extensions.dart';
import '../../../core/utils/app_colors.dart';
import '../models/product.dart';

class ProductColorDots extends StatelessWidget {
  const ProductColorDots({
    super.key,
    required this.product,
    this.dotSize = 14,
    this.spacing = 4,
  });

  final Product product;
  final double dotSize;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    if (!product.hasColors) return const SizedBox.shrink();

    return Row(
      children: [
        for (int index = 0; index < product.colorValues.length; index++) ...[
          Semantics(
            label: product.colorLabelAt(index).isEmpty
                ? ''
                : product.colorLabelAt(index).tr(),
            child: Container(
              width: dotSize.w,
              height: dotSize.w,
              decoration: BoxDecoration(
                color: product.colorAt(index),
                shape: BoxShape.circle,
                border: Border.all(
                  color: index == product.defaultColorIndex
                      ? AppColors.textPrimaryColor.themeColor
                      : AppColors.borderColor.themeColor,
                  width: index == product.defaultColorIndex ? 1.6 : 1,
                ),
              ),
            ),
          ),
          if (index != product.colorValues.length - 1) spacing.width,
        ],
      ],
    );
  }
}

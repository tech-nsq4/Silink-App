import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/extensions/extensions.dart';
import '../../../core/utils/app_colors.dart';
import '../data/models/product.dart';

class ProductColorSwatches extends StatelessWidget {
  const ProductColorSwatches({
    super.key,
    required this.product,
    required this.selectedIndex,
    required this.onSelected,
  });

  final Product product;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int index = 0; index < product.colorValues.length; index++) ...[
          Semantics(
            button: true,
            label: product.colorLabelAt(index).isEmpty
                ? ''
                : product.colorLabelAt(index).tr(),
            child: InkWell(
              onTap: () => onSelected(index),
              customBorder: const CircleBorder(),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                width: 44.w,
                height: 44.w,
                padding: EdgeInsets.all(3.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: index == selectedIndex
                        ? AppColors.successColor.themeColor
                        : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: product.colorAt(index),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.borderColor.themeColor
                          .withValues(alpha: 0.12),
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (index != product.colorValues.length - 1) 10.width,
        ],
      ],
    );
  }
}

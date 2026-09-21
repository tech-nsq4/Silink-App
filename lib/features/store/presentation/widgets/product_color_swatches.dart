import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../data/models/product.dart';

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
              child: Container(
                width: 36.w,
                height: 36.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: index == selectedIndex
                        ? AppColors.brandTeal.themeColor
                        : Colors.transparent,
                  ),
                ),
                child: Container(
                  width: 30.w,
                  height: 30.w,
                  decoration: BoxDecoration(
                    color: product.colorAt(index),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.backgroundColor.themeColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (index != product.colorValues.length - 1) 6.width,
        ],
      ],
    );
  }
}

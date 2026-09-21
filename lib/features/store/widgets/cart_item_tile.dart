import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/extensions/extensions.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/convert_helper.dart';
import '../../../core/utils/locale_keys.dart';
import '../../../core/widgets/app_text.dart';
import '../models/cart_item.dart';
import 'product_thumb.dart';
import 'quantity_stepper.dart';

class CartItemTile extends StatelessWidget {
  const CartItemTile({
    super.key,
    required this.item,
    required this.gradient,
    required this.onIncrease,
    required this.onDecrease,
    required this.onRemove,
  });

  final CartItem item;
  final List<Color> gradient;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final subtitle =
        item.summary.trim().isEmpty ? item.colorLabelKey : item.summary;

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.cardColor.themeColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.borderColor.themeColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProductThumb(
            gradient: gradient,
            width: 56,
            height: 56,
            radius: 12,
            iconSize: 22,
          ),
          12.width,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: AppText(
                        item.name,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w700,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    8.width,
                    InkWell(
                      onTap: onRemove,
                      borderRadius: BorderRadius.circular(12.r),
                      child: Tooltip(
                        message: LocaleKeys.store_remove_item.tr(),
                        child: Icon(
                          Icons.delete_outline_rounded,
                          size: 18.sp,
                          color: AppColors.saleRed.themeColor,
                        ),
                      ),
                    ),
                  ],
                ),
                if (subtitle.trim().isNotEmpty) ...[
                  4.height,
                  AppText(
                    subtitle.tr(),
                    fontSize: 11.5.sp,
                    color: AppColors.textSecondaryColor.themeColor,
                  ),
                ],
                10.height,
                Row(
                  children: [
                    QuantityStepper(
                      quantity: item.quantity,
                      min: 1,
                      max: 99,
                      onChanged: (value) =>
                          value > item.quantity ? onIncrease() : onDecrease(),
                    ),
                    const Spacer(),
                    AppText(
                      '${ConvertHelper.formatPrice(item.total)} ${LocaleKeys.store_currency.tr()}',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w800,
                      color: AppColors.mint.themeColor,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/convert_helper.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/product_thumb.dart';
import '../../../../core/widgets/quantity_stepper.dart';
import '../../data/models/cart_item.dart';

class CartItemTile extends StatelessWidget {
  const CartItemTile({
    super.key,
    required this.item,
    required this.onQuantityChanged,
    required this.onRemove,
  });

  final CartItem item;
  final ValueChanged<int> onQuantityChanged;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final subtitle = item.summary.trim().isNotEmpty
        ? item.summary
        : (item.colorLabelKey.isEmpty ? '' : item.colorLabelKey.tr());

    return AppCard(
      padding: EdgeInsets.all(12.w),
      child: Row(
        children: [
          ProductThumb(
            gradient: item.imageGradient,
            imageUrl: item.image,
            width: 64,
            height: 64,
            radius: 14,
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
                        fontSize: 13.5.sp,
                        fontWeight: FontWeight.w700,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    8.width,
                    Tooltip(
                      message: LocaleKeys.store_remove_item.tr(),
                      child: InkWell(
                        onTap: onRemove,
                        customBorder: const CircleBorder(),
                        child: Padding(
                          padding: 2.paddingAll,
                          child: Icon(
                            Icons.delete_outline_rounded,
                            size: 19.sp,
                            color: AppColors.textSecondaryColor.themeColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                if (item.hasColor || subtitle.trim().isNotEmpty) ...[
                  4.height,
                  Row(
                    children: [
                      if (item.hasColor) ...[
                        Container(
                          width: 12.w,
                          height: 12.w,
                          decoration: BoxDecoration(
                            color: Color(item.colorValue),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.borderColor.themeColor
                                  .withValues(alpha: 0.2),
                            ),
                          ),
                        ),
                        6.width,
                      ],
                      Expanded(
                        child: AppText(
                          subtitle,
                          fontSize: 11.sp,
                          color: AppColors.textSecondaryColor.themeColor,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
                8.height,
                Row(
                  children: [
                    QuantityStepper(
                      quantity: item.quantity,
                      max: AppConstants.maxCartItemQuantity,
                      compact: true,
                      onChanged: onQuantityChanged,
                    ),
                    const Spacer(),
                    AppText(
                      '${ConvertHelper.formatPrice(item.total)} ${LocaleKeys.store_currency.tr()}',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w800,
                      color: AppColors.successColor.themeColor,
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

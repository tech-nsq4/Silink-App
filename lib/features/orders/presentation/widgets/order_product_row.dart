import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/convert_helper.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/product_thumb.dart';
import '../../data/models/order_item_model.dart';

class OrderProductRow extends StatelessWidget {
  const OrderProductRow({super.key, required this.item});

  final OrderItemModel item;

  @override
  Widget build(BuildContext context) {
    final currency = LocaleKeys.store_currency.tr();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      child: Row(
        children: [
          ProductThumb(
            gradient: item.imageGradient,
            imageUrl: item.image,
            width: 48,
            height: 48,
            radius: 12,
            iconSize: 18,
          ),
          12.width,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  item.name,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w800,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                3.height,
                AppText(
                  '${ConvertHelper.formatPrice(item.price)} $currency × ${item.quantity}',
                  fontSize: 11.sp,
                  color: AppColors.textSecondaryColor.themeColor,
                ),
              ],
            ),
          ),
          8.width,
          AppText(
            '${ConvertHelper.formatPrice(item.lineTotal)} $currency',
            fontSize: 13.sp,
            fontWeight: FontWeight.w800,
          ),
        ],
      ),
    );
  }
}

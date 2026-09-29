import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/convert_helper.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/product_thumb.dart';
import '../../../store/data/models/product.dart';
import '../../data/models/my_order_model.dart';
import 'order_status_chip.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({super.key, required this.order, required this.onTap});

  final MyOrderModel order;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final firstItem = order.products.isEmpty ? null : order.products.first;
    final secondary = AppColors.textSecondaryColor.themeColor;
    final isRtl = Directionality.of(context) == ui.TextDirection.rtl;
    final names = order.products.map((item) => item.name).join(
          ConvertHelper.listSeparator,
        );

    return AppCard(
      onTap: onTap,
      padding: EdgeInsets.all(14.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              ProductThumb(
                gradient: firstItem?.imageGradient ?? Product.fallbackGradient,
                imageUrl: firstItem?.image ?? '',
                width: 52,
                height: 52,
                radius: 14,
                iconSize: 20,
              ),
              12.width,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      LocaleKeys.orders_order_label
                          .tr(namedArgs: {'number': order.shortNumber}),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w800,
                    ),
                    4.height,
                    AppText(
                      names,
                      fontSize: 11.5.sp,
                      color: secondary,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              8.width,
              OrderStatusChip(
                status: order.status,
                rawValue: order.statusValue,
              ),
            ],
          ),
          12.height,
          Divider(
            height: 1,
            thickness: 0.6,
            color: AppColors.borderColor.themeColor.withValues(alpha: 0.12),
          ),
          12.height,
          Row(
            children: [
              AppText(
                LocaleKeys.store_items_count
                    .tr(namedArgs: {'count': '${order.itemsCount}'}),
                fontSize: 12.sp,
                color: secondary,
              ),
              if (order.deliveryEstimate.isNotEmpty && !order.isCancelled) ...[
                AppText(' · ', fontSize: 12.sp, color: secondary),
                Flexible(
                  child: AppText(
                    order.deliveryEstimate,
                    fontSize: 12.sp,
                    color: secondary,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
              const Spacer(),
              AppText(
                '${ConvertHelper.formatPrice(order.total)} ${LocaleKeys.store_currency.tr()}',
                fontSize: 14.sp,
                fontWeight: FontWeight.w800,
                color: AppColors.successColor.themeColor,
              ),
              4.width,
              Icon(
                isRtl
                    ? Icons.chevron_left_rounded
                    : Icons.chevron_right_rounded,
                size: 20.sp,
                color: secondary,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

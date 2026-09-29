import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/convert_helper.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../checkout/presentation/widgets/order_detail_row.dart';
import '../../data/models/my_order_model.dart';
import 'order_status_chip.dart';

class OrderDetailsHeader extends StatelessWidget {
  const OrderDetailsHeader({super.key, required this.order});

  final MyOrderModel order;

  @override
  Widget build(BuildContext context) {
    final cancelledAt = order.cancelledAt;

    return AppCard(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: AppText(
                  LocaleKeys.orders_order_label
                      .tr(namedArgs: {'number': order.shortNumber}),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
              OrderStatusChip(
                status: order.status,
                rawValue: order.statusValue,
              ),
            ],
          ),
          14.height,
          OrderDetailRow(
            label: LocaleKeys.store_total.tr(),
            value:
                '${ConvertHelper.formatPrice(order.total)} ${LocaleKeys.store_currency.tr()}',
            valueColor: AppColors.successColor.themeColor,
            valueFontSize: 15.sp,
          ),
          if (order.deliveryEstimate.isNotEmpty && !order.isCancelled) ...[
            10.height,
            OrderDetailRow(
              label: LocaleKeys.orders_delivery_estimate.tr(),
              value: order.deliveryEstimate,
            ),
          ],
          if (cancelledAt != null) ...[
            10.height,
            OrderDetailRow(
              label: LocaleKeys.orders_cancelled_at.tr(),
              value: ConvertHelper.formatWeekdayDate(cancelledAt.toLocal()),
              valueColor: AppColors.saleRed.themeColor,
            ),
          ],
        ],
      ),
    );
  }
}

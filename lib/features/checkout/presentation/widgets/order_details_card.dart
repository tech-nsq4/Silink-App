import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/convert_helper.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_card.dart';
import '../../data/models/order_model.dart';
import 'order_detail_row.dart';

class OrderDetailsCard extends StatelessWidget {
  const OrderDetailsCard({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final area = order.address.areaParts.join(ConvertHelper.listSeparator);

    return AppCard(
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          if (order.number.isNotEmpty) ...[
            OrderDetailRow(
              label: LocaleKeys.store_order_number.tr(),
              value: order.number,
              valueFontSize: 14.sp,
            ),
            12.height,
          ],
          OrderDetailRow(
            label: LocaleKeys.store_total.tr(),
            value:
                '${ConvertHelper.formatPrice(order.total)} ${LocaleKeys.store_currency.tr()}',
            valueColor: AppColors.successColor.themeColor,
          ),
          12.height,
          OrderDetailRow(
            label: LocaleKeys.store_expected_delivery.tr(),
            value: ConvertHelper.formatWeekdayDate(order.expectedDeliveryAt),
          ),
          if (area.isNotEmpty) ...[
            12.height,
            OrderDetailRow(
              label: LocaleKeys.store_address.tr(),
              value: area,
            ),
          ],
        ],
      ),
    );
  }
}

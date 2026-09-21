import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/convert_helper.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_text.dart';
import 'order_summary_row.dart';
import 'store_section_card.dart';

class OrderSummaryCard extends StatelessWidget {
  const OrderSummaryCard({
    super.key,
    required this.subtotal,
    required this.shipping,
    required this.total,
    this.note,
  });

  final double subtotal;
  final double shipping;
  final double total;
  final String? note;

  @override
  Widget build(BuildContext context) {
    final currency = LocaleKeys.store_currency.tr();
    final shippingValue = shipping <= 0
        ? LocaleKeys.store_free_shipping.tr()
        : '${ConvertHelper.formatPrice(shipping)} $currency';

    return StoreSectionCard(
      title: LocaleKeys.store_order_summary.tr(),
      child: Column(
        children: [
          OrderSummaryRow(
            label: LocaleKeys.store_subtotal.tr(),
            value: '${ConvertHelper.formatPrice(subtotal)} $currency',
          ),
          8.height,
          OrderSummaryRow(
            label: LocaleKeys.store_shipping.tr(),
            value: shippingValue,
          ),
          10.height,
          Divider(height: 1, color: AppColors.borderColor.themeColor),
          10.height,
          OrderSummaryRow(
            label: LocaleKeys.store_total.tr(),
            value: '${ConvertHelper.formatPrice(total)} $currency',
            isTotal: true,
          ),
          if (note != null) ...[
            10.height,
            AppText(
              note!,
              fontSize: 10.5.sp,
              color: AppColors.textSecondaryColor.themeColor,
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}

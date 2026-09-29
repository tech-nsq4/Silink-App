import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/convert_helper.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_text.dart';
import 'cart_summary_row.dart';

class CartSummaryCard extends StatelessWidget {
  const CartSummaryCard({
    super.key,
    required this.subtotal,
    required this.shipping,
    required this.total,
  });

  final double subtotal;
  final double shipping;
  final double total;

  @override
  Widget build(BuildContext context) {
    final currency = LocaleKeys.store_currency.tr();
    final divider = Divider(
      height: 1,
      thickness: 0.6,
      color: AppColors.borderColor.themeColor.withValues(alpha: 0.12),
    );

    return AppCard(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            child: AppText(
              LocaleKeys.store_order_summary.tr(),
              fontSize: 17.sp,
              fontWeight: FontWeight.w800,
            ),
          ),
          divider,
          CartSummaryRow(
            label: LocaleKeys.store_subtotal.tr(),
            value: '${ConvertHelper.formatPrice(subtotal)} $currency',
          ),
          divider,
          CartSummaryRow(
            label: LocaleKeys.store_shipping.tr(),
            value: shipping <= 0
                ? LocaleKeys.store_free_shipping.tr()
                : '${ConvertHelper.formatPrice(shipping)} $currency',
          ),
          divider,
          CartSummaryRow(
            label: LocaleKeys.store_total.tr(),
            value: '${ConvertHelper.formatPrice(total)} $currency',
            valueColor: AppColors.successColor.themeColor,
          ),
        ],
      ),
    );
  }
}

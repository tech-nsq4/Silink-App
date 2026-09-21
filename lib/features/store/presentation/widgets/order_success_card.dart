import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/convert_helper.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_text.dart';
import '../../data/models/payment_method.dart';
import '../../data/models/store_order.dart';
import 'order_summary_row.dart';
import 'store_section_card.dart';

class OrderSuccessCard extends StatelessWidget {
  const OrderSuccessCard({
    super.key,
    required this.order,
    required this.onCopyNumber,
  });

  final StoreOrder order;
  final VoidCallback onCopyNumber;

  @override
  Widget build(BuildContext context) {
    final currency = LocaleKeys.store_currency.tr();
    final addressLines = <String>[
      order.address.fullName,
      order.address.phone,
      ...order.address.lines,
    ].where((line) => line.trim().isNotEmpty).toList(growable: false);

    return StoreSectionCard(
      title: LocaleKeys.store_order_number.tr(),
      action: InkWell(
        onTap: onCopyNumber,
        borderRadius: BorderRadius.circular(12.r),
        child: Row(
          children: [
            Icon(
              Icons.copy_rounded,
              size: 14.sp,
              color: AppColors.mint.themeColor,
            ),
            4.width,
            AppText(
              LocaleKeys.store_copy.tr(),
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.mint.themeColor,
            ),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppText(
            order.number,
            fontSize: 14.sp,
            fontWeight: FontWeight.w800,
          ),
          10.height,
          OrderSummaryRow(
            label: LocaleKeys.store_order_date.tr(),
            value: ConvertHelper.formatDateTime(order.createdAt),
          ),
          8.height,
          OrderSummaryRow(
            label: LocaleKeys.store_payment_method.tr(),
            value: order.paymentMethod.labelKey.tr(),
          ),
          if (addressLines.isNotEmpty) ...[
            10.height,
            Divider(height: 1, color: AppColors.borderColor.themeColor),
            10.height,
            AppText(
              LocaleKeys.store_address.tr(),
              fontSize: 12.5.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.textSecondaryColor.themeColor,
            ),
            6.height,
            for (final line in addressLines) AppText(line, fontSize: 12.sp),
          ],
          12.height,
          Divider(height: 1, color: AppColors.borderColor.themeColor),
          12.height,
          for (final item in order.items) ...[
            Row(
              children: [
                Expanded(
                  child: AppText(
                    '${item.name} × ${item.quantity}',
                    fontSize: 12.sp,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                8.width,
                AppText(
                  '${ConvertHelper.formatPrice(item.total)} $currency',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.mint.themeColor,
                ),
              ],
            ),
            if (item != order.items.last) 8.height,
          ],
        ],
      ),
    );
  }
}

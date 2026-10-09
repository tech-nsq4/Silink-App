import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/extensions/extensions.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/convert_helper.dart';
import '../../../../../core/utils/locale_keys.dart';
import '../../../../../core/widgets/app_text.dart';

class OrderSummaryCard extends StatelessWidget {
  const OrderSummaryCard({
    super.key,
    required this.subtotal,
    required this.shipping,
    required this.total,
  });

  final double subtotal;
  final double shipping;
  final double total;

  Widget _row(String label, String value) => Padding(
        padding: EdgeInsets.symmetric(vertical: 6.h),
        child: Row(
          children: [
            Expanded(
              child: AppText(label,
                  fontSize: 9.sp,
                  color: AppColors.textSecondaryColor.themeColor),
            ),
            AppText(value, fontSize: 9.5.sp, fontWeight: FontWeight.w800),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    final currency = LocaleKeys.store_currency.tr();
    return Container(
      padding: EdgeInsets.fromLTRB(18.w, 14.h, 18.w, 16.h),
      decoration: BoxDecoration(
        color: AppColors.white.themeColor,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: AppColors.studioPanelBorder.themeColor),
      ),
      child: Column(
        children: [
          _row(LocaleKeys.orderFlow_subtotal.tr(),
              '${ConvertHelper.formatPrice(subtotal)} $currency'),
          _row(
            LocaleKeys.orderFlow_delivery.tr(),
            shipping == 0
                ? LocaleKeys.orderFlow_free.tr()
                : '${ConvertHelper.formatPrice(shipping)} $currency',
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final count = (constraints.maxWidth / 7).floor();
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    count,
                    (_) => Container(
                      width: 4,
                      height: 1,
                      color: AppColors.studioStepLine.themeColor,
                    ),
                  ),
                );
              },
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: AppText(
                  LocaleKeys.orderFlow_total.tr(),
                  fontSize: 13.sp,
                  color: AppColors.textSecondaryColor.themeColor,
                ),
              ),
              AppText(
                ConvertHelper.formatPrice(total),
                fontSize: 20.sp,
                fontWeight: FontWeight.w800,
              ),
              4.width,
              Padding(
                padding: EdgeInsets.only(bottom: 3.h),
                child: AppText(currency,
                    fontSize: 8.sp,
                    color: AppColors.textSecondaryColor.themeColor),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

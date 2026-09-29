import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/convert_helper.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_text.dart';
import 'checkout_section_card.dart';

class CheckoutOrderBriefCard extends StatelessWidget {
  const CheckoutOrderBriefCard({
    super.key,
    required this.itemsCount,
    required this.total,
  });

  final int itemsCount;
  final double total;

  @override
  Widget build(BuildContext context) {
    return CheckoutSectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: AppText(
                  LocaleKeys.store_items_count
                      .tr(namedArgs: {'count': '$itemsCount'}),
                  fontSize: 13.sp,
                  color: AppColors.textSecondaryColor.themeColor,
                ),
              ),
              AppText(
                '${ConvertHelper.formatPrice(total)} ${LocaleKeys.store_currency.tr()}',
                fontSize: 14.sp,
                fontWeight: FontWeight.w800,
              ),
            ],
          ),
          10.height,
          AppText(
            LocaleKeys.store_expected_delivery_within.tr(
              namedArgs: {'days': LocaleKeys.store_delivery_days.tr()},
            ),
            fontSize: 11.5.sp,
            color: AppColors.textSecondaryColor.themeColor,
          ),
        ],
      ),
    );
  }
}

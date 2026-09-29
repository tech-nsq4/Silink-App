import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/convert_helper.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_text.dart';

class PaymentTotalCard extends StatelessWidget {
  const PaymentTotalCard({super.key, required this.total});

  final double total;

  @override
  Widget build(BuildContext context) {
    final color = AppColors.successColor.themeColor;

    return AppCard(
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
      child: Column(
        children: [
          AppText(
            LocaleKeys.store_total_amount.tr(),
            fontSize: 13.sp,
            color: AppColors.textSecondaryColor.themeColor,
          ),
          6.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              AppText(
                ConvertHelper.formatPrice(total),
                fontSize: 28.sp,
                fontWeight: FontWeight.w800,
                color: color,
              ),
              6.width,
              AppText(
                LocaleKeys.store_currency.tr(),
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

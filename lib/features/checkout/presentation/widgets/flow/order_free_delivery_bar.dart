import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/extensions/extensions.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_constants.dart';
import '../../../../../core/utils/convert_helper.dart';
import '../../../../../core/utils/locale_keys.dart';
import '../../../../../core/widgets/app_text.dart';

class OrderFreeDeliveryBar extends StatelessWidget {
  const OrderFreeDeliveryBar({super.key, required this.subtotal});

  final double subtotal;

  @override
  Widget build(BuildContext context) {
    final accent = AppColors.accentTeal.themeColor;
    const threshold = AppConstants.defaultFreeShippingThreshold;
    final progress = (subtotal / threshold).clamp(0.0, 1.0);
    final reached = progress >= 1;
    final label = reached
        ? LocaleKeys.orderFlow_freeDelivery.tr()
        : LocaleKeys.orderFlow_freeDeliveryLeft.tr(args: [
            '${ConvertHelper.formatPrice(threshold - subtotal)} ${LocaleKeys.store_currency.tr()}',
          ]);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 14.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(Icons.local_shipping_outlined, size: 16.sp, color: accent),
              8.width,
              AppText(label,
                  fontSize: 9.5.sp, fontWeight: FontWeight.w800, color: accent),
            ],
          ),
          SizedBox(height: 12.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(4.r),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 4.h,
              color: accent,
              backgroundColor: AppColors.studioStepLine.themeColor,
            ),
          ),
        ],
      ),
    );
  }
}

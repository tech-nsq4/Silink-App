import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/convert_helper.dart';
import '../../../../../core/utils/locale_keys.dart';
import '../../../../../core/widgets/app_text.dart';

class OrderTotalCard extends StatelessWidget {
  const OrderTotalCard({super.key, required this.total});

  final double total;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 18.h),
      decoration: BoxDecoration(
        color: AppColors.white.themeColor,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: AppColors.studioPanelBorder.themeColor),
      ),
      child: Column(
        children: [
          AppText(
            LocaleKeys.orderFlow_totalAmount.tr(),
            fontSize: 10.sp,
            color: AppColors.textSecondaryColor.themeColor,
          ),
          SizedBox(height: 8.h),
          AppText(
            '${ConvertHelper.formatPrice(total)} ${LocaleKeys.store_currency.tr()}',
            fontSize: 22.sp,
            fontWeight: FontWeight.w800,
            color: AppColors.accentTeal.themeColor,
          ),
        ],
      ),
    );
  }
}

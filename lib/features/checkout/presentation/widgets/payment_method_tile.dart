import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/custom_tap_effect.dart';
import '../../../../core/widgets/app_text.dart';
import '../../data/models/payment_method.dart';

class PaymentMethodTile extends StatelessWidget {
  const PaymentMethodTile({
    super.key,
    required this.method,
    required this.isSelected,
    required this.onTap,
  });

  final PaymentMethod method;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final accent = AppColors.accentTeal.themeColor;

    return CustomTapEffect(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: isSelected
              ? accent.withValues(alpha: 0.06)
              : AppColors.white.themeColor,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected ? accent : AppColors.studioPanelBorder.themeColor,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 40.w,
              height: 40.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(11.r),
              ),
              child: switch (method) {
                PaymentMethod.creditCard => Icon(
                    Icons.credit_card_rounded,
                    size: 20.sp,
                    color: accent,
                  ),
                PaymentMethod.applePay => AppText(
                    LocaleKeys.store_apple_pay_mark.tr(),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w800,
                    color: accent,
                  ),
                PaymentMethod.cashOnDelivery => Icon(
                    Icons.payments_outlined,
                    size: 20.sp,
                    color: accent,
                  ),
              },
            ),
            12.width,
            Expanded(
              child: AppText(
                method.labelKey.tr(),
                fontSize: 11.sp,
                fontWeight: FontWeight.w800,
              ),
            ),
            Container(
              width: 22.w,
              height: 22.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color:
                      isSelected ? accent : AppColors.studioStepLine.themeColor,
                  width: 1.6,
                ),
              ),
              child: isSelected
                  ? Container(
                      width: 11.w,
                      height: 11.w,
                      decoration: BoxDecoration(
                        color: accent,
                        shape: BoxShape.circle,
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

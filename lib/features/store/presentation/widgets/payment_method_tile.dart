import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/app_text.dart';
import '../../data/models/payment_method.dart';

class PaymentMethodTile extends StatelessWidget {
  const PaymentMethodTile({
    super.key,
    required this.method,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final PaymentMethod method;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.mintSoft.themeColor
              : AppColors.cardColor.themeColor,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: isSelected
                ? AppColors.brandTeal.themeColor
                : AppColors.borderColor.themeColor,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20.sp,
              color: isSelected
                  ? AppColors.mint.themeColor
                  : AppColors.textSecondaryColor.themeColor,
            ),
            10.width,
            Expanded(
              child: AppText(
                method.labelKey.tr(),
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            Container(
              width: 18.w,
              height: 18.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? AppColors.brandTeal.themeColor
                      : AppColors.borderColor.themeColor,
                  width: 1.5,
                ),
              ),
              child: isSelected
                  ? Container(
                      width: 9.w,
                      height: 9.w,
                      decoration: BoxDecoration(
                        color: AppColors.brandTeal.themeColor,
                        shape: BoxShape.circle,
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}

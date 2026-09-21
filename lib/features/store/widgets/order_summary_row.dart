import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/app_text.dart';

class OrderSummaryRow extends StatelessWidget {
  const OrderSummaryRow({
    super.key,
    required this.label,
    required this.value,
    this.isTotal = false,
  });

  final String label;
  final String value;
  final bool isTotal;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText(
          label,
          fontSize: isTotal ? 14.sp : 12.5.sp,
          fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
          color: isTotal
              ? AppColors.textPrimaryColor.themeColor
              : AppColors.textSecondaryColor.themeColor,
        ),
        AppText(
          value,
          fontSize: isTotal ? 15.sp : 12.5.sp,
          fontWeight: isTotal ? FontWeight.w800 : FontWeight.w600,
          color: isTotal
              ? AppColors.mint.themeColor
              : AppColors.textPrimaryColor.themeColor,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/app_text.dart';

class CartSummaryRow extends StatelessWidget {
  const CartSummaryRow({
    super.key,
    required this.label,
    required this.value,
    this.valueColor,
  });

  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText(
            label,
            fontSize: 13.sp,
            color: AppColors.textSecondaryColor.themeColor,
          ),
          AppText(
            value,
            fontSize: 13.5.sp,
            fontWeight: FontWeight.w800,
            color: valueColor ?? AppColors.textPrimaryColor.themeColor,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/app_text.dart';

class OrderDetailRow extends StatelessWidget {
  const OrderDetailRow({
    super.key,
    required this.label,
    required this.value,
    this.valueColor,
    this.valueFontSize,
  });

  final String label;
  final String value;
  final Color? valueColor;
  final double? valueFontSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppText(
          label,
          fontSize: 12.5.sp,
          color: AppColors.textSecondaryColor.themeColor,
        ),
        12.width,
        Expanded(
          child: AppText(
            value,
            fontSize: valueFontSize ?? 12.5.sp,
            fontWeight: FontWeight.w800,
            color: valueColor ?? AppColors.textPrimaryColor.themeColor,
            textAlign: TextAlign.end,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

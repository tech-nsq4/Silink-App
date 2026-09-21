import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/extensions/extensions.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/app_text.dart';

class ProductInfoRow extends StatelessWidget {
  const ProductInfoRow({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          label,
          fontSize: 12.sp,
          fontWeight: FontWeight.w700,
          color: AppColors.textSecondaryColor.themeColor,
        ),
        12.width,
        Expanded(
          child: AppText(
            value,
            fontSize: 12.sp,
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}

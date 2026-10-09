import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/app_text_field.dart';
import 'shop_section_label.dart';

class ShopField extends StatelessWidget {
  const ShopField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.maxLines = 1,
    this.onChanged,
  });

  final String label;
  final String hint;
  final TextEditingController controller;
  final int maxLines;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ShopSectionLabel(text: label),
          CustomTextField(
            controller: controller,
            hint: hint,
            maxLines: maxLines,
            onChanged: onChanged,
            borderRadius: 14.r,
            fillColor: AppColors.white.themeColor,
            borderColor: AppColors.studioPanelBorder.themeColor,
            focusedBorderColor: AppColors.accentTeal.themeColor,
          ),
        ],
      ),
    );
  }
}

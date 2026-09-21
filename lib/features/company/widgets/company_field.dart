import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:Silink/core/widgets/app_text_field.dart';

class CompanyField extends StatelessWidget {
  const CompanyField({
    super.key,
    required this.label,
    required this.hint,
    this.controller,
    this.validator,
    this.keyboardType,
    this.maxLines = 1,
    this.onChanged,
    this.suffixIcon,
    this.enabled = true,
  });

  final String label;
  final String hint;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final int maxLines;
  final ValueChanged<String>? onChanged;
  final Widget? suffixIcon;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          label,
          fontSize: 13.5.sp,
          fontWeight: FontWeight.w600,
        ),
        8.height,
        CustomTextField(
          hint: hint,
          controller: controller,
          validator: validator,
          keyboardType: keyboardType,
          maxLines: maxLines,
          onChanged: onChanged,
          suffixIcon: suffixIcon,
          enabled: enabled,
        ),
      ],
    );
  }
}

class CompanySectionCard extends StatelessWidget {
  const CompanySectionCard({
    super.key,
    required this.title,
    this.trailing,
    required this.child,
  });

  final String title;
  final Widget? trailing;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardColor.themeColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.borderColor.themeColor),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: AppText(
                  title,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              if (trailing != null) trailing!,
            ],
          ),
          12.height,
          child,
        ],
      ),
    );
  }
}

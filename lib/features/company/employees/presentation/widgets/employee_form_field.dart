import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:Silink/core/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmployeeFormField extends StatelessWidget {
  const EmployeeFormField({
    super.key,
    required this.label,
    required this.controller,
    this.hint = '',
    this.keyboardType,
    this.validator,
    this.isPassword = false,
    this.onChanged,
  });

  final String label;
  final TextEditingController controller;
  final String hint;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final bool isPassword;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(label, fontSize: 13.sp, fontWeight: FontWeight.w600),
        8.height,
        CustomTextField(
          hint: hint,
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,
          isPassword: isPassword,
          onChanged: onChanged,
          borderRadius: 14,
          borderColor: AppColors.borderColor.themeColor,
        ),
      ],
    );
  }
}

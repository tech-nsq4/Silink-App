import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'studio_field_label.dart';
import 'studio_input.dart';

class StudioField extends StatelessWidget {
  const StudioField({
    super.key,
    required this.label,
    required this.controller,
    this.hint,
    this.required = false,
    this.onChanged,
    this.keyboardType,
    this.maxLines = 1,
    this.ltr = false,
    this.obscure = false,
    this.readOnly = false,
    this.onTap,
    this.prefixIcon,
  });

  final String label;
  final TextEditingController controller;
  final String? hint;
  final bool required;
  final ValueChanged<String>? onChanged;
  final TextInputType? keyboardType;
  final int maxLines;
  final bool ltr;
  final bool obscure;
  final bool readOnly;
  final VoidCallback? onTap;
  final IconData? prefixIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        StudioFieldLabel(label: label, required: required),
        SizedBox(height: 7.h),
        StudioInput(
          controller: controller,
          hint: hint,
          onChanged: onChanged,
          keyboardType: keyboardType,
          maxLines: maxLines,
          ltr: ltr,
          obscure: obscure,
          readOnly: readOnly,
          onTap: onTap,
          prefixIcon: prefixIcon,
        ),
      ],
    );
  }
}

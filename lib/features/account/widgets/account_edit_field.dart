import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/extensions/extensions.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/app_text_field.dart';

class AccountEditField extends StatelessWidget {
  const AccountEditField({
    super.key,
    required this.label,
    required this.hint,
    this.keyboardType,
    this.controller,
  });

  final String label;
  final String hint;
  final TextInputType? keyboardType;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppText(
          label,
          fontSize: 12.sp,
          fontWeight: FontWeight.w700,
        ),
        6.height,
        CustomTextField(
          hint: hint,
          keyboardType: keyboardType,
          controller: controller,
        ),
      ],
    );
  }
}

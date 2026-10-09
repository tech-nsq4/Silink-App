import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/widgets/app_text_field.dart';
import 'workspace_field_label.dart';

class WorkspaceField extends StatelessWidget {
  const WorkspaceField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.required = false,
    this.keyboardType,
    this.maxLines = 1,
    this.onChanged,
  });

  final String label;
  final String hint;
  final TextEditingController controller;
  final bool required;
  final TextInputType? keyboardType;
  final int maxLines;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 18.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          WorkspaceFieldLabel(text: label, required: required),
          CustomTextField(
            controller: controller,
            hint: hint,
            keyboardType: keyboardType,
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

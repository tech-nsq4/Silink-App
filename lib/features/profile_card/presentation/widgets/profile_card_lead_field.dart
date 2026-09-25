import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:Silink/core/widgets/app_text_field.dart';
import 'package:Silink/core/widgets/field_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileCardLeadField extends StatelessWidget {
  const ProfileCardLeadField({
    super.key,
    required this.label,
    required this.hint,
    this.controller,
    this.isRequired = false,
    this.optionalLabel,
    this.keyboardType,
    this.maxLines = 1,
    this.validator,
    this.field,
  });

  final String label;
  final String hint;
  final TextEditingController? controller;
  final bool isRequired;
  final String? optionalLabel;
  final TextInputType? keyboardType;
  final int maxLines;
  final String? Function(String?)? validator;
  final Widget? field;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            FieldLabel(text: label, required: isRequired),
            if (optionalLabel != null)
              Padding(
                padding: EdgeInsetsDirectional.only(start: 4.w, bottom: 4.h),
                child: AppText(
                  optionalLabel!,
                  fontSize: 12.sp,
                  color: AppColors.textSecondaryColor.themeColor,
                ),
              ),
          ],
        ),
        field ??
            CustomTextField(
              controller: controller,
              hint: hint,
              keyboardType: keyboardType,
              maxLines: maxLines,
              fillColor: AppColors.fieldFill,
              validator: validator,
            ),
      ],
    );
  }
}

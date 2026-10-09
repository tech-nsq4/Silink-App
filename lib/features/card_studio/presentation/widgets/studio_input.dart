import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_constants.dart';

class StudioInput extends StatelessWidget {
  const StudioInput({
    super.key,
    required this.controller,
    this.hint,
    this.onChanged,
    this.keyboardType,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.ltr = false,
    this.obscure = false,
    this.readOnly = false,
    this.onTap,
    this.prefixIcon,
  });

  final TextEditingController controller;
  final String? hint;
  final ValueChanged<String>? onChanged;
  final TextInputType? keyboardType;
  final int maxLines;
  final int? minLines;
  final int? maxLength;
  final bool ltr;
  final bool obscure;
  final bool readOnly;
  final VoidCallback? onTap;
  final IconData? prefixIcon;

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(9.r),
      borderSide: BorderSide(color: AppColors.studioFieldBorder.themeColor),
    );
    return TextField(
      controller: controller,
      onChanged: onChanged,
      keyboardType: keyboardType,
      maxLines: obscure ? 1 : maxLines,
      obscureText: obscure,
      readOnly: readOnly,
      onTap: onTap,
      minLines: minLines,
      maxLength: maxLength,
      textDirection: ltr ? TextDirection.ltr : null,
      style: TextStyle(
        fontFamily: AppFonts.familyFont,
        fontSize: 12.sp,
        height: 1.6,
        color: AppColors.studioFieldText.themeColor,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintTextDirection: ltr ? TextDirection.ltr : null,
        hintStyle: TextStyle(
          fontFamily: AppFonts.familyFont,
          fontSize: 11.sp,
          color: AppColors.studioFieldHint.themeColor,
        ),
        counterText: '',
        prefixIcon: prefixIcon == null
            ? null
            : Icon(prefixIcon,
                size: 18.sp, color: AppColors.fieldIcon.themeColor),
        isDense: true,
        filled: true,
        fillColor: AppColors.studioFieldFill.themeColor,
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        border: border,
        enabledBorder: border,
        focusedBorder: border.copyWith(
          borderSide: BorderSide(color: AppColors.accentTeal.themeColor),
        ),
      ),
    );
  }
}

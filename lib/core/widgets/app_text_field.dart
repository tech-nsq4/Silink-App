import 'package:Silink/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.hint,
    this.label,
    this.controller,
    this.validator,
    this.keyboardType,
    this.isPassword = false,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLines = 1,
    this.onChanged,
    this.enabled = true,
    this.readOnly = false,
    this.onTap,
    this.filled = true,
    this.fillColor,
    this.borderColor,
    this.focusedBorderColor,
    this.borderRadius,
    this.contentPadding,
    this.textStyle,
    this.hintStyle,
    this.labelStyle,
  });

  final String hint;
  final String? label;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool isPassword;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int maxLines;
  final ValueChanged<String>? onChanged;
  final bool enabled;
  final bool readOnly;
  final VoidCallback? onTap;
  final bool filled;
  final Color? fillColor;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final double? borderRadius;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    const defaultFillColor = AppColors.fieldFill;
    const defaultBorderColor = Color(0xFFE0E0E0);
    final defaultHintColor = AppColors.textSecondaryColor.themeColor;
    const defaultTextColor = Color(0xFF2C3430);

    final borderRadius = widget.borderRadius ?? 16;
    final enabledBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide(color: widget.borderColor ?? defaultBorderColor),
    );

    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      keyboardType: widget.keyboardType,
      obscureText: widget.isPassword && _obscure,
      maxLines: widget.isPassword ? 1 : widget.maxLines,
      onChanged: widget.onChanged,
      enabled: widget.enabled,
      readOnly: widget.readOnly,
      onTap: widget.onTap,
      style: widget.textStyle ??
          const TextStyle(
            fontFamily: 'Tajawal',
            fontWeight: FontWeight.w600,
            fontSize: 15,
            color: defaultTextColor,
          ),
      decoration: InputDecoration(
        hintText: widget.hint,
        labelText: widget.label,
        hintStyle: widget.hintStyle ??
            TextStyle(
              fontFamily: 'Tajawal',
              fontSize: 14.sp,
              color: defaultHintColor,
              fontWeight: FontWeight.w400,
            ),
        labelStyle: widget.labelStyle ??
            TextStyle(
              fontFamily: 'Tajawal',
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
              color: defaultHintColor,
            ),
        prefixIconConstraints: BoxConstraints(
          minWidth: 44.w,
          minHeight: 0,
        ),
        suffixIconConstraints: BoxConstraints(
          minWidth: 44.w,
          minHeight: 0,
        ),
        prefixIcon: widget.prefixIcon != null
            ? UnconstrainedBox(child: widget.prefixIcon)
            : null,
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(_obscure
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined),
                onPressed: () => setState(() => _obscure = !_obscure),
              )
            : (widget.suffixIcon != null
                ? UnconstrainedBox(child: widget.suffixIcon)
                : null),
        filled: widget.filled,
        fillColor: widget.fillColor ?? defaultFillColor,
        border: enabledBorder,
        enabledBorder: enabledBorder,
        focusedBorder: OutlineInputBorder(
          
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color:
                widget.focusedBorderColor ?? AppColors.mint.themeColor,
            width: 1.2,
          ),
        ),
        disabledBorder: enabledBorder,
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: AppColors.errorColor.themeColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide:
              BorderSide(color: AppColors.errorColor.themeColor, width: 1.2),
        ),
        contentPadding: widget.contentPadding ??
            EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
      ),
    );
  }
}

// @Deprecated('Use CustomTextField instead.')
// typedef AppTextField = CustomTextField;
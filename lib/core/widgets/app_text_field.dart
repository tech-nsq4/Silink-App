import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/app_colors.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.hint,
    this.label,
    this.controller,
    this.focusNode,
    this.validator,
    this.keyboardType,
    this.isPassword = false,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLines = 1,
    this.maxLength,
    this.inputFormatters,
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
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.cursorWidth = 2.0,
    this.cursorHeight,
    this.strutStyle,
    this.counterText,
    this.isCollapsed = false,
    this.bordered = true,
  });

  final String hint;
  final String? label;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool isPassword;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int maxLines;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
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
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;
  final double cursorWidth;
  final double? cursorHeight;
  final StrutStyle? strutStyle;
  final String? counterText;
  final bool isCollapsed;
  final bool bordered;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    final defaultFillColor = AppColors.fieldFill;
    const defaultBorderColor = Color(0xFFE0E0E0);
    final defaultHintColor = AppColors.textSecondaryColor.themeColor;
    const defaultTextColor = Color(0xFF2C3430);

    final borderRadius = widget.borderRadius ?? 16;
    final enabledBorder = widget.bordered
        ? OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide:
                BorderSide(color: widget.borderColor ?? defaultBorderColor),
          )
        : InputBorder.none;

    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      validator: widget.validator,
      keyboardType: widget.keyboardType,
      obscureText: widget.isPassword && _obscure,
      maxLines: widget.isPassword ? 1 : widget.maxLines,
      maxLength: widget.maxLength,
      inputFormatters: widget.inputFormatters,
      onChanged: widget.onChanged,
      enabled: widget.enabled,
      readOnly: widget.readOnly,
      onTap: widget.onTap,
      textAlign: widget.textAlign,
      textAlignVertical: widget.textAlignVertical,
      cursorWidth: widget.cursorWidth,
      cursorHeight: widget.cursorHeight,
      strutStyle: widget.strutStyle,
      style: widget.textStyle ??
          const TextStyle(
            fontFamily: 'Cairo',
            fontWeight: FontWeight.w600,
            fontSize: 15,
            color: defaultTextColor,
          ),
      decoration: InputDecoration(
        hintText: widget.hint,
        labelText: widget.label,
        counterText: widget.counterText,
        isCollapsed: widget.isCollapsed,
        hintStyle: widget.hintStyle ??
            TextStyle(
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w500,
              fontSize: 15,
              color: defaultHintColor,
            ),
        labelStyle: widget.labelStyle ??
            TextStyle(
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w500,
              fontSize: 15,
              color: defaultHintColor,
            ),
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.isPassword
            ? IconButton(
          icon: Icon(
              _obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined),
          onPressed: () => setState(() => _obscure = !_obscure),
        )
            : widget.suffixIcon,
        filled: widget.filled,
        fillColor: widget.fillColor ?? defaultFillColor,
        border: enabledBorder,
        enabledBorder: enabledBorder,
        focusedBorder: widget.bordered
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(
                  color:
                      widget.focusedBorderColor ?? AppColors.mint.themeColor,
                  width: 1.2,
                ),
              )
            : InputBorder.none,
        disabledBorder: enabledBorder,
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: AppColors.errorColor.themeColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: AppColors.errorColor.themeColor, width: 1.2),
        ),
        contentPadding: widget.contentPadding ??
            const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      ),
    );
  }
}

@Deprecated('Use CustomTextField instead.')
typedef AppTextField = CustomTextField;

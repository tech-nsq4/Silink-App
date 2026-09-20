import 'package:Silink/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final double? height;
  final TextOverflow? overflow;
  final TextDecoration? decoration;
  final String? fontFamily;

  const AppText(
    this.text, {
    super.key,
    this.fontSize,
    this.height,
    this.fontWeight,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.decoration,
    this.fontFamily,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign ?? TextAlign.start,
      maxLines: maxLines,
      overflow: overflow,
      style: TextStyle(
        height: height,
        fontFamily: fontFamily ?? "Cairo",
            // 'Tajawal',
        fontSize: fontSize ?? 14,
        fontWeight: fontWeight ?? FontWeight.w400,
        color: color ?? AppColors.textPrimaryColor.themeColor,
        decoration: decoration ?? TextDecoration.none,
        decorationColor: AppColors.textPrimaryColor.themeColor,
        decorationThickness: 3,
      ),
    );
  }
}

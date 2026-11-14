import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_images.dart';

class SilinkBrand extends StatelessWidget {
  const SilinkBrand({super.key, this.fontSize = 26, this.color});

  final double fontSize;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final tint = color ?? AppColors.textPrimaryColor.themeColor;
    final onDark = tint.computeLuminance() > 0.5;
    return Image.asset(
      onDark ? AppImages.logoLight : AppImages.logoDark,
      height: fontSize * 1.5,
      fit: BoxFit.contain,
      filterQuality: FilterQuality.high,
    );
  }
}

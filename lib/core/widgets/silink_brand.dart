import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_constants.dart';

class SilinkBrand extends StatelessWidget {
  const SilinkBrand({super.key, this.fontSize = 26, this.color});

  final double fontSize;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final dotSize = fontSize * 0.26;
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            'silink',
            style: TextStyle(
              fontFamily: AppFonts.familyFont,
              fontSize: fontSize,
              fontWeight: FontWeight.w800,
              letterSpacing: -fontSize * 0.058,
              height: 1,
              color: color ?? AppColors.textPrimaryColor.themeColor,
            ),
          ),
          SizedBox(width: fontSize * 0.06),
          Padding(
            padding: EdgeInsets.only(bottom: fontSize * 0.2),
            child: Container(
              width: dotSize,
              height: dotSize,
              decoration: BoxDecoration(
                color: AppColors.accentTeal.themeColor,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

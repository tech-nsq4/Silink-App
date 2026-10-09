import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_constants.dart';

class StudioFieldLabel extends StatelessWidget {
  const StudioFieldLabel(
      {super.key, required this.label, this.required = false});

  final String label;
  final bool required;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: label,
        children: [
          if (required)
            TextSpan(
              text: ' *',
              style: TextStyle(color: AppColors.accentTeal.themeColor),
            ),
        ],
      ),
      style: TextStyle(
        fontFamily: AppFonts.familyFont,
        fontSize: 10.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.studioFieldLabel.themeColor,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/widgets/app_text.dart';

class MyCardSmallPill extends StatelessWidget {
  const MyCardSmallPill({
    super.key,
    required this.label,
    required this.background,
    required this.textColor,
  });

  final String label;
  final Color background;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: AppText(
        label,
        fontSize: 11.sp,
        fontWeight: FontWeight.w700,
        color: textColor,
      ),
    );
  }
}

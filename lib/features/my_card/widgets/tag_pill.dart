import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/widgets/app_text.dart';

class TagPill extends StatelessWidget {
  const TagPill({
    super.key,
    required this.label,
    required this.background,
    required this.textColor,
    this.dotColor,
  });

  final String label;
  final Color background;
  final Color textColor;
  final Color? dotColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (dotColor != null) ...[
            Container(
              width: 6.w,
              height: 6.w,
              decoration:
                  BoxDecoration(color: dotColor, shape: BoxShape.circle),
            ),
            SizedBox(width: 5.w),
          ],
          AppText(label,
              fontSize: 10.sp, fontWeight: FontWeight.w600, color: textColor),
        ],
      ),
    );
  }
}

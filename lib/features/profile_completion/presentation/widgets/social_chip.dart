import 'package:Silink/core/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/app_text.dart';

class SocialChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final Color background;
  final VoidCallback onTap;

  const SocialChip({
    super.key,
    required this.label,
    required this.icon,
    required this.color,
    required this.background,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(color: color.withValues(alpha: 0.18)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppText(label, fontSize: 12.sp, fontWeight: FontWeight.w600),
            8.width,
            Container(
              width: 24.w,
              height: 24.w,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              child: Icon(icon, size: 13.sp, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
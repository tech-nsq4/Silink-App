import 'package:Silink/core/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/widgets/app_text.dart';

class SocialChip extends StatelessWidget {
  final String label;
  final Widget badge;
  final Color background;
  final VoidCallback onTap;

  const SocialChip({
    super.key,
    required this.label,
    required this.badge,
    required this.background,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            badge,
            8.width,
            AppText(label, fontSize: 12.sp, fontWeight: FontWeight.w600),
          ],
        ),
      ),
    );
  }
}

import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileCardToolbarPill extends StatelessWidget {
  const ProfileCardToolbarPill({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
    this.borderColor,
  });

  final IconData icon;
  final String label;
  final Color color;
  final Color? borderColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 7.h),
        decoration: BoxDecoration(
          color: color.withValues(alpha: borderColor == null ? 0.12 : 0),
          borderRadius: BorderRadius.circular(20.r),
          border:
              Border.all(color: borderColor ?? color.withValues(alpha: 0.6)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14.sp, color: color),
            6.width,
            AppText(
              label,
              fontSize: 12.sp,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ],
        ),
      ),
    );
  }
}

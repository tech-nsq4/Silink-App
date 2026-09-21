import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChannelBadge extends StatelessWidget {
  const ChannelBadge({
    super.key,
    required this.label,
    required this.color,
    this.textColor = Colors.white,
  });

  final String label;
  final Color color;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 34.w,
      height: 34.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.r),
      ),
      padding: 5.paddingTop,
      child: AppText(
        label,
        fontSize: 11.sp,
        fontWeight: FontWeight.w800,
        color: textColor,
      ),
    );
  }
}

class LinkBadge extends StatelessWidget {
  const LinkBadge({super.key, required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 34.w,
      height: 34.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.fieldFill,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Icon(icon, size: 17.sp, color: const Color(0xFF64748B)),
    );
  }
}

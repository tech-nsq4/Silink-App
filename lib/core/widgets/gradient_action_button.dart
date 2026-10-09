import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';
import 'app_text.dart';
import 'custom_tap_effect.dart';

class GradientActionButton extends StatelessWidget {
  const GradientActionButton({
    super.key,
    required this.title,
    required this.onTap,
    this.loadingTitle,
    this.loading = false,
    this.icon = Icons.arrow_forward_rounded,
    this.radius = 12,
    this.fontSize = 12,
    this.minHeight = 47,
    this.elevated = false,
    this.enabled = true,
    this.trailing,
    this.centerTitle = false,
  });

  final String title;
  final String? loadingTitle;
  final VoidCallback onTap;
  final bool loading;
  final IconData icon;
  final double radius;
  final double fontSize;
  final double minHeight;
  final bool elevated;
  final bool enabled;
  final String? trailing;
  final bool centerTitle;

  @override
  Widget build(BuildContext context) {
    final foreground = AppColors.white.themeColor;
    return CustomTapEffect(
      isClickable: enabled && !loading,
      onTap: enabled && !loading ? onTap : null,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 150),
        opacity: loading ? 0.45 : (enabled ? 1 : 0.4),
        child: Container(
          constraints: BoxConstraints(minHeight: minHeight.h),
          padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 15.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius.r),
            boxShadow: elevated
                ? [
                    BoxShadow(
                      color: AppColors.accentTeal.themeColor
                          .withValues(alpha: 0.07),
                      blurRadius: 12,
                      offset: const Offset(0, 5),
                    ),
                  ]
                : null,
            gradient: LinearGradient(
              colors: [
                AppColors.accentTeal.themeColor,
                AppColors.accentBlue.themeColor,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Row(
            mainAxisAlignment: centerTitle
                ? MainAxisAlignment.center
                : MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: AppText(
                  loading ? (loadingTitle ?? title) : title,
                  fontSize: fontSize.sp,
                  fontWeight: FontWeight.w800,
                  color: foreground,
                ),
              ),
              if (centerTitle)
                const SizedBox.shrink()
              else if (trailing != null)
                AppText(
                  trailing!,
                  fontSize: fontSize.sp,
                  fontWeight: FontWeight.w800,
                  color: foreground,
                )
              else
                Icon(icon, size: 17.sp, color: foreground),
            ],
          ),
        ),
      ),
    );
  }
}

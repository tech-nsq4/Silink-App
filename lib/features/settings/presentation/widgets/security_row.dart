import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/app_text.dart';

class SecurityRow extends StatelessWidget {
  const SecurityRow({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.badge,
    this.onTap,
    this.destructive = false,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final String? badge;
  final VoidCallback? onTap;
  final bool destructive;

  @override
  Widget build(BuildContext context) {
    final error = AppColors.errorColor.themeColor;
    final secondary = AppColors.textSecondaryColor.themeColor;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
        child: Row(
          children: [
            Container(
              width: 34.w,
              height: 34.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: destructive
                    ? error.withValues(alpha: 0.08)
                    : AppColors.studioSelectFill.themeColor,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(icon,
                  size: 17.sp, color: destructive ? error : secondary),
            ),
            12.width,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: AppText(
                          title,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w800,
                          color: destructive ? error : null,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (badge != null) ...[
                        6.width,
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 7.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color: AppColors.accentTeal.themeColor
                                .withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: AppText(
                            badge!,
                            fontSize: 7.sp,
                            fontWeight: FontWeight.w800,
                            color: AppColors.accentTeal.themeColor,
                          ),
                        ),
                      ],
                    ],
                  ),
                  if (subtitle != null) ...[
                    SizedBox(height: 3.h),
                    AppText(subtitle!, fontSize: 8.5.sp, color: secondary),
                  ],
                ],
              ),
            ),
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }
}

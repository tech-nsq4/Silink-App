import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/utils/app_colors.dart';

/// Circular badge that holds either a Material icon or an svg asset.
class AccountIconBadge extends StatelessWidget {
  const AccountIconBadge({
    super.key,
    this.icon,
    this.iconPath,
    this.iconColor,
    this.backgroundColor,
  }) : assert(icon != null || iconPath != null,
            'Provide either an icon or an icon path');

  final IconData? icon;
  final String? iconPath;
  final Color? iconColor;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36.w,
      height: 36.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.fieldFill,
        shape: BoxShape.circle,
      ),
      child: icon != null
          ? Icon(
              icon,
              size: 17.sp,
              color: iconColor,
            )
          : SvgPicture.asset(
              iconPath!,
              height: 17.h,
            ),
    );
  }
}

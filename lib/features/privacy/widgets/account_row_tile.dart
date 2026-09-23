import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/extensions/extensions.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/app_text.dart';

class AccountRowTile extends StatelessWidget {
  const AccountRowTile({
    super.key,
    required this.label,
    this.leading,
    this.subtitle,
    this.trailing,
    this.showChevron = false,
    this.onTap,
    required this.icon,
    this.iconColor,
  });

  final String label;
  final Widget? leading;
  final String? subtitle;
  final Widget? trailing;
  final bool showChevron;
  final VoidCallback? onTap;
  final String icon;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    final content = Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        children: [
          Container(
            height: 36.h,
            width: 36.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.fieldFill.withValues(alpha: 0.5),
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              icon,
              colorFilter: ColorFilter.mode(
                iconColor ?? AppColors.textSecondaryColor.themeColor,
                BlendMode.srcIn,
              ),
            ),
          ),
          12.width,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  label,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: iconColor ?? AppColors.textPrimaryColor.themeColor,
                ),
                if (subtitle != null) ...[
                  3.height,
                  AppText(
                    subtitle!,
                    fontSize: 12.sp,
                    color: AppColors.textSecondaryColor.themeColor,
                  ),
                ],
              ],
            ),
          ),
          8.width,
          if (trailing != null)
            trailing!
          else if (showChevron)
            Icon(
              Icons.arrow_forward_ios,
              size: 14.sp,
              color: iconColor ?? AppColors.hintColor.themeColor,
            ),
        ],
      ),
    );

    if (onTap == null) {
      return content;
    }

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: content,
    );
  }
}

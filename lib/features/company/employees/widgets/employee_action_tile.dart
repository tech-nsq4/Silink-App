import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/app_images.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmployeeActionTile extends StatelessWidget {
  const EmployeeActionTile({
    super.key,
    required this.iconAsset,
    required this.title,
    required this.onTap,
    this.destructive = false,
    this.showDivider = true,
  });

  final String iconAsset;
  final String title;
  final VoidCallback onTap;
  final bool destructive;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final color = destructive
        ? AppColors.errorColor.themeColor
        : AppColors.textPrimaryColor.themeColor;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 13.h),
        decoration: BoxDecoration(
          border: showDivider
              ? Border(
                  bottom: BorderSide(
                    color: AppColors.dividerColor.themeColor,
                  ),
                )
              : null,
        ),
        child: Row(
          children: [
            Container(
              width: 34.w,
              height: 34.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.surfaceColor.themeColor,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: SvgPicture.asset(
                iconAsset,
                width: 18.w,
                height: 18.h,
                colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
              ),
            ),
            10.width,
            Expanded(
              child: AppText(
                title,
                fontSize: 13.sp,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
            SvgPicture.asset(
              AppImages.iconsExternal,
              width: 14.w,
              height: 14.h,
              colorFilter: ColorFilter.mode(
                AppColors.textSecondaryColor.themeColor.withValues(alpha: 0.35),
                BlendMode.srcIn,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

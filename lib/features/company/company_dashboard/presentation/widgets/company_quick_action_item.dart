import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CompanyQuickActionItem extends StatelessWidget {
  const CompanyQuickActionItem({
    super.key,
    required this.iconAsset,
    required this.label,
    required this.onTap,
    this.showDivider = false,
  });

  final String iconAsset;
  final String label;
  final VoidCallback onTap;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          border: showDivider
              ? Border(
                  bottom: BorderSide(
                    color: AppColors.borderColor.themeColor.withValues(
                      alpha: 0.5,
                    ),
                  ),
                )
              : null,
        ),
        child: Row(
          children: [
            Container(
              width: 36.w,
              height: 36.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.fieldFill,
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                iconAsset,
                width: 18.w,
                height: 18.h,
                fit: BoxFit.contain,
                colorFilter: ColorFilter.mode(
                  AppColors.textSecondaryColor.themeColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
            12.width,
            Expanded(
              child: AppText(
                label,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded,
                size: 12.h, color: AppColors.textSecondaryColor.themeColor),
          ],
        ),
      ),
    );
  }
}

import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class UsageTypeCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String icon;
  final Color iconColor;
  final bool isSelected;
  final VoidCallback onTap;

  const UsageTypeCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14.r),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        width: double.infinity,
        padding: 14.paddingHorizontal + 14.paddingVert,
        decoration: BoxDecoration(
          color: isSelected
              ? iconColor.withValues(alpha: 0.06)
              : AppColors.cardColor.themeColor,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: isSelected ? iconColor : AppColors.dividerColor.themeColor,
            width: isSelected ? 1.6 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 46.w,
              height: 46.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: SvgPicture.asset(icon),
            ),
            12.width,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    title,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimaryColor.themeColor,
                  ),
                  4.height,
                  AppText(
                    subtitle,
                    fontSize: 11.sp,
                    height: 1.6,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondaryColor.themeColor.withOpacity(0.8),
                    maxLines: 2,
                  ),
                ],
              ),
            ),
            8.width,
            Icon(
              isSelected ? Icons.check_circle : Icons.chevron_right,
              color:
                  isSelected ? iconColor : AppColors.textSecondaryColor.themeColor,
              size: 20.sp,
            ),
          ],
        ),
      ),
    );
  }
}

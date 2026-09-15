import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TemplateOptionCard extends StatelessWidget {
  const TemplateOptionCard({
    super.key,
    required this.previewColor,
    required this.title,
    required this.subtitle,
    required this.badgeLabel,
    required this.badgeIcon,
    required this.badgeColor,
    required this.badgeTextColor,
    required this.selected,
    required this.onTap,
  });

  final Color previewColor;
  final String title;
  final String subtitle;
  final String badgeLabel;
  final IconData badgeIcon;
  final Color badgeColor;
  final Color badgeTextColor;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18.r),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white.themeColor,
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(
            color: selected
                ? AppColors.mint.themeColor
                : AppColors.dividerColor.themeColor,
            width: selected ? 1.6 : 1,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 90.h,
              width: double.infinity,
              color: previewColor,
              padding: EdgeInsets.all(14.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 34.w,
                    height: 34.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.22),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: AppText(
                      'س',
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _bar(46.w),
                      SizedBox(width: 6.w),
                      _bar(28.w),
                      SizedBox(width: 6.w),
                      _bar(28.w),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(14.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: badgeColor,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(badgeIcon, size: 14.sp, color: badgeTextColor),
                        SizedBox(width: 4.w),
                        AppText(
                          badgeLabel,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w700,
                          color: badgeTextColor,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      AppText(
                        title,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                      ),
                      AppText(
                        subtitle,
                        fontSize: 11.sp,
                        color: AppColors.textSecondaryColor.themeColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bar(double width) {
    return Container(
      width: width,
      height: 8.h,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(4.r),
      ),
    );
  }
}

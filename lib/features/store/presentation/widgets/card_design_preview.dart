import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_images.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_text.dart';

class CardDesignPreview extends StatelessWidget {
  const CardDesignPreview({
    super.key,
    required this.name,
    required this.jobTitle,
    required this.company,
    required this.color,
    required this.fontFamily,
  });

  final String name;
  final String jobTitle;
  final String company;
  final Color color;
  final String fontFamily;

  @override
  Widget build(BuildContext context) {
    final foreground = AppColors.overlayOnDark.themeColor;
    final displayName =
        name.trim().isEmpty ? LocaleKeys.store_full_name.tr() : name;

    return AspectRatio(
      aspectRatio: 1.6,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(18.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.themeColor.withValues(alpha: 0.18),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 34.w,
                  height: 34.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: foreground.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: SvgPicture.asset(
                    AppImages.iconsCard,
                    height: 16.h,
                    width: 16.w,
                    colorFilter: ColorFilter.mode(foreground, BlendMode.srcIn),
                  ),
                ),
                AppText(
                  LocaleKeys.store_current_logo.tr(),
                  fontSize: 9.5.sp,
                  color: foreground.withValues(alpha: 0.75),
                ),
              ],
            ),
            const Spacer(),
            AppText(
              displayName,
              fontSize: 15.sp,
              fontWeight: FontWeight.w700,
              fontFamily: fontFamily,
              color: foreground,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            if (jobTitle.trim().isNotEmpty)
              AppText(
                jobTitle,
                fontSize: 11.sp,
                fontFamily: fontFamily,
                color: foreground.withValues(alpha: 0.8),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            if (company.trim().isNotEmpty)
              AppText(
                company,
                fontSize: 11.sp,
                fontFamily: fontFamily,
                color: foreground.withValues(alpha: 0.8),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
          ],
        ),
      ),
    );
  }
}

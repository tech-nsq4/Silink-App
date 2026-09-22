import 'package:Silink/core/utils/app_images.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_text.dart';

class QrDisplayCard extends StatelessWidget {
  final String name;
  final String jobTitle;
  final String initial;
  final String fullLink;

  const QrDisplayCard({
    super.key,
    required this.name,
    required this.jobTitle,
    required this.initial,
    required this.fullLink,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white.themeColor,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.themeColor.withValues(alpha: 0.05),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: 52.w,
            height: 52.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.mint.themeColor,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: AppText(
              initial,
              fontSize: 17.sp,
              fontWeight: FontWeight.w800,
              color: AppColors.white.themeColor,
            ),
          ),
          8.height,
          AppText(name, fontSize: 16.sp, fontWeight: FontWeight.w800),
          2.height,
          AppText(
            jobTitle,
            fontSize: 12.sp,
            color: AppColors.textSecondaryColor.themeColor,
          ),
          12.height,
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: const Color(0xFF17212B),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: QrImageView(
              data: 'https://$fullLink',
              version: QrVersions.auto,
              size: 180.w,
              backgroundColor: Colors.transparent,
              eyeStyle: const QrEyeStyle(
                eyeShape: QrEyeShape.square,
                color: Color(0xFF17B78F),
              ),
              dataModuleStyle: const QrDataModuleStyle(
                dataModuleShape: QrDataModuleShape.square,
                color: Colors.white,
              ),
            ),
          ),
          12.height,
          Container(
            height: 31.h,
            padding: 6.paddingHorizontal,
            decoration: BoxDecoration(
                color: Color(0xFFf8fafc),
                borderRadius: BorderRadius.circular(12.r)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  AppImages.iconsInternet,
                  height: 14.h,
                  width: 14.w,
                ),
                6.width,
                AppText(
                  fullLink,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.mint.themeColor,
                ),
              ],
            ),
          ),
          6.height,
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: const Color(0xFFF0FDFA),
              borderRadius: BorderRadius.circular(32.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 6.w,
                  height: 6.w,
                  decoration: BoxDecoration(
                      color: AppColors.mint.themeColor, shape: BoxShape.circle),
                ),
                6.width,
                AppText(
                  LocaleKeys.qr_publishedAndActive.tr(),
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.mint.themeColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

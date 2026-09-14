import 'package:Silink/app/router/navigation_services.dart';
import 'package:Silink/app/router/routes.dart';
import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/app_images.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_text.dart';

class StoreBanner extends StatelessWidget {

  const StoreBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => NavigationService.push(Routes.storeScreen),
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFF0F2A3D),
              Color(0xFF0F2A3D),
              Color(0xFF163B52),
            ],
            stops: [0.0, 0.7, 1.0],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          children: [
            Container(
              width: 40.h,
              height: 40.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: const Color(0xFF0D9488).withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(18.r)),
              child: SvgPicture.asset(AppImages.iconsStore),
            ),
            12.width,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: AppText(
                          LocaleKeys.home_store_title.tr(),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0D9488).withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: AppText(
                          LocaleKeys.home_store_badge_new.tr(),
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF46edd5),
                        ),
                      ),
                    ],
                  ),
                  4.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText(
                        LocaleKeys.home_store_subtitle.tr(),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.white.themeColor,
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: Colors.white70,
                        size: 20.sp,
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
}

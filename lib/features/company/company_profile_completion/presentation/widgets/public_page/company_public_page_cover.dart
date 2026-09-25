import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_text.dart';

class CompanyPublicPageCover extends StatelessWidget {
  const CompanyPublicPageCover({super.key, required this.onExit});

  final VoidCallback onExit;

  @override
  Widget build(BuildContext context) {
    final brand = AppColors.companyBrand.themeColor;
    final glow = AppColors.overlayOnDark.themeColor.withValues(alpha: 0.07);
    return SizedBox(
      height: 132.h,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [brand.withValues(alpha: 0.85), brand],
                begin: AlignmentDirectional.topCenter,
                end: AlignmentDirectional.bottomCenter,
              ),
            ),
          ),
          Positioned(
            top: -36,
            left: -24,
            child: Container(
              width: 130.w,
              height: 130.w,
              decoration: BoxDecoration(color: glow, shape: BoxShape.circle),
            ),
          ),
          Positioned(
            bottom: -46,
            right: -30,
            child: Container(
              width: 150.w,
              height: 150.w,
              decoration: BoxDecoration(color: glow, shape: BoxShape.circle),
            ),
          ),
          SafeArea(
            child: Align(
              alignment: AlignmentDirectional.topStart,
              child: Padding(
                padding: EdgeInsetsDirectional.only(top: 10.h, start: 16.w),
                child: InkWell(
                  onTap: onExit,
                  borderRadius: BorderRadius.circular(20.r),
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      color: AppColors.black.themeColor.withValues(alpha: 0.35),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppText(
                          LocaleKeys.publish_exitPreview.tr(),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.overlayOnDark.themeColor,
                        ),
                        4.width,
                        Icon(
                          Icons.close,
                          size: 15.sp,
                          color: AppColors.overlayOnDark.themeColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

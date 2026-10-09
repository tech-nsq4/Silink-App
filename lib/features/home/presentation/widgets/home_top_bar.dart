import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_images.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/silink_brand.dart';

class HomeTopBar extends StatelessWidget {
  const HomeTopBar({super.key, this.onNotifications});

  final VoidCallback? onNotifications;

  @override
  Widget build(BuildContext context) {
    final sideWidth = 70.w;
    return Padding(
      padding: EdgeInsets.fromLTRB(22.w, 10.h, 22.w, 12.h),
      child: Row(
        children: [
          SizedBox(
            width: sideWidth,
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: SilinkBrand(fontSize: 15.sp),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppText(
                  LocaleKeys.homeHub_welcome.tr(),
                  fontSize: 9.sp,
                  color: AppColors.topEyebrow.themeColor,
                ),
                SizedBox(height: 3.h),
                AppText(
                  LocaleKeys.homeHub_workspace.tr(),
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w800,
                ),
              ],
            ),
          ),
          SizedBox(
            width: sideWidth,
            child: Align(
              alignment: AlignmentDirectional.centerEnd,
              child: InkWell(
                onTap: onNotifications,
                customBorder: const CircleBorder(),
                child: Container(
                  width: 36.w,
                  height: 36.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.white.themeColor,
                    shape: BoxShape.circle,
                    border:
                        Border.all(color: AppColors.topIconBorder.themeColor),
                  ),
                  child: SvgPicture.asset(
                    AppImages.iconsNotifications,
                    width: 18.w,
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

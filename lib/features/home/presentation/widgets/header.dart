import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_images.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_text.dart';

class Header extends StatelessWidget {
  final String userName;

  const Header({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              LocaleKeys.home_greeting.tr(),
              fontSize: 12.sp,
              color: AppColors.textSecondaryColor.themeColor,
            ),
            SizedBox(height: 2.h),
            Row(
              children: [
                AppText(
                  userName,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
                SizedBox(width: 6.w),
                SvgPicture.asset(AppImages.iconsHand),
              ],
            ),
          ],
        ),
        InkWell(
          onTap: () {},
          child: Container(
            height: 40.h,
            width: 40.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.white.themeColor,
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.borderColor.themeColor,
              ),
            ),
            child: SvgPicture.asset(AppImages.iconsNotifications),
          ),
        ),
      ],
    );
  }
}

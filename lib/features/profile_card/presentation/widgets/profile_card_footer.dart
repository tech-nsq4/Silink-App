import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/app_images.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'profile_card_gradient_button.dart';

class ProfileCardFooter extends StatelessWidget {
  const ProfileCardFooter({
    super.key,
    required this.onShareData,
    required this.onShareFile,
    required this.isSharingFile,
  });

  final VoidCallback onShareData;
  final VoidCallback onShareFile;
  final bool isSharingFile;

  @override
  Widget build(BuildContext context) {
    final textPrimary = AppColors.textPrimaryColor.themeColor;

    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 24.h),
      child: Column(
        children: [
          ProfileCardGradientButton(
            label: LocaleKeys.publish_share_data.tr(),
            icon: AppImages.iconsSend,
            onTap: onShareData,
          ),
          16.height,
          InkWell(
            onTap: isSharingFile ? null : onShareFile,
            borderRadius: BorderRadius.circular(14.r),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 11.h),
              decoration: BoxDecoration(
                color: AppColors.white.themeColor,
                borderRadius: BorderRadius.circular(14.r),
                border: Border.all(color: AppColors.dividerColor.themeColor),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    AppImages.iconsShare,
                    width: 16.w,
                    height: 16.w,
                    colorFilter: ColorFilter.mode(textPrimary, BlendMode.srcIn),
                  ),
                  8.width,
                  AppText(
                    LocaleKeys.publish_file_sharing.tr(),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: textPrimary,
                  ),
                ],
              ),
            ),
          ),
          28.height,
          AppText(
            LocaleKeys.publish_made_with.tr(),
            fontSize: 10.sp,
            color: AppColors.textSecondaryColor.themeColor,
          ),
          6.height,
          ClipRRect(
            borderRadius: BorderRadius.circular(6.r),
            child: Image.asset(
              AppImages.logoApp,
              height: 24.h,
              width: 68.w,
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_images.dart';
import 'package:Silink/core/widgets/app_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_text.dart';

class PotentialClientsSection extends StatelessWidget {
  final VoidCallback? onViewAll;
  final VoidCallback? onStartCreatingProfile;

  const PotentialClientsSection({
    super.key,
    this.onViewAll,
    this.onStartCreatingProfile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white.themeColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.borderColor.themeColor),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                LocaleKeys.home_potential_clients_title.tr(),
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
              ),
              InkWell(
                onTap: onViewAll ?? () {},
                child: AppText(
                  LocaleKeys.home_view_all.tr(),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.mint.themeColor,
                ),
              ),
            ],
          ),
          Divider(
            height: 24.h,
            color: AppColors.borderColor.themeColor,
            thickness: 1,
          ),
          Container(
            width: 56.w,
            height: 56.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.fieldFill,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: SvgPicture.asset(AppImages.iconsClients),
          ),
          12.height,
          AppText(
            LocaleKeys.home_build_client_list_title.tr(),
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
          ),
          12.height,
          AppText(
            LocaleKeys.home_build_client_list_subtitle.tr(),
            fontSize: 12.sp,
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
          12.height,
          CustomButton(
            title: LocaleKeys.home_start_creating_profile.tr(),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

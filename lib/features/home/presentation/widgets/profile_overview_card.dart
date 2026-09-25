import 'package:Silink/app/router/navigation_services.dart';
import 'package:Silink/app/router/routes.dart';
import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_images.dart';
import 'package:Silink/core/widgets/app_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/image/custom_image.dart';
import 'overview_feature_action.dart';
import 'overview_stat_divider.dart';
import 'overview_stat_item.dart';

class ProfileOverviewCard extends StatelessWidget {
  final String name;
  final String jobTitle;
  final String company;
  final String initials;
  final String? photoUrl;
  final bool isActive;
  final String conversionRate;
  final String potentialClients;
  final String visits;

  const ProfileOverviewCard({
    super.key,
    required this.name,
    required this.jobTitle,
    required this.company,
    required this.initials,
    this.photoUrl,
    required this.isActive,
    required this.conversionRate,
    required this.potentialClients,
    required this.visits,
  });

  bool get _hasPhoto => photoUrl != null && photoUrl!.trim().isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white.themeColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.borderColor.themeColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 56.h,
                height: 56.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  gradient: LinearGradient(
                    colors: [
                      Color(0xff2C9092),
                      Color(0xff2368E2),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: _hasPhoto
                    ? CustomImage(
                        image: photoUrl!,
                        width: 56.h,
                        height: 56.h,
                        radius: 16.r,
                      )
                    : AppText(
                        initials,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.white.themeColor,
                      ),
              ),
              12.width,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      name,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    if (jobTitle.trim().isNotEmpty)
                      AppText(
                        jobTitle.trim(),
                        fontSize: 12.sp,
                        color: AppColors.textSecondaryColor.themeColor,
                      ),
                    if (company.trim().isNotEmpty)
                      AppText(
                        company.trim(),
                        fontSize: 12.sp,
                        color: AppColors.textSecondaryColor.themeColor,
                      ),
                  ],
                ),
              ),
              // Spacer(),
              if (isActive)
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFdcfce7),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: AppText(
                    LocaleKeys.home_active_badge.tr(),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF008236),
                  ),
                ),
            ],
          ),
          16.height,
          Row(
            children: [
              Expanded(
                child: OverviewStatItem(
                    value: visits, labelKey: LocaleKeys.home_stat_visits),
              ),
              const OverviewStatDivider(),
              Expanded(
                child: OverviewStatItem(
                    value: potentialClients,
                    labelKey: LocaleKeys.home_stat_potential_clients),
              ),
              const OverviewStatDivider(),
              Expanded(
                child: OverviewStatItem(
                    value: conversionRate,
                    labelKey: LocaleKeys.home_stat_conversion),
              ),
            ],
          ),
          8.height,
          Divider(
            color: AppColors.borderColor.themeColor,
            thickness: 1,
          ),
          8.height,
          CustomButton(
            onTap: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.description_outlined,
                  size: 18.sp,
                  color: AppColors.white.themeColor,
                ),
                6.width,
                AppText(
                  LocaleKeys.home_edit_profile.tr(),
                  color: AppColors.white.themeColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 14.sp,
                ),
              ],
            ),
          ),
          8.height,
          Divider(
            color: AppColors.borderColor.themeColor,
            thickness: 1,
          ),
          8.height,
          Row(
            children: [
              Expanded(
                  child: Features(
                icon: AppImages.iconsPreview,
                label: LocaleKeys.home_action_preview,
                onTap: () {},
              )),
              const OverviewStatDivider(),
              Expanded(
                  child: Features(
                icon: AppImages.iconsShare,
                label: LocaleKeys.home_action_share,
                onTap: () {},
              )),
              const OverviewStatDivider(),
              Expanded(
                  child: Features(
                icon: AppImages.iconsStats,
                label: LocaleKeys.home_action_stats,
                onTap: () => NavigationService.push(Routes.statisticsScreen),
              )),
            ],
          ),
        ],
      ),
    );
  }
}

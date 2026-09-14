import 'package:Silink/core/extensions/extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_text.dart';
import '../../models/activity_item.dart';

class RecentActivitySection extends StatelessWidget {
  final List<ActivityItem> activities;
  final VoidCallback? onViewAll;

  const RecentActivitySection({
    super.key,
    required this.activities,
    this.onViewAll,
  });

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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                LocaleKeys.home_recent_activities_title.tr(),
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
          12.height,
          for (int i = 0; i < activities.length; i++) ...[
            _ActivityTile(item: activities[i]),
            if (i != activities.length - 1)
              Divider(
                height: 24.h,
                color: AppColors.borderColor.themeColor,
                thickness: 1,
              ),
          ],
        ],
      ),
    );
  }
}

class _ActivityTile extends StatelessWidget {
  final ActivityItem item;

  const _ActivityTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 36.h,
          height: 36.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: item.iconBackground,
            shape: BoxShape.circle,
          ),
          child: SvgPicture.asset(
            item.icon,
            colorFilter: ColorFilter.mode(
              item.iconColor,
              BlendMode.srcIn,
            ),
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                item.titleKey.tr(namedArgs: {'name': item.subjectName}),
                fontSize: 13.sp,
              ),
              4.height,
              AppText(
                LocaleKeys.home_hours_ago
                    .tr(namedArgs: {'hours': item.hoursAgo.toString()}),
                fontSize: 12.sp,
                color: AppColors.textSecondaryColor.themeColor,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

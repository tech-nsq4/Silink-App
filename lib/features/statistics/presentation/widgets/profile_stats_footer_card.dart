import 'package:Silink/core/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/app_text.dart';

class ProfileStatBox {
  final String value;
  final String label;

  const ProfileStatBox({required this.value, required this.label});
}

class ProfileStatsFooterCard extends StatelessWidget {
  final String title;
  final String profileName;
  final List<ProfileStatBox> stats;

  const ProfileStatsFooterCard({
    super.key,
    required this.title,
    required this.profileName,
    required this.stats,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: 16.w.paddingAll,
      decoration: BoxDecoration(
        color: AppColors.white.themeColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.borderColor.themeColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            title,
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
          ),
          Divider(
            height: 24.h,
          ),
          AppText(
            profileName,
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
          ),
          14.height,
          Row(
            children: [
              for (int i = 0; i < stats.length; i++) ...[
                Expanded(child: StatBox(stat: stats[i])),
                if (i != stats.length - 1) 8.width,
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class StatBox extends StatelessWidget {
  final ProfileStatBox stat;

  const StatBox({super.key, required this.stat});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 6.w),
      decoration: BoxDecoration(
        color: AppColors.statsCardBg.themeColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          AppText(
            stat.value,
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
          ),
          4.height,
          AppText(
            stat.label,
            fontSize: 10.sp,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

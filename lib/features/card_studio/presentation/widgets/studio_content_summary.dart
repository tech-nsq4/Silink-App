import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_text.dart';

class StudioContentSummary extends StatelessWidget {
  const StudioContentSummary({
    super.key,
    required this.count,
    required this.onAdd,
  });

  final int count;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    final accent = AppColors.accentTeal.themeColor;
    return Container(
      margin: EdgeInsets.only(bottom: 18.h),
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        color: AppColors.studioSummary.themeColor,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.studioSummaryBorder.themeColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                '$count',
                fontSize: 23.sp,
                fontWeight: FontWeight.w800,
                color: AppColors.studioSummaryCount.themeColor,
              ),
              SizedBox(height: 4.h),
              AppText(
                LocaleKeys.cardStudio_itemsCount.tr(),
                fontSize: 9.sp,
                color: AppColors.studioSummaryLabel.themeColor,
              ),
            ],
          ),
          GestureDetector(
            onTap: onAdd,
            child: Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: AppColors.white.themeColor,
                borderRadius: BorderRadius.circular(9.r),
                border: Border.all(
                    color: AppColors.studioSummaryButtonBorder.themeColor),
              ),
              child: Row(
                children: [
                  Icon(Icons.add_rounded, size: 16.sp, color: accent),
                  6.width,
                  AppText(
                    LocaleKeys.cardStudio_addItem.tr(),
                    fontSize: 11.sp,
                    color: accent,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

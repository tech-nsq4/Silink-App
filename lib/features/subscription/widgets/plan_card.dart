import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/extensions/extensions.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/app_text.dart';
import 'plan_status_chip.dart';

class PlanCard extends StatelessWidget {
  const PlanCard({
    super.key,
    required this.title,
    required this.features,
    this.label,
    this.badge,
    this.badgeColor,
    this.onBadgeTap,
    this.price,
    this.priceColor,
    this.period,
    this.isCurrent = false,
    this.accentColor,
    this.backgroundColor,
  });

  final String title;
  final List<String> features;
  final String? label;
  final String? badge;
  final Color? badgeColor;
  final VoidCallback? onBadgeTap;
  final String? price;
  final Color? priceColor;
  final String? period;
  final bool isCurrent;
  final Color? accentColor;

  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final accent = accentColor ?? AppColors.borderColor.themeColor;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.white.themeColor,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(
          color: isCurrent ? accent : AppColors.textPrimaryColor.themeColor,
          width: 0.5.w,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (label != null) ...[
                      AppText(
                        label!,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textSecondaryColor.themeColor,
                      ),
                      3.height,
                    ],
                    // plan free
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText(
                          title,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                        ),
                        if (badge != null) _badge(accent),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (price != null) ...[
            6.height,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  'تجديد: لا ينتهي',
                  fontSize: 12.sp,
                  color: AppColors.textSecondaryColor.themeColor,
                ),
                Spacer(),
                AppText(
                  price!,
                  fontSize: 12.sp,
                  color: AppColors.textSecondaryColor.themeColor,
                ),
                if (period != null) ...[
                  4.width,
                  Padding(
                    padding: EdgeInsetsDirectional.only(bottom: 1.5.h),
                    child: AppText(
                      period!,
                      fontSize: 12.sp,
                      color: AppColors.textSecondaryColor.themeColor,
                    ),
                  ),
                ],
              ],
            ),
          ],
          12.height,
          ...features.map(_featureRow),
        ],
      ),
    );
  }

  /// Status chip for informational badges, filled pill when it is an action.
  Widget _badge(Color accent) {
    final tone = badgeColor ?? accent;

    if (onBadgeTap == null) {
      return PlanStatusChip(label: badge!, color: tone);
    }

    return InkWell(
      onTap: onBadgeTap,
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: tone,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: AppText(
          badge!,
          fontSize: 12.sp,
          fontWeight: FontWeight.w700,
          color: AppColors.white.themeColor,
        ),
      ),
    );
  }

  Widget _featureRow(String feature) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.only(top: 2.h),
            child: Icon(
              Icons.check,
              size: 16.sp,
              color: AppColors.textSecondaryColor.themeColor,
            ),
          ),
          8.width,
          Expanded(
            child: AppText(
              feature,
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }
}

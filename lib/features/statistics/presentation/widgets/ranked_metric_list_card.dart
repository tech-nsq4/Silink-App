import 'package:Silink/core/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/app_text.dart';
import '../../models/ranked_metric.dart';

class RankedMetricListCard extends StatelessWidget {
  final String title;
  final List<RankedMetric> items;

  const RankedMetricListCard({
    super.key,
    required this.title,
    required this.items,
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
          8.height,
          Divider(
            height: 1,
          ),
          8.height,
          for (int i = 0; i < items.length; i++) ...[
            _RankedMetricTile(item: items[i]),
            if (i != items.length - 1) Divider(),
          ],
        ],
      ),
    );
  }
}

class _RankedMetricTile extends StatelessWidget {
  final RankedMetric item;

  const _RankedMetricTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppText(
              item.value,
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimaryColor.themeColor,
            ),
            AppText(
              item.label,
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimaryColor.themeColor,
            ),
          ],
        ),
        4.height,
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6.r),
                child: Container(
                  height: 6.h,
                  color: AppColors.statsProgressBg.themeColor,
                  child: Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: FractionallySizedBox(
                      widthFactor: item.percent.clamp(0.0, 1.0),
                      child: Container(
                        height: 6.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.r),
                          gradient: LinearGradient(
                            colors: [
                              AppColors.statsGradientStart.themeColor,
                              AppColors.statsGradientEnd.themeColor,
                            ],
                            begin: Alignment.centerRight,
                            end: Alignment.centerLeft,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            8.width,
            AppText(
              '${(item.percent * 100).round()}%',
              fontSize: 12.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.statsAccentGreen.themeColor,
            ),
          ],
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/app_text.dart';

class HomeImpactStats extends StatelessWidget {
  const HomeImpactStats({super.key, required this.stats});

  final List<(String value, String label)> stats;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 18.h),
      decoration: BoxDecoration(
        color: AppColors.white.themeColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.studioPanelBorder.themeColor),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            for (final (index, stat) in stats.indexed) ...[
              if (index > 0)
                VerticalDivider(
                  width: 1,
                  thickness: 1,
                  indent: 4.h,
                  endIndent: 4.h,
                  color: AppColors.studioStepLine.themeColor,
                ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppText(
                      stat.$1,
                      fontSize: 19.sp,
                      fontWeight: FontWeight.w800,
                    ),
                    SizedBox(height: 6.h),
                    AppText(
                      stat.$2,
                      fontSize: 8.5.sp,
                      textAlign: TextAlign.center,
                      color: AppColors.textSecondaryColor.themeColor,
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

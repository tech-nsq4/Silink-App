import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/widgets/app_text.dart';

class HubPresenceCard extends StatelessWidget {
  const HubPresenceCard({super.key, required this.stats});

  final List<(int value, String label)> stats;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 18.h),
      decoration: BoxDecoration(
        color: AppColors.white.themeColor,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: AppColors.studioPanelBorder.themeColor),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            for (final (index, stat) in stats.indexed) ...[
              if (index > 0)
                VerticalDivider(
                  width: 1,
                  color: AppColors.studioStepLine.themeColor,
                ),
              Expanded(
                child: Column(
                  children: [
                    AppText(
                      '${stat.$1}',
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w800,
                      color: AppColors.studioCardStart.themeColor,
                    ),
                    SizedBox(height: 6.h),
                    AppText(
                      stat.$2,
                      fontSize: 8.5.sp,
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

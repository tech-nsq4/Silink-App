import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/extensions/extensions.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/widgets/app_text.dart';

class WorkspaceNextHint extends StatelessWidget {
  const WorkspaceNextHint({super.key, required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final accent = AppColors.accentTeal.themeColor;
    return Container(
      margin: EdgeInsets.only(top: 6.h),
      padding: EdgeInsets.only(top: 20.h),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: AppColors.studioStepLine.themeColor),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.groups_outlined, size: 22.sp, color: accent),
          12.width,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  title,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w800,
                  color: accent,
                ),
                SizedBox(height: 6.h),
                AppText(
                  body,
                  fontSize: 9.sp,
                  height: 1.6,
                  color: AppColors.textSecondaryColor.themeColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

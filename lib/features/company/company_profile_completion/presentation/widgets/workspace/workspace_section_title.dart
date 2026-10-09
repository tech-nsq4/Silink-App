import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/widgets/app_text.dart';

class WorkspaceSectionTitle extends StatelessWidget {
  const WorkspaceSectionTitle({
    super.key,
    required this.title,
    this.subtitle,
  });

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.h, bottom: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(title, fontSize: 15.sp, fontWeight: FontWeight.w800),
          if (subtitle != null) ...[
            SizedBox(height: 6.h),
            AppText(
              subtitle!,
              fontSize: 9.sp,
              color: AppColors.textSecondaryColor.themeColor,
            ),
          ],
        ],
      ),
    );
  }
}

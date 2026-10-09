import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/app_text.dart';

class StudioSectionTitle extends StatelessWidget {
  const StudioSectionTitle({super.key, required this.title, this.detail});

  final String title;
  final String? detail;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 25.h, bottom: 13.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(title, fontSize: 15.sp, fontWeight: FontWeight.w800),
          if (detail != null) ...[
            SizedBox(height: 5.h),
            AppText(
              detail!,
              fontSize: 9.sp,
              color: AppColors.studioSectionDetail.themeColor,
            ),
          ],
        ],
      ),
    );
  }
}

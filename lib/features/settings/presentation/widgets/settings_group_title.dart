import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/app_text.dart';

class SettingsGroupTitle extends StatelessWidget {
  const SettingsGroupTitle(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 4.w, bottom: 8.h),
      child: AppText(
        title,
        fontSize: 12.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.textSecondaryColor.themeColor,
      ),
    );
  }
}

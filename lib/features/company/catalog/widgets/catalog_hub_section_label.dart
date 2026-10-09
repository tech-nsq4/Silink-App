import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/app_text.dart';

class CatalogHubSectionLabel extends StatelessWidget {
  const CatalogHubSectionLabel({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 6.h, bottom: 8.h),
      child: AppText(
        text,
        fontSize: 9.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.textSecondaryColor.themeColor,
      ),
    );
  }
}

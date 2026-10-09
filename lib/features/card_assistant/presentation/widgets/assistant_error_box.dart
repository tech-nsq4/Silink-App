import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/app_text.dart';

class AssistantErrorBox extends StatelessWidget {
  const AssistantErrorBox({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 14.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.assistantError.themeColor,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: AppColors.assistantErrorBorder.themeColor),
      ),
      child: AppText(
        message,
        fontSize: 10.sp,
        height: 1.9,
        color: AppColors.assistantErrorText.themeColor,
      ),
    );
  }
}

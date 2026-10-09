import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/app_text.dart';

class AuthErrorBox extends StatelessWidget {
  const AuthErrorBox({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(11.w),
      decoration: BoxDecoration(
        color: AppColors.errorSoftBackground.themeColor,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: AppColors.errorSoftBorder.themeColor),
      ),
      child: AppText(
        message,
        fontSize: 10.sp,
        height: 1.7,
        color: AppColors.errorSoftText.themeColor,
      ),
    );
  }
}

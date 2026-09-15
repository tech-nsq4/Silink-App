import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthLogoBadge extends StatelessWidget {
  const AuthLogoBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      width: 110.w,
      padding: EdgeInsets.all(6.w),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.darkSlate.themeColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Image.asset(AppImages.logoApp),
    );
  }
}

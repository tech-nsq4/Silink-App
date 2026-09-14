import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/app_text.dart';

class StatsAppBar extends StatelessWidget {
  final String title;
  final VoidCallback? onBack;
  final Widget? child;

  const StatsAppBar({
    super.key,
    required this.title,
    this.onBack,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.h,
      padding: EdgeInsets.symmetric(horizontal: 19.w),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.borderColor.themeColor,
          ),
        ),
      ),
      child: Stack(
        children: [
         
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: Transform.translate(
              offset: Offset(0, 10.h),
              child: child ,
            ),
          ),
          Positioned.fill(
            child: Transform.translate(
              offset: Offset(0, 10.h),
              child: Center(
                child: AppText(
                  title,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: Transform.translate(
              offset: Offset(0, 10.h),
              child: Center(
                child: InkWell(
                  onTap: onBack ?? () => Navigator.of(context).maybePop(),
                  borderRadius: BorderRadius.circular(20.r),
                  child: Icon(
                    Icons.chevron_left,
                    size: 24.sp,
                    color: AppColors.textPrimaryColor.themeColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

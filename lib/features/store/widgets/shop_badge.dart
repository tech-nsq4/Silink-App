import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/app_text.dart';

class ShopBadge extends StatelessWidget {
  const ShopBadge({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: AppColors.white.themeColor,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.light.withValues(alpha: 0.06),
            blurRadius: 8,
          ),
        ],
      ),
      child: AppText(label, fontSize: 8.sp, fontWeight: FontWeight.w700),
    );
  }
}

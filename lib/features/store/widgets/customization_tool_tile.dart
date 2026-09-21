import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/extensions/extensions.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/app_text.dart';

class CustomizationToolTile extends StatelessWidget {
  const CustomizationToolTile({
    super.key,
    required this.icon,
    required this.title,
    this.value,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String? value;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final isRtl = Directionality.of(context) == ui.TextDirection.rtl;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14.r),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Row(
          children: [
            Container(
              width: 34.w,
              height: 34.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.mintSoft.themeColor,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(
                icon,
                size: 17.sp,
                color: AppColors.mint.themeColor,
              ),
            ),
            10.width,
            Expanded(
              child: AppText(
                title,
                fontSize: 12.5.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (value != null)
              AppText(
                value!,
                fontSize: 12.sp,
                color: AppColors.textSecondaryColor.themeColor,
              ),
            6.width,
            Icon(
              isRtl ? Icons.chevron_left : Icons.chevron_right,
              size: 18.sp,
              color: AppColors.textSecondaryColor.themeColor,
            ),
          ],
        ),
      ),
    );
  }
}

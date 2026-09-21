import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/widgets/app_text.dart';

class CompanyStatTile extends StatelessWidget {
  const CompanyStatTile({
    super.key,
    required this.value,
    required this.label,
    required this.icon,
  });

  final String value;
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14.h),
      decoration: BoxDecoration(
        color: AppColors.cardColor.themeColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.borderColor.themeColor),
      ),
      child: Column(
        children: [
          Icon(icon, size: 20.sp, color: AppColors.mint.themeColor),
          6.height,
          AppText(value, fontSize: 17.sp, fontWeight: FontWeight.w700),
          2.height,
          AppText(
            label,
            fontSize: 11.5.sp,
            color: AppColors.textSecondaryColor.themeColor,
          ),
        ],
      ),
    );
  }
}

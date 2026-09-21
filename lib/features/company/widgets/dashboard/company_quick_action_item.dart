import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/widgets/app_text.dart';

class CompanyQuickActionItem extends StatelessWidget {
  const CompanyQuickActionItem({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        decoration: BoxDecoration(
          color: AppColors.cardColor.themeColor,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColors.borderColor.themeColor),
        ),
        child: Column(
          children: [
            Icon(icon, size: 20.sp, color: color),
            AppText(label, fontSize: 11.sp, fontWeight: FontWeight.w600),
          ],
        ),
      ),
    );
  }
}

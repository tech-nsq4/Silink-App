import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/app_text.dart';

class CompanyBusinessTypeCard extends StatelessWidget {
  const CompanyBusinessTypeCard({
    super.key,
    required this.title,
    required this.selected,
    required this.onTap,
  });

  final String title;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: selected ? AppColors.mintSoft.themeColor : AppColors.cardColor.themeColor,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: selected ? AppColors.mint.themeColor : AppColors.borderColor.themeColor,
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: AppText(
                title,
                fontSize: 14.5.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            Container(
              width: 22.w,
              height: 22.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selected ? AppColors.mint.themeColor : Colors.transparent,
                border: Border.all(
                  color: selected ? AppColors.mint.themeColor : AppColors.borderColor.themeColor,
                  width: 1.5,
                ),
              ),
              child: selected
                  ? Icon(Icons.check_rounded, size: 14.sp, color: Colors.white)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmployeeInvitationLinkBox extends StatelessWidget {
  const EmployeeInvitationLinkBox({
    super.key,
    required this.link,
    required this.onTap,
  });

  final String link;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 11.h),
        decoration: BoxDecoration(
          color: AppColors.mintSoft.themeColor,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: AppColors.brandGreen.themeColor.withValues(alpha: 0.3),
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.link_rounded,
              size: 18.sp,
              color: AppColors.brandGreen.themeColor,
            ),
            8.width,
            Expanded(
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: AppText(
                  link,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  color: AppColors.primaryColor.themeColor,
                ),
              ),
            ),
            8.width,
            Icon(
              Icons.copy_rounded,
              size: 16.sp,
              color: AppColors.textSecondaryColor.themeColor,
            ),
          ],
        ),
      ),
    );
  }
}

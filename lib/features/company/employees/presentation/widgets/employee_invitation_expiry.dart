import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmployeeInvitationExpiry extends StatelessWidget {
  const EmployeeInvitationExpiry({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.infoCardBackground.themeColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.infoCardBorder.themeColor),
      ),
      child: Row(
        children: [
          Icon(
            Icons.schedule_rounded,
            size: 18.sp,
            color: AppColors.infoCardIcon.themeColor,
          ),
          8.width,
          Expanded(
            child: AppText(
              text,
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.infoCardText.themeColor,
            ),
          ),
        ],
      ),
    );
  }
}

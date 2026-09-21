import 'package:Silink/core/utils/app_images.dart';
import 'package:Silink/features/profile_completion/data/models/profile_completion_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/app_text.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    required this.fullName,
    required this.jobTitle,
    required this.company,
    required this.location,
  });

  final String fullName;
  final String jobTitle;
  final String company;
  final String location;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 88.w,
          height: 88.w,
          decoration: BoxDecoration(
            color: AppColors.mint.themeColor,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 4),
          ),
          alignment: Alignment.center,
          child: AppText(
            fullName.initial,
            fontSize: 30.sp,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
        8.height,
        AppText(
          fullName,
          fontSize: 20.sp,
          fontWeight: FontWeight.w800,
        ),
        4.height,
        if (jobTitle.trim().isNotEmpty)
          AppText(
            jobTitle,
            fontSize: 13.sp,
          ),
        if (company.trim().isNotEmpty) ...[
          4.height,
          AppText(
            company,
            fontSize: 12.sp,
            color: AppColors.textSecondaryColor.themeColor,
          ),
        ],
        if (location.trim().isNotEmpty) ...[
          10.height,
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: AppColors.black.themeColor.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(AppImages.iconsMap, height: 11.h),
                6.width,
                AppText(location, fontSize: 11.5.sp),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:Silink/features/profile_completion/data/models/profile_completion_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfilePreviewCard extends StatelessWidget {
  const ProfilePreviewCard({super.key, required this.data});

  final ProfileCompletionData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white.themeColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Container(
            height: 50.h,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF17B78F), AppColors.mint.themeColor],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(0, -25.h),
            child: Column(
              children: [
                Container(
                  width: 48.w,
                  height: 48.w,
                  decoration: BoxDecoration(
                    color: AppColors.mint.themeColor,
                    borderRadius: BorderRadius.circular(14.r),
                    border:
                        Border.all(color: AppColors.white.themeColor, width: 3),
                  ),
                  alignment: Alignment.center,
                  child: AppText(
                    data.fullName.initial,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.white.themeColor,
                  ),
                ),
                6.height,
                AppText(
                  data.fullName,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                ),
                if (data.jobTitle.trim().isNotEmpty)
                  AppText(
                    data.jobTitle,
                    fontSize: 12.sp,
                  ),
                if (data.company.trim().isNotEmpty)
                  AppText(
                    data.company,
                    fontSize: 12.sp,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/app_colors.dart';
import '../../utils/locale_keys.dart';
import '../app_text.dart';

class PublicProfileMeeting extends StatelessWidget {
  const PublicProfileMeeting({
    super.key,
    required this.onTap,
    this.buttonRadius = 12,
  });

  final VoidCallback onTap;
  final double buttonRadius;

  @override
  Widget build(BuildContext context) {
    final buttonColor = AppColors.profileMeetingButtonText.themeColor;
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 26.h, bottom: 30.h),
      padding: EdgeInsets.all(25.w),
      decoration: BoxDecoration(
        color: AppColors.profileMeeting.themeColor,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.profileMeetingBorder.themeColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            LocaleKeys.publicProfile_meetingEyebrow.tr(),
            fontSize: 8.sp,
            color: AppColors.profileMeetingEyebrow.themeColor,
          ),
          SizedBox(height: 13.h),
          AppText(
            LocaleKeys.publicProfile_meetingTitle.tr(),
            fontSize: 27.sp,
            fontWeight: FontWeight.w800,
            height: 1.35,
            letterSpacing: -0.6,
            color: AppColors.profileMeetingTitle.themeColor,
          ),
          SizedBox(height: 13.h),
          AppText(
            LocaleKeys.publicProfile_meetingBody.tr(),
            fontSize: 10.sp,
            height: 1.8,
            color: AppColors.profileMeetingBody.themeColor,
          ),
          SizedBox(height: 20.h),
          GestureDetector(
            onTap: onTap,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 13.h),
              decoration: BoxDecoration(
                color: AppColors.white.themeColor,
                borderRadius: BorderRadius.circular(buttonRadius.r),
                border: Border.all(
                    color: AppColors.profileMeetingButtonBorder.themeColor),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText(
                    LocaleKeys.publicProfile_meetingCta.tr(),
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w700,
                    color: buttonColor,
                  ),
                  Icon(Icons.arrow_forward_rounded,
                      size: 16.sp, color: buttonColor),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

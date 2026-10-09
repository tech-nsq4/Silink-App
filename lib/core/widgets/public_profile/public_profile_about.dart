import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../extensions/extensions.dart';
import '../../utils/app_colors.dart';
import '../../utils/locale_keys.dart';
import '../app_text.dart';
import 'public_profile_data.dart';
import 'public_profile_section_head.dart';

class PublicProfileAbout extends StatelessWidget {
  const PublicProfileAbout({super.key, required this.data});

  final PublicProfileData data;

  @override
  Widget build(BuildContext context) {
    final company = data.company.trim();
    return Padding(
      padding: EdgeInsets.only(bottom: 35.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PublicProfileSectionHead(
            eyebrow: LocaleKeys.publicProfile_aboutEyebrow.tr(),
            title: LocaleKeys.publicProfile_aboutTitle.tr(),
          ),
          AppText(
            data.bio,
            fontSize: 12.sp,
            height: 2.1,
            color: AppColors.profileBody.themeColor,
          ),
          if (company.isNotEmpty)
            Container(
              margin: EdgeInsets.only(top: 20.h),
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: AppColors.profileAffiliation.themeColor,
                borderRadius: BorderRadiusDirectional.horizontal(
                    end: Radius.circular(7.r)),
                border: BorderDirectional(
                  start: BorderSide(color: data.accent, width: 2),
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.work_outline_rounded,
                      size: 16.sp,
                      color: AppColors.profileAffiliationIcon.themeColor),
                  11.width,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        LocaleKeys.publicProfile_worksWith.tr(),
                        fontSize: 8.sp,
                        color: AppColors.profileAffiliationLabel.themeColor,
                      ),
                      SizedBox(height: 6.h),
                      AppText(
                        company,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.profileAffiliationName.themeColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

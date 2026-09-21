import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_text.dart';
import '../company_field.dart';

class CompanyProfileCompletionCard extends StatelessWidget {
  const CompanyProfileCompletionCard({super.key, this.progress = 0.65});

  final double progress;

  @override
  Widget build(BuildContext context) {
    return CompanySectionCard(
      title: LocaleKeys.company_complete_profile.tr(),
      trailing: AppText(
        '${(progress * 100).toInt()}%',
        fontSize: 13.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.mint.themeColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6.h,
              backgroundColor: AppColors.mintSoft.themeColor,
              valueColor: AlwaysStoppedAnimation<Color>(
                AppColors.mint.themeColor,
              ),
            ),
          ),
          10.height,
          AppText(
            LocaleKeys.company_complete_hint.tr(),
            fontSize: 12.sp,
            color: AppColors.textSecondaryColor.themeColor,
          ),
        ],
      ),
    );
  }
}

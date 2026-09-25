import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/extensions/extensions.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/locale_keys.dart';
import '../../../core/widgets/app_text.dart';

class HowToShareInfoBox extends StatelessWidget {
  const HowToShareInfoBox({super.key});

  static const List<String> _steps = [
    LocaleKeys.qr_howToShareStepCamera,
    LocaleKeys.qr_howToShareStepLink,
    LocaleKeys.qr_howToShareStepBrowser,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: AppColors.infoCardBackground.themeColor,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.infoCardBorder.themeColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            LocaleKeys.qr_howToShareTitle.tr(),
            fontSize: 13.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.infoCardText.themeColor,
          ),
          12.height,
          ..._steps.map(
            (step) => Padding(
              padding: EdgeInsets.only(bottom: 6.h, right: 16.w),
              child: AppText(
                step.tr(),
                fontSize: 11.sp,
                color: AppColors.infoCardText.themeColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

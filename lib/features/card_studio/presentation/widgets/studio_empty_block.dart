import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_text.dart';

class StudioEmptyBlock extends StatelessWidget {
  const StudioEmptyBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 30.h),
      child: Column(
        children: [
          Icon(Icons.inventory_2_outlined,
              size: 32.sp, color: AppColors.studioEmptyIcon.themeColor),
          SizedBox(height: 15.h),
          AppText(
            LocaleKeys.cardStudio_emptyTitle.tr(),
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            textAlign: TextAlign.center,
            color: AppColors.studioEmptyTitle.themeColor,
          ),
          SizedBox(height: 7.h),
          AppText(
            LocaleKeys.cardStudio_emptyBody.tr(),
            fontSize: 11.sp,
            height: 1.8,
            textAlign: TextAlign.center,
            color: AppColors.studioEmptyBody.themeColor,
          ),
        ],
      ),
    );
  }
}

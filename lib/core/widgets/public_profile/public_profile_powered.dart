import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/app_colors.dart';
import '../../utils/locale_keys.dart';
import '../app_text.dart';
import '../silink_brand.dart';

class PublicProfilePowered extends StatelessWidget {
  const PublicProfilePowered({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 5.h, bottom: 10.h),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: AppColors.profilePoweredLine.themeColor),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText(
            LocaleKeys.publicProfile_poweredBy.tr(),
            fontSize: 7.sp,
            color: AppColors.profilePoweredText.themeColor,
          ),
          SilinkBrand(
            fontSize: 17.sp,
            color: AppColors.profilePoweredBrand.themeColor,
          ),
        ],
      ),
    );
  }
}

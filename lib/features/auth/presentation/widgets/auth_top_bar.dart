import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/silink_brand.dart';

class AuthTopBar extends StatelessWidget {
  const AuthTopBar({super.key, this.tagline});

  final String? tagline;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(
          24.w, 27.h, 24.w, tagline == null ? 13.h : 20.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SilinkBrand(fontSize: 26.sp),
          AppText(
            tagline ?? LocaleKeys.brand_motto.tr(),
            fontSize: 8.sp,
            color: AppColors.subtleText.themeColor,
          ),
        ],
      ),
    );
  }
}

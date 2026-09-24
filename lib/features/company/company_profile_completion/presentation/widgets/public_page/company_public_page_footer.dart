import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/app_images.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_text.dart';

class CompanyPublicPageFooter extends StatelessWidget {
  const CompanyPublicPageFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppText(
          LocaleKeys.company_powered_by.tr(),
          fontSize: 10.sp,
          color: AppColors.textSecondaryColor.themeColor,
          textAlign: TextAlign.center,
        ),
        8.height,
        Container(
          height: 24.h,
          width: 68.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            image: const DecorationImage(
              image: AssetImage(AppImages.logoApp),
              fit: BoxFit.fill,
            ),
          ),
        ),
      ],
    );
  }
}

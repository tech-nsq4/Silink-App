import 'package:easy_localization/easy_localization.dart';
import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OtpIntro extends StatelessWidget {
  const OtpIntro({super.key, required this.destination});

  final String destination;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 72.w,
          height: 72.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.mint.themeColor.withValues(alpha: 0.12),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.gpp_good_outlined,
            size: 34.sp,
            color: AppColors.mint.themeColor,
          ),
        ),
        20.height,
        AppText(
          LocaleKeys.otp_heading.tr(),
          fontSize: 20.sp,
          fontWeight: FontWeight.w800,
        ),
        10.height,
        AppText(
          LocaleKeys.otp_subtitle.tr(),
          fontSize: 13.sp,
          color: AppColors.textSecondaryColor.themeColor,
          fontWeight: FontWeight.w500,
          textAlign: TextAlign.center,
        ),
        4.height,
        AppText(
          destination,
          fontSize: 15.sp,
          fontWeight: FontWeight.w800,
        ),
      ],
    );
  }
}

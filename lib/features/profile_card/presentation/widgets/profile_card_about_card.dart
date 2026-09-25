import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileCardAboutCard extends StatelessWidget {
  const ProfileCardAboutCard({
    super.key,
    required this.bio,
    required this.fontFamily,
  });

  final String bio;
  final String? fontFamily;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white.themeColor,
        borderRadius: BorderRadius.circular(18.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.themeColor.withValues(alpha: 0.06),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            LocaleKeys.publish_aboutMe.tr(),
            fontSize: 11.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.textSecondaryColor.themeColor,
            fontFamily: fontFamily,
          ),
          8.height,
          AppText(
            bio.trim(),
            fontSize: 14.sp,
            fontFamily: fontFamily,
          ),
        ],
      ),
    );
  }
}

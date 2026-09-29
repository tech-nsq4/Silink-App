import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/extensions/extensions.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_images.dart';
import '../../../core/utils/locale_keys.dart';
import '../../../core/widgets/app_text.dart';

class AccountLanguageTile extends StatelessWidget {
  const AccountLanguageTile({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white.themeColor,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: AppColors.borderColor.themeColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18.r),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 13.h),
          child: Row(
            children: [
              Container(
                width: 36.w,
                height: 36.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.fieldFill,
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  AppImages.iconsInternet,
                  height: 21.h,
                  colorFilter: ColorFilter.mode(
                    AppColors.textSecondaryColor.themeColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              12.width,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      LocaleKeys.account_language.tr(),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    4.height,
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: AppText(
                            'العربية · English · ',
                            fontSize: 12.sp,
                            color: AppColors.textSecondaryColor.themeColor,
                          ),
                        ),
                        AppText(
                          LocaleKeys.account_soon.tr(),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.hintColor.themeColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              8.width,
              Container(
                padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.fieldFill,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: AppText(
                  'AR',
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

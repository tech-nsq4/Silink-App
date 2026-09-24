import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/app_images.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_button.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CompanyPublicPageCard extends StatelessWidget {
  const CompanyPublicPageCard({
    super.key,
    this.catalogLabel,
    required this.isPublished,
    required this.onPrimary,
    required this.onSecondary,
  });

  final String? catalogLabel;
  final bool isPublished;
  final VoidCallback onPrimary;
  final VoidCallback onSecondary;

  @override
  Widget build(BuildContext context) {
    final primaryTitle = isPublished
        ? LocaleKeys.company_view_page.tr()
        : LocaleKeys.company_publish_page.tr();
    final secondaryTitle = isPublished
        ? LocaleKeys.company_qr.tr()
        : '${LocaleKeys.company_setup_catalog.tr()} ${catalogLabel ?? LocaleKeys.company_catalog.tr()}';

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.cardColor.themeColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.borderColor.themeColor),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.blue.themeColor.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(AppImages.iconsInternet),
              ),
              12.width,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      LocaleKeys.company_public_page.tr(),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    2.height,
                    AppText(
                      LocaleKeys.company_public_page_hint.tr(),
                      fontSize: 12.sp,
                      color: AppColors.textSecondaryColor.themeColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  onTap: onPrimary,
                  title: primaryTitle,
                  color: AppColors.blue.themeColor,
                  height: 44,
                  radius: 16,
                  fontSize: 12.5,
                ),
              ),
              8.width,
              Expanded(
                child: CustomButton(
                  onTap: onSecondary,
                  title: secondaryTitle,
                  isOutlined: true,
                  borderColor: AppColors.borderColor.themeColor,
                  textColor: AppColors.textPrimaryColor.themeColor,
                  height: 44,
                  radius: 16,
                  fontSize: 12.5,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

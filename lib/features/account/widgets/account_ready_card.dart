import 'package:Silink/app/router/navigation_services.dart';
import 'package:Silink/app/router/routes.dart';
import 'package:Silink/core/utils/app_images.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/extensions/extensions.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/app_text.dart';

class AccountReadyCard extends StatelessWidget {
  const AccountReadyCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.actionLabel,
    this.onAddTap,
  });

  final String title;
  final String subtitle;
  final String actionLabel;
  final VoidCallback? onAddTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => NavigationService.push(Routes.companyDashboard),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: AppColors.white.themeColor,
          borderRadius: BorderRadius.circular(18.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              height: 40.h,
              width: 40.w,
              alignment: Alignment.center,
              padding: 10.paddingAll,
              decoration: BoxDecoration(
                color: AppColors.blue.themeColor.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(AppImages.iconsCompany),
            ),
            12.width,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    LocaleKeys.account_login_company.tr(),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                  ),
                  4.height,
                  AppText(
                    LocaleKeys.account_managing_Company.tr(),
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                    height: 1.5,
                  ),
                ],
              ),
            ),
            
            Icon(
              Icons.arrow_forward_ios,
              size: 12.w,
              color: AppColors.hintColor.themeColor,
            ),
          ],
        ),
      ),
    );
  }
}

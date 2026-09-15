import 'package:Silink/app/router/navigation_services.dart';
import 'package:Silink/app/router/routes.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/app_images.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widgets/usage_type_card.dart';

class UsageTypeScreen extends StatefulWidget {
  const UsageTypeScreen({super.key});

  @override
  State<UsageTypeScreen> createState() => _UsageTypeScreenState();
}

class _UsageTypeScreenState extends State<UsageTypeScreen> {
  int? _selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 19.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 40.h,
                alignment: Alignment.centerRight,
                padding: EdgeInsets.all(6.r),
                decoration: BoxDecoration(
                  color: const Color(0xFF3A414E),
                  borderRadius: BorderRadius.circular(9.r),
                ),
                child: Image.asset(AppImages.logoApp),
              ),
              Padding(
                padding: EdgeInsets.only(top: 28.h, bottom: 8.h),
                child: AppText(
                  LocaleKeys.role_title.tr(),
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
              AppText(
                LocaleKeys.role_subTitle.tr(),
                fontSize: 14.sp,
                color: AppColors.textSecondaryColor.themeColor,
              ),
              SizedBox(height: 24.h),
              UsageTypeCard(
                title: LocaleKeys.role_personalTitle.tr(),
                subtitle: LocaleKeys.role_personalDesc.tr(),
                icon: AppImages.iconsMyself,
                iconColor: AppColors.mint.themeColor,
                isSelected: _selectedIndex == 0,
                onTap: () =>
                    NavigationService.push(Routes.profileCompletionScreen),
              ),
              SizedBox(height: 16.h),
              UsageTypeCard(
                title: LocaleKeys.role_teamTitle.tr(),
                subtitle: LocaleKeys.role_teamDesc.tr(),
                icon: AppImages.iconsCompany,
                iconColor: AppColors.blue.themeColor,
                isSelected: _selectedIndex == 1,
                onTap: () =>
                    NavigationService.push(Routes.profileCompletionScreen),
              ),
              const Spacer(),
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  child: AppText(
                    LocaleKeys.role_footerHint.tr(),
                    fontSize: 11.sp,
                    color: AppColors.textSecondaryColor.themeColor,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

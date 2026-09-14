import 'package:Silink/app/router/navigation_services.dart';
import 'package:Silink/app/router/routes.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/app_images.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class RoleSelection extends StatefulWidget {
  const RoleSelection({super.key});

  @override
  State<RoleSelection> createState() => _RoleSelectionState();
}

class _RoleSelectionState extends State<RoleSelection> {
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
              _RoleCard(
                title: LocaleKeys.role_personalTitle.tr(),
                subtitle: LocaleKeys.role_personalDesc.tr(),
                icon: AppImages.iconsMyself,
                iconColor: AppColors.mint.themeColor,
                isSelected: _selectedIndex == 0,
                onTap: () => NavigationService.push(Routes.onboardingFlowScreen),
              ),
              SizedBox(height: 16.h),
              _RoleCard(
                title: LocaleKeys.role_teamTitle.tr(),
                subtitle: LocaleKeys.role_teamDesc.tr(),
                icon: AppImages.iconsCompany,
                iconColor: AppColors.blue.themeColor,
                isSelected: _selectedIndex == 1,
                onTap: () => NavigationService.push(Routes.onboardingFlowScreen),
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

class _RoleCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String icon;
  final Color iconColor;
  final bool isSelected;
  final VoidCallback onTap;

  const _RoleCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14.r),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: AppColors.cardColor.themeColor,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: AppColors.dividerColor.themeColor,
            width: isSelected ? 1.5 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 46.w,
              height: 46.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: SvgPicture.asset(icon),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    title,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimaryColor.themeColor,
                  ),
                  SizedBox(height: 4.h),
                  AppText(
                    subtitle,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondaryColor.themeColor,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            Icon(
              Icons.chevron_right,
              color: AppColors.textSecondaryColor.themeColor,
              size: 20.sp,
            ),
          ],
        ),
      ),
    );
  }
}

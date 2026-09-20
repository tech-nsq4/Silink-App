import 'package:Silink/app/router/navigation_services.dart';
import 'package:Silink/app/router/routes.dart';
import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/app_images.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_button.dart';
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

  void _selectIndex(int index) {
    if (_selectedIndex == index) return;
    setState(() => _selectedIndex = index);
  }

  void _handleContinue() {
    if (_selectedIndex == null) return;
    if (_selectedIndex == 0) {
      NavigationService.push(
        Routes.personalRegisterScreen,
        arguments: {'usageIntent': 'personal'},
      );
      return;
    }
    NavigationService.push(Routes.registerScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: 19.paddingHorizontal + 16.paddingVert,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 40.h,
                alignment: Alignment.centerRight,
                padding: 6.paddingAll,
                decoration: BoxDecoration(
                  color: AppColors.darkSlate.themeColor,
                  borderRadius: BorderRadius.circular(9.r),
                ),
                child: Image.asset(AppImages.logoApp),
              ),
              Padding(
                padding: 28.paddingTop + 8.paddingBottom,
                child: AppText(
                  LocaleKeys.role_title.tr(),
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              AppText(
                LocaleKeys.role_subTitle.tr(),
                fontSize: 14.sp,
                color: AppColors.textSecondaryColor.themeColor,
              ),
              24.height,
              UsageTypeCard(
                title: LocaleKeys.role_personalTitle.tr(),
                subtitle: LocaleKeys.role_personalDesc.tr(),
                icon: AppImages.iconsMyself,
                iconColor: AppColors.mint.themeColor,
                isSelected: _selectedIndex == 0,
                onTap: () => _selectIndex(0),
              ),
              16.height,
              UsageTypeCard(
                title: LocaleKeys.role_teamTitle.tr(),
                subtitle: LocaleKeys.role_teamDesc.tr(),
                icon: AppImages.iconsCompany,
                iconColor: AppColors.blue.themeColor,
                isSelected: _selectedIndex == 1,
                onTap: () => _selectIndex(1),
              ),
              const Spacer(),
              CustomButton(
                title: LocaleKeys.role_continueCta.tr(),
                onTap: _handleContinue,
                height: 54,
                radius: 14,
                color: _selectedIndex == null
                    ? AppColors.dividerColor.themeColor
                    : null,
                textColor: _selectedIndex == null
                    ? AppColors.hintColor.themeColor
                    : null,
              ),
              Center(
                child: Padding(
                  padding: 12.paddingVert,
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

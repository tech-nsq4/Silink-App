import 'package:Silink/app/router/navigation_services.dart';
import 'package:Silink/app/router/routes.dart';
import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/app_images.dart';
import 'package:Silink/core/utils/app_overlay.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_button.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:Silink/core/widgets/screen_header_bar.dart';
import 'package:Silink/features/company/data/models/company_employee.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmployeeNfcLinkScreen extends StatelessWidget {
  const EmployeeNfcLinkScreen({
    super.key,
    required this.employee,
  });

  final CompanyEmployeeItem employee;

  Future<void> _handleAction(BuildContext context) async {
    if (!employee.hasProfile) {
      final result = await NavigationService.push(
        Routes.companyEmployeeDigital,
        arguments: {'employee': employee},
      );
      if (result is CompanyEmployeeItem && context.mounted) {
        Navigator.of(context).pop(result);
      }
      return;
    }

    await Future<void>.delayed(const Duration(milliseconds: 450));
    if (!context.mounted) return;
    AppOverlay.showSuccess(LocaleKeys.company_employee_nfc_linked.tr());
    Navigator.of(context).pop(employee.copyWith(hasNfc: true));
  }

  @override
  Widget build(BuildContext context) {
    final hasProfile = employee.hasProfile;
    return Scaffold(
      backgroundColor: AppColors.catalogDetailsBackground.themeColor,
      body: Column(
        children: [
          ScreenHeaderBar(title: LocaleKeys.company_employee_link_nfc.tr()),
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  children: [
                    SvgPicture.asset(
                      AppImages.iconsWifi,
                      width: 58.w,
                      height: 58.h,
                      colorFilter: ColorFilter.mode(
                        AppColors.textSecondaryColor.themeColor
                            .withValues(alpha: 0.35),
                        BlendMode.srcIn,
                      ),
                    ),
                    16.height,
                    AppText(
                      hasProfile
                          ? LocaleKeys.company_employee_link_nfc.tr()
                          : LocaleKeys.company_employee_profile_first_title
                              .tr(),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w800,
                    ),
                    8.height,
                    AppText(
                      hasProfile
                          ? LocaleKeys.company_nfc_intro_desc.tr()
                          : LocaleKeys.company_employee_profile_first_desc.tr(),
                      fontSize: 12.sp,
                      color: AppColors.textSecondaryColor.themeColor,
                      textAlign: TextAlign.center,
                      height: 1.5,
                    ),
                    22.height,
                    CustomButton(
                      onTap: () => _handleAction(context),
                      title: hasProfile
                          ? LocaleKeys.company_employee_link_nfc.tr()
                          : LocaleKeys.company_employee_digital_title.tr(),
                      height: 48,
                      radius: 14,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

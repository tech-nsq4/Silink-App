import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/app_images.dart';
import 'package:Silink/core/utils/app_overlay.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_button.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:Silink/core/widgets/screen_header_bar.dart';
import 'package:Silink/features/company/employees/data/models/company_employee_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmployeeDigitalProfileScreen extends StatelessWidget {
  const EmployeeDigitalProfileScreen({
    super.key,
    required this.employee,
  });

  final CompanyEmployeeModel employee;

  void _createProfile(BuildContext context) {
    AppOverlay.showSuccess(
      LocaleKeys.company_employee_profile_linked.tr(),
    );
    Navigator.of(context).pop(employee.copyWith(hasProfile: true));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ScreenHeaderBar(
            title: LocaleKeys.company_employee_digital_title.tr(),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(16.w, 18.h, 16.w, 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AppText(
                    LocaleKeys.company_employee_digital_desc.tr(),
                    fontSize: 12.sp,
                    color: AppColors.textSecondaryColor.themeColor,
                    textAlign: TextAlign.center,
                  ),
                  14.height,
                  CustomButton(
                    onTap: () => _createProfile(context),
                    isOutlined: true,
                    color: Colors.transparent,
                    borderColor: AppColors.successColor.themeColor,
                    textColor: AppColors.successColor.themeColor,
                    height: 46,
                    radius: 12,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          AppImages.iconsContacts,
                          width: 18.w,
                          height: 18.h,
                          colorFilter: ColorFilter.mode(
                            AppColors.successColor.themeColor,
                            BlendMode.srcIn,
                          ),
                        ),
                        8.width,
                        AppText(
                          LocaleKeys.myCards_createNewCard.tr(),
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.successColor.themeColor,
                        ),
                      ],
                    ),
                  ),
                  if (employee.hasProfile) ...[
                    16.height,
                    Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: AppColors.cardColor.themeColor,
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(
                          color: AppColors.borderColor.themeColor,
                        ),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            AppImages.iconsInternet,
                            width: 20.w,
                            height: 20.h,
                          ),
                          12.width,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(
                                  employee.name,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w800,
                                ),
                                3.height,
                                AppText(
                                  employee.position,
                                  fontSize: 11.sp,
                                  color:
                                      AppColors.textSecondaryColor.themeColor,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

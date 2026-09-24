import 'package:Silink/app/router/navigation_services.dart';
import 'package:Silink/app/router/routes.dart';
import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/app_constants.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:Silink/features/company/company_profile_completion/presentation/widgets/company_action_bar.dart';
import 'package:Silink/features/company/company_profile_completion/presentation/widgets/company_info_row.dart';
import 'package:Silink/features/company/shared/widgets/company_field.dart';

class CompanySuccessScreen extends StatelessWidget {
  const CompanySuccessScreen({
    super.key,
    this.companyName = '',
    this.industry = '',
    this.subIndustry = '',
    this.size = '',
    this.city = '',
    this.phone = '',
    this.email = '',
    this.website = '',
    this.bio = '',
  });

  final String companyName;
  final String industry;
  final String subIndustry;
  final String size;
  final String city;
  final String phone;
  final String email;
  final String website;
  final String bio;

  @override
  Widget build(BuildContext context) {
    final name = companyName.trim().isEmpty
        ? AppConstants.appName
        : companyName.trim();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 19.w, vertical: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 96.w,
                height: 96.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.mintSoft.themeColor,
                ),
                child: Icon(
                  Icons.check_circle_rounded,
                  size: 56.sp,
                  color: AppColors.mint.themeColor,
                ),
              ),
              24.height,
              AppText(
                LocaleKeys.company_success_title.tr(),
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                textAlign: TextAlign.center,
              ),
              8.height,
              AppText(
                LocaleKeys.company_success_subtitle.tr(
                  namedArgs: {'name': name},
                ),
                fontSize: 13.5.sp,
                color: AppColors.textSecondaryColor.themeColor,
                textAlign: TextAlign.center,
              ),
              24.height,
              CompanySectionCard(
                title: LocaleKeys.company_review_title.tr(),
                child: Column(
                  children: [
                    CompanyInfoRow(
                        label: LocaleKeys.company_name.tr(), value: name),
                    if (industry.isNotEmpty)
                      CompanyInfoRow(
                          label: LocaleKeys.company_industry.tr(),
                          value: industry),
                    if (subIndustry.isNotEmpty)
                      CompanyInfoRow(
                          label: LocaleKeys.company_sub_industry.tr(),
                          value: subIndustry),
                    if (size.isNotEmpty)
                      CompanyInfoRow(
                          label: LocaleKeys.company_size.tr(), value: size),
                    if (city.isNotEmpty)
                      CompanyInfoRow(
                          label: LocaleKeys.company_city.tr(), value: city),
                    if (phone.isNotEmpty)
                      CompanyInfoRow(
                          label: LocaleKeys.company_phone.tr(), value: phone),
                    if (email.isNotEmpty)
                      CompanyInfoRow(
                          label: LocaleKeys.company_contact_email.tr(),
                          value: email),
                    if (website.isNotEmpty)
                      CompanyInfoRow(
                          label: LocaleKeys.company_website.tr(),
                          value: website),
                    if (bio.isNotEmpty)
                      CompanyInfoRow(
                          label: LocaleKeys.company_bio.tr(), value: bio),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CompanyActionBar(
        titleKey: LocaleKeys.company_go_dashboard,
        onTap: () => NavigationService.pushNamedAndRemoveUntil(
          Routes.companyDashboard,
        ),
      ),
    );
  }
}

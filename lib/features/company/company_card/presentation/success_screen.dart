import 'package:Silink/app/router/navigation_services.dart';
import 'package:Silink/app/router/routes.dart';
import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../company_profile_completion/presentation/widgets/company_action_bar.dart';


class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const name = 'Silink';
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 19.w),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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

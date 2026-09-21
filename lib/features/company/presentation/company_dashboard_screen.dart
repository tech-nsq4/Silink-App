import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:Silink/app/router/navigation_services.dart';
import 'package:Silink/app/router/routes.dart';
import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/screen_header_bar.dart';
import '../widgets/dashboard/company_dashboard_action_buttons.dart';
import '../widgets/dashboard/company_dashboard_card.dart';
import '../widgets/dashboard/company_profile_completion_card.dart';
import '../widgets/dashboard/company_quick_actions.dart';
import '../widgets/dashboard/company_settings_list.dart';
import '../widgets/dashboard/company_stats_grid.dart';

class CompanyDashboardScreen extends StatelessWidget {
  const CompanyDashboardScreen({super.key});

  void _onEdit() => NavigationService.push(Routes.companyEdit);
  void _onShare() => NavigationService.push(Routes.companyQr);
  void _onEmployees() => NavigationService.push(Routes.companyEmployees);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ScreenHeaderBar(
              title: LocaleKeys.company_dashboard_title.tr(),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: 19.w,
                  vertical: 16.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CompanyDashboardCard(companyName: 'Silink'),
                    12.height,
                    CompanyStatsGrid(
                      employees: 0,
                      cards: 0,
                    ),
                    12.height,
                    const CompanyProfileCompletionCard(),
                    12.height,
                    CompanyQuickActions(
                      onShare: _onShare,
                      onEmployees: _onEmployees,
                      onCards: () => NavigationService.push(
                        Routes.companyCards,
                      ),
                    ),
                    12.height,
                    CompanySettingsList(
                      onCards: () => NavigationService.push(
                        Routes.companyCards,
                      ),
                      onBrand: () => NavigationService.push(
                        Routes.companyBrand,
                      ),
                      onCatalog: () => NavigationService.push(
                        Routes.companyCatalog,
                      ),
                      onEmployees: _onEmployees,
                      onQr: _onShare,
                      onPublish: () => NavigationService.push(
                        Routes.companyPublish,
                      ),
                      onEdit: _onEdit,
                    ),
                    16.height,
                    CompanyDashboardActionButtons(
                      onEdit: _onEdit,
                      onShare: _onShare,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

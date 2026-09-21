import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:Silink/app/router/navigation_services.dart';
import 'package:Silink/app/router/routes.dart';
import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/screen_header_bar.dart';
import 'package:Silink/features/company/logic/company_cubit.dart';
import 'package:Silink/features/company/logic/company_state.dart';
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
    return BlocBuilder<CompanyCubit, CompanyState>(
      builder: (context, state) {
        final company = state.company;
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
                        CompanyDashboardCard(companyName: company.name),
                        12.height,
                        CompanyStatsGrid(
                          employees: state.employees.length,
                          cards: state.cards.length,
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
      },
    );
  }
}

/*__OLD_PRIVATE_WIDGETS_DISABLED__

class _CompanyCard extends StatelessWidget {
  const _CompanyCard({required this.companyName});
  final String companyName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xff2C9092), Color(0xff2368E2)],
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24.r,
            backgroundColor: Colors.white.withValues(alpha: 0.25),
            child: AppText(
              companyName.isEmpty ? 'Q' : companyName[0],
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          12.width,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  companyName,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
                4.height,
                AppText(
                  LocaleKeys.company_dashboard_sub.tr(),
                  fontSize: 11.5.sp,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
//__PART5__FIXED__
class _SettingsCard extends StatelessWidget {
  const _SettingsCard({
    required this.onEdit,
    required this.onShare,
    required this.onEmployees,
  });
  final VoidCallback onEdit;
  final VoidCallback onShare;
  final VoidCallback onEmployees;

  @override
  Widget build(BuildContext context) {
    return CompanySectionCard(
      title: LocaleKeys.company_settings.tr(),
      child: Column(
        children: [
          _SettingsTile(
            icon: Icons.credit_card_rounded,
            label: LocaleKeys.company_cards.tr(),
            onTap: () => NavigationService.push(Routes.companyCards),
          ),
          _SettingsTile(
            icon: Icons.palette_outlined,
            label: LocaleKeys.company_brand.tr(),
            onTap: () => NavigationService.push(Routes.companyBrand),
          ),
          _SettingsTile(
            icon: Icons.list_alt_rounded,
            label: LocaleKeys.company_catalog.tr(),
            onTap: () => NavigationService.push(Routes.companyCatalog),
          ),
          _SettingsTile(
            icon: Icons.people_outline_rounded,
            label: LocaleKeys.company_employees.tr(),
            onTap: onEmployees,
          ),
          _SettingsTile(
            icon: Icons.qr_code_rounded,
            label: LocaleKeys.company_qr.tr(),
            onTap: onShare,
          ),
          _SettingsTile(
            icon: Icons.publish_rounded,
            label: LocaleKeys.company_publish.tr(),
            onTap: () => NavigationService.push(Routes.companyPublish),
          ),
        ],
      ),
    );
  }
}

class _StatsGrid extends StatelessWidget {
  const _StatsGrid({required this.employees, required this.cards});
  final int employees;
  final int cards;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatTile(
            value: '$employees',
            label: LocaleKeys.company_employees.tr(),
            icon: Icons.people_outline_rounded,
          ),
        ),
        10.width,
        Expanded(
          child: _StatTile(
            value: '$cards',
            label: LocaleKeys.company_cards.tr(),
            icon: Icons.credit_card_rounded,
          ),
        ),
        10.width,
        Expanded(
          child: _StatTile(
            value: '57',
            label: LocaleKeys.company_fans.tr(),
            icon: Icons.favorite_border_rounded,
          ),
        ),
      ],
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({
    required this.value,
    required this.label,
    required this.icon,
  });
  final String value;
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14.h),
      decoration: BoxDecoration(
        color: AppColors.cardColor.themeColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.borderColor.themeColor),
      ),
      child: Column(
        children: [
          Icon(icon, size: 20.sp, color: AppColors.mint.themeColor),
          6.height,
          AppText(value, fontSize: 17.sp, fontWeight: FontWeight.w700),
          2.height,
          AppText(
            label,
            fontSize: 11.5.sp,
            color: AppColors.textSecondaryColor.themeColor,
          ),
        ],
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.label,
    required this.onTap,
  });
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: AppColors.mintSoft.themeColor,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(
                icon,
                size: 18.sp,
                color: AppColors.mint.themeColor,
              ),
            ),
            10.width,
            Expanded(
              child: AppText(
                label,
                fontSize: 13.5.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            Icon(
              Icons.chevron_left,
              size: 18.sp,
              color: AppColors.textSecondaryColor.themeColor,
            ),
          ],
        ),
      ),
    );
  }
}
 */ //__OLD_PRIVATE_WIDGETS_DISABLED__
 /*__DISABLED_DUPLICATE__
import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_button.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:Silink/core/widgets/screen_header_bar.dart';
import 'package:Silink/features/company/logic/company_cubit.dart';
import 'package:Silink/features/company/logic/company_state.dart';
import 'widgets/company_field.dart';

class CompanyDashboardScreen extends StatelessWidget {
  const CompanyDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompanyCubit, CompanyState>(
      builder: (context, state) {
        final company = state.company;
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                ScreenHeaderBar(
                  title: LocaleKeys.company_dashboard_title.tr(),
                ),
                // __DISABLED_DUPLICATE__ (kept for reference only)
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: 19.w,
                      vertical: 16.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _CompanyCard(companyName: company.name),
                        12.height,
                        _StatsGrid(
                          employees: state.employees.length,
                          cards: state.cards.length,
                        ),
                        12.height,
                        CompanySectionCard(
                          title: LocaleKeys.company_complete_profile.tr(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.r),
                                child: LinearProgressIndicator(
                                  value: 0.65,
                                  minHeight: 6.h,
                                  backgroundColor:
                                      AppColors.mintSoft.themeColor,
                                  valueColor:
                                      AlwaysStoppedAnimation<Color>(
                                    AppColors.mint.themeColor,
                                  ),
                                ),
                              ),
                              10.height,
                              AppText(
                                LocaleKeys.company_complete_hint.tr(),
                                fontSize: 12.sp,
                                color:
                                    AppColors.textSecondaryColor.themeColor,
                              ),
                            ],
                          ),
                        ),
                        12.height,
                        CompanySectionCard(
                          title:
                              LocaleKeys.company_advanced_settings.tr(),
                          child: Column(
                            children: [
                              _SettingsTile(
                                icon: Icons.credit_card_rounded,
                                label: LocaleKeys.company_cards.tr(),
                                onTap: () => NavigationService.push(
                                  Routes.companyCards,
                                ),
                              ),
                              _SettingsTile(
                                icon: Icons.credit_card_rounded,
                                label: LocaleKeys.company_cards.tr(),
                                onTap: () => NavigationService.push(
                                  Routes.companyCards,
                                ),
                              ),
                              _SettingsTile(
                                icon: Icons.palette_outlined,
                                label: LocaleKeys.company_brand.tr(),
                                onTap: () => NavigationService.push(
                                  Routes.companyBrand,
                                ),
                              ),
                              _SettingsTile(
                                icon: Icons.storefront_outlined,
                                label: LocaleKeys.company_catalog.tr(),
                                onTap: () => NavigationService.push(
                                  Routes.companyCatalog,
                                ),
                              ),
                              _SettingsTile(
                                icon: Icons.people_outline_rounded,
                                label: LocaleKeys.company_employees.tr(),
                                onTap: () => NavigationService.push(
                                  Routes.companyEmployees,
                                ),
                              ),
                              _SettingsTile(
                                icon: Icons.qr_code_2_rounded,
                                label: LocaleKeys.company_qr.tr(),
                                onTap: () => NavigationService.push(
                                  Routes.companyQr,
                                ),
                              ),
                              _SettingsTile(
                                icon: Icons.public_rounded,
                                label: LocaleKeys.company_publish.tr(),
                                onTap: () => NavigationService.push(
                                  Routes.companyPublish,
                                ),
                              ),
                            ],
                          ),
                        ),
                        12.height,
                        CustomButton(
                          onTap: () => NavigationService.push(
                            Routes.companyEdit,
                          ),
                          isOutlined: true,
                          borderColor: AppColors.borderColor.themeColor,
                          child: AppText(
                            LocaleKeys.company_edit_data.tr(),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _CompanyCard extends StatelessWidget {
  const _CompanyCard({required this.companyName});

  final String companyName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xff2C9092), Color(0xff2368E2)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: Row(
        children: [
          Container(
            width: 52.w,
            height: 52.w,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white24,
            ),
            child: Center(
              child: AppText(
                companyName.trim().isEmpty
                    ? 'Q'
                    : companyName.trim().substring(0, 1),
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
          12.width,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  companyName.isEmpty ? '---' : companyName,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
                4.height,
                AppText(
                  LocaleKeys.company_active_account.tr(),
                  fontSize: 12.sp,
                  color: Colors.white70,
                ),
              ],
            ),
          ),
          const Icon(
            Icons.verified_rounded,
            color: Colors.white,
            size: 22,
          ),
        ],
      ),
    );
  }
}

class _StatsGrid extends StatelessWidget {
  const _StatsGrid({required this.employees, required this.cards});

  final int employees;
  final int cards;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatTile(
            value: '$employees',
            label: LocaleKeys.company_employees.tr(),
            icon: Icons.people_outline_rounded,
          ),
        ),
        10.width,
        Expanded(
          child: _StatTile(
            value: '$cards',
            label: LocaleKeys.company_cards.tr(),
            icon: Icons.credit_card_rounded,
          ),
        ),
        10.width,
        const Expanded(
          child: _StatTile(
            value: '57',
            label: 'fans',
            icon: Icons.favorite_border_rounded,
          ),
        ),
      ],
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({
    required this.value,
    required this.label,
    required this.icon,
  });

  final String value;
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14.h),
      decoration: BoxDecoration(
        color: AppColors.cardColor.themeColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.borderColor.themeColor),
      ),
      child: Column(
        children: [
          Icon(icon, size: 20.sp, color: AppColors.mint.themeColor),
          6.height,
          AppText(value, fontSize: 17.sp, fontWeight: FontWeight.w700),
          2.height,
          AppText(
            label,
            fontSize: 11.5.sp,
            color: AppColors.textSecondaryColor.themeColor,
          ),
        ],
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: AppColors.mintSoft.themeColor,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(
                icon,
                size: 18.sp,
                color: AppColors.mint.themeColor,
              ),
            ),
            10.width,
            Expanded(
              child: AppText(
                label,
                fontSize: 13.5.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            Icon(
              Icons.chevron_left,
              size: 18.sp,
              color: AppColors.textSecondaryColor.themeColor,
            ),
          ],
        ),
      ),
    );
  }
}

*/

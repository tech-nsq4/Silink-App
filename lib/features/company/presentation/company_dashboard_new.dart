import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Silink/app/router/navigation_services.dart';
import 'package:Silink/app/router/routes.dart';
import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:Silink/core/widgets/screen_header_bar.dart';
import 'package:Silink/features/company/logic/company_cubit.dart';
import 'package:Silink/features/company/logic/company_state.dart';
import '../widgets/company_field.dart';

class CompanyDashboardScreen extends StatelessWidget {
  const CompanyDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompanyCubit, CompanyState>(
      builder: (context, state) {
        final name = state.company.name;
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
                        _CompanyCard(companyName: name),
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
                                color: AppColors.textSecondaryColor.themeColor,
                              ),
                            ],
                          ),
                        ),
                        12.height,
                        CompanySectionCard(
                          title: LocaleKeys.company_settings.tr(),
                          child: Column(
                            children: [
                              _Tile(
                                icon: Icons.credit_card_rounded,
                                label: LocaleKeys.company_cards.tr(),
                                route: Routes.companyCards,
                              ),
                              _Tile(
                                icon: Icons.palette_outlined,
                                label: LocaleKeys.company_brand.tr(),
                                route: Routes.companyBrand,
                              ),
                              _Tile(
                                icon: Icons.grid_view_rounded,
                                label: LocaleKeys.company_catalog.tr(),
                                route: Routes.companyCatalog,
                              ),
                              _Tile(
                                icon: Icons.people_outline_rounded,
                                label: LocaleKeys.company_employees.tr(),
                                route: Routes.companyEmployees,
                              ),
                              _Tile(
                                icon: Icons.qr_code_rounded,
                                label: LocaleKeys.company_qr.tr(),
                                route: Routes.companyQr,
                              ),
                              _Tile(
                                icon: Icons.publish_rounded,
                                label: LocaleKeys.company_publish.tr(),
                                route: Routes.companyPublish,
                              ),
                              _Tile(
                                icon: Icons.edit_outlined,
                                label: LocaleKeys.company_edit.tr(),
                                route: Routes.companyEdit,
                              ),
                            ],
                          ),
                        ),
                        20.height,
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
    final display = companyName.trim().isEmpty ? 'Q' : companyName.trim();
    final initial = companyName.trim().isEmpty ? 'Q' : companyName.trim()[0];
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xff2C9092), Color(0xff2368E2)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          Container(
            width: 52.w,
            height: 52.w,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: AppText(initial,
                  fontSize: 22.sp, fontWeight: FontWeight.w700),
            ),
          ),
          12.width,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(display,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
                4.height,
                AppText(LocaleKeys.company_dashboard_sub.tr(),
                    fontSize: 11.5.sp, color: Colors.white),
              ],
            ),
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
  const _StatTile(
      {required this.value, required this.label, required this.icon});
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
          AppText(label,
              fontSize: 11.5.sp,
              color: AppColors.textSecondaryColor.themeColor),
        ],
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile(
      {required this.icon, required this.label, required this.route});
  final IconData icon;
  final String label;
  final String route;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => NavigationService.push(route),
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
              child: Icon(icon,
                  size: 18.sp, color: AppColors.mint.themeColor),
            ),
            10.width,
            Expanded(
              child: AppText(label,
                  fontSize: 13.5.sp, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}

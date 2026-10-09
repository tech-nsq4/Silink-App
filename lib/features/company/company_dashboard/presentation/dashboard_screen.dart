import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/router/navigation_services.dart';
import '../../../../app/router/routes.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/flow_top_bar.dart';
import '../../../profile/logic/profile_cubit.dart';
import '../../data/models/company_business_type.dart';
import '../data/models/company_dashboard_info.dart';
import '../logic/company_dashboard_cubit.dart';
import 'widgets/hub_company_head.dart';
import 'widgets/hub_manage_list.dart';
import 'widgets/hub_outline_button.dart';
import 'widgets/hub_presence_card.dart';
import 'widgets/hub_stat_card.dart';
import 'widgets/hub_tabs.dart';
import 'widgets/hub_team_invite_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late final CompanyDashboardCubit _cubit = getIt<CompanyDashboardCubit>()
    ..getDashboardInfo();
  int _tab = 0;

  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().registerFcmToken();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  CompanyDashboardInfo? get _info {
    final state = _cubit.state;
    return state is CompanyDashboardSuccess ? state.info : null;
  }

  Future<void> _openAndRefresh(String route,
      {Map<String, dynamic>? arguments}) async {
    await NavigationService.push(route, arguments: arguments);
    if (mounted && !_cubit.isClosed) _cubit.getDashboardInfo();
  }

  void _onEdit() => _openAndRefresh(Routes.companyEdit);
  void _onInvite() => _openAndRefresh(Routes.companyInvite);
  void _onEmployees() => _openAndRefresh(Routes.companyEmployees);
  void _onCards() => _openAndRefresh(Routes.companyCards);
  void _onBrand() => NavigationService.push(Routes.companyBrand);
  void _onQr() => NavigationService.push(Routes.companyQr);
  void _onCatalog() => NavigationService.push(
        Routes.companyCatalog,
        arguments: {
          'businessType': CompanyBusinessType.restaurant,
          'companyName': _info?.companyName ?? '',
          'providerCity': _info?.city ?? '',
          'editable': true,
        },
      );
  void _onViewPage() {
    final info = _info;
    if (info == null) return;
    NavigationService.push(
      Routes.companyPublicPage,
      arguments: {'data': info.toPublicPage()},
    );
  }

  void _onBackToPersonal() =>
      NavigationService.pushNamedAndRemoveUntil(Routes.layoutScreen);

  Widget _summary(CompanyDashboardInfo? info) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: HubStatCard(
                icon: Icons.people_outline_rounded,
                value: info?.activeMembers ?? 0,
                label: LocaleKeys.companyHub_activeMembers.tr(),
                onTap: _onEmployees,
              ),
            ),
            12.width,
            Expanded(
              child: HubStatCard(
                icon: Icons.contactless_outlined,
                value: info?.activeCards ?? 0,
                label: LocaleKeys.companyHub_activeCards.tr(),
                onTap: _onCards,
              ),
            ),
          ],
        ),
        SizedBox(height: 26.h),
        AppText(
          LocaleKeys.companyHub_presence.tr(),
          fontSize: 14.sp,
          fontWeight: FontWeight.w800,
        ),
        SizedBox(height: 12.h),
        HubPresenceCard(
          stats: [
            (info?.visits ?? 0, LocaleKeys.companyHub_visits.tr()),
            (info?.leads ?? 0, LocaleKeys.companyHub_leads.tr()),
          ],
        ),
        SizedBox(height: 24.h),
        HubTeamInviteCard(
          memberNames: [for (final member in info?.team ?? []) member.name],
          onAdd: _onInvite,
        ),
      ],
    );
  }

  Widget _manage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppText(
          LocaleKeys.companyHub_manageTitle.tr(),
          fontSize: 14.sp,
          fontWeight: FontWeight.w800,
        ),
        SizedBox(height: 6.h),
        HubManageList(
          items: [
            HubManageItem(
              icon: Icons.people_outline_rounded,
              title: LocaleKeys.companyHub_employees.tr(),
              subtitle: LocaleKeys.companyHub_employeesHint.tr(),
              onTap: _onEmployees,
            ),
            HubManageItem(
              icon: Icons.contactless_outlined,
              title: LocaleKeys.companyHub_cards.tr(),
              subtitle: LocaleKeys.companyHub_cardsHint.tr(),
              onTap: _onCards,
            ),
            HubManageItem(
              icon: Icons.inventory_2_outlined,
              title: LocaleKeys.companyHub_catalog.tr(),
              subtitle: LocaleKeys.companyHub_catalogHint.tr(),
              onTap: _onCatalog,
            ),
            HubManageItem(
              icon: Icons.dashboard_customize_outlined,
              title: LocaleKeys.companyHub_brand.tr(),
              subtitle: LocaleKeys.companyHub_brandHint.tr(),
              onTap: _onBrand,
            ),
            HubManageItem(
              icon: Icons.apartment_rounded,
              title: LocaleKeys.companyHub_data.tr(),
              subtitle: LocaleKeys.companyHub_dataHint.tr(),
              onTap: _onEdit,
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor.themeColor,
      body: Column(
        children: [
          SafeArea(
            bottom: false,
            child: FlowTopBar(
              eyebrow: LocaleKeys.companyHub_eyebrow.tr(),
              title: LocaleKeys.companyHub_title.tr(),
              onBack: _onBackToPersonal,
              action: InkWell(
                onTap: _onEdit,
                customBorder: const CircleBorder(),
                child: Container(
                  width: 35.w,
                  height: 35.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.white.themeColor,
                    shape: BoxShape.circle,
                    border:
                        Border.all(color: AppColors.topIconBorder.themeColor),
                  ),
                  child: Icon(Icons.edit_outlined,
                      size: 17.sp, color: AppColors.topIconColor.themeColor),
                ),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<CompanyDashboardCubit, CompanyDashboardState>(
              bloc: _cubit,
              builder: (context, state) {
                final info =
                    state is CompanyDashboardSuccess ? state.info : null;
                final city = info?.city ?? '';
                return RefreshIndicator(
                  color: AppColors.accentTeal.themeColor,
                  onRefresh: _cubit.getDashboardInfo,
                  child: ListView(
                    padding: EdgeInsets.fromLTRB(22.w, 10.h, 22.w, 28.h),
                    children: [
                      HubCompanyHead(
                        name: info?.companyName ?? kUserModel?.company ?? '',
                        meta: [
                          if (city.isNotEmpty) city,
                          LocaleKeys.companyHub_account.tr(),
                        ].join(' · '),
                        logoUrl: info?.logoUrl,
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        children: [
                          Expanded(
                            child: HubOutlineButton(
                              icon: Icons.language_rounded,
                              label: LocaleKeys.companyHub_publicPage.tr(),
                              onTap: _onViewPage,
                            ),
                          ),
                          12.width,
                          Expanded(
                            child: HubOutlineButton(
                              icon: Icons.qr_code_2_rounded,
                              label: LocaleKeys.companyHub_share.tr(),
                              onTap: _onQr,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 22.h),
                      HubTabs(
                        labels: [
                          LocaleKeys.companyHub_tabSummary.tr(),
                          LocaleKeys.companyHub_tabManage.tr(),
                        ],
                        selected: _tab,
                        onSelected: (index) => setState(() => _tab = index),
                      ),
                      SizedBox(height: 22.h),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        child: KeyedSubtree(
                          key: ValueKey(_tab),
                          child: _tab == 0 ? _summary(info) : _manage(),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

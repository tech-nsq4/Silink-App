import 'package:Silink/app/router/navigation_services.dart';
import 'package:Silink/app/router/routes.dart';
import 'package:Silink/core/di/injection.dart';
import 'package:Silink/core/utils/app_constants.dart';
import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/screen_header_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'widgets/company_dashboard_action_buttons.dart';
import 'widgets/company_dashboard_card.dart';
import 'widgets/company_quick_actions.dart';
import 'widgets/company_stats_grid.dart';
import '../data/models/company_dashboard_info.dart';
import '../logic/company_dashboard_cubit.dart';
import '../../data/models/company_business_type.dart';
import '../../data/models/company_public_page_data.dart';
import '../../widgets/dashboard/company_profile_completion_card.dart';
import '../../company_card/presentation/edit_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String? _imagePath;
  late final CompanyDashboardCubit _cubit = getIt<CompanyDashboardCubit>()
    ..getDashboardInfo();

  CompanyDashboardInfo? get _info {
    final state = _cubit.state;
    return state is CompanyDashboardSuccess ? state.info : null;
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  Future<void> _onEdit() async {
    final result = await NavigationService.push(
      Routes.companyEdit,
      arguments: {'imagePath': _imagePath},
    );
    if (!mounted || result is! CompanyEditResult) return;
    setState(() => _imagePath = result.image?.path);
    _cubit.getDashboardInfo();
  }

  void _onInvite() => NavigationService.push(Routes.companyInvite);
  void _onEmployees() => NavigationService.push(Routes.companyEmployees);
  void _onCards() => NavigationService.push(Routes.companyCards);
  void _onCatalog() => NavigationService.push(
        Routes.companyCatalog,
        arguments: {
          'businessType': CompanyBusinessType.restaurant,
          'companyName': _info?.companyName ?? '',
          'providerCity': _info?.city ?? '',
          'editable': true,
        },
      );
  void _onBrand() => NavigationService.push(Routes.companyBrand);
  void _onPublish() => NavigationService.push(Routes.companyPublish);
  void _onViewPage() => NavigationService.push(
        Routes.companyPublicPage,
        arguments: {
          'data': CompanyPublicPageData.sample.withImagePath(_imagePath),
        },
      );
  void _onQr() => NavigationService.push(Routes.companyQr);
  void _onBackToPersonal() =>
      NavigationService.pushNamedAndRemoveUntil(Routes.layoutScreen);

  VoidCallback _primaryAction(bool isPublished) =>
      isPublished ? _onViewPage : _onPublish;

  VoidCallback _secondaryAction(bool isPublished) =>
      isPublished ? _onQr : _onCatalog;

  @override
  Widget build(BuildContext context) {
    const isPublished = true;

    return Scaffold(
      body: Column(
        children: [
          ScreenHeaderBar(
            title: LocaleKeys.company_dashboard_title.tr(),
            onBack: _onBackToPersonal,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocBuilder<CompanyDashboardCubit, CompanyDashboardState>(
                    bloc: _cubit,
                    builder: (context, state) {
                      final info =
                          state is CompanyDashboardSuccess ? state.info : null;
                      return CompanyDashboardCard(
                        companyName:
                            info?.companyName ?? kUserModel?.company ?? '',
                        industry: info?.industry,
                        city: info?.city,
                        logoUrl: info?.logoUrl,
                        imagePath: _imagePath,
                      );
                    },
                  ),
                  10.height,
                  const CompanyStatsGrid(
                    employees: 1,
                    cards: 0,
                    visits: 57,
                    leads: 10,
                  ),
                  12.height,
                  CompanyPublicPageCard(
                    isPublished: isPublished,
                    onPrimary: _primaryAction(isPublished),
                    onSecondary: _secondaryAction(isPublished),
                  ),
                  24.height,
                  CompanyQuickActions(
                    isPublished: isPublished,
                    onPrimary: _primaryAction(isPublished),
                    onQr: _onQr,
                    onInvite: _onInvite,
                    onEmployees: _onEmployees,
                    onCards: _onCards,
                    onCatalog: _onCatalog,
                    onEdit: _onEdit,
                    onBrand: _onBrand,
                  ),
                  12.height,
                  CompanyBackToPersonalButton(
                    onTap: _onBackToPersonal,
                  ),
                  16.height,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

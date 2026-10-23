import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/router/navigation_services.dart';
import '../../../app/router/routes.dart';
import '../../../core/di/injection.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/locale_keys.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/filter_chips_bar.dart';
import '../../../core/widgets/flow_page_title.dart';
import '../../../core/widgets/flow_top_bar.dart';
import '../../../core/widgets/screen_state_layout.dart';
import '../../settings/presentation/widgets/settings_confirm_dialog.dart';
import '../data/models/portfolio_model.dart';
import '../logic/portfolios_cubit.dart';
import 'widgets/portfolio_actions.dart';
import 'widgets/portfolio_list_item.dart';
import 'widgets/portfolio_more_sheet.dart';

class PortfoliosScreen extends StatefulWidget {
  const PortfoliosScreen({super.key, this.showBack = false});

  final bool showBack;

  @override
  State<PortfoliosScreen> createState() => _PortfoliosScreenState();
}

class _PortfoliosScreenState extends State<PortfoliosScreen> {
  static const String _activeFilter = 'active';
  static const String _pausedFilter = 'paused';

  late final PortfoliosCubit _cubit = getIt<PortfoliosCubit>()..load();
  String _query = '';
  String? _filter;

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  List<PortfolioModel> _filtered(List<PortfolioModel> portfolios) {
    final query = _query.trim().toLowerCase();
    return portfolios.where((p) {
      if (_filter == _activeFilter && !p.isActive) return false;
      if (_filter == _pausedFilter && p.isActive) return false;
      if (query.isEmpty) return true;
      return [p.name, p.displayName, p.jobTitle, p.company]
          .any((value) => value.toLowerCase().contains(query));
    }).toList();
  }

  Future<void> _openDetails(PortfolioModel portfolio) async {
    final changed = await NavigationService.push(
      Routes.portfolioDetailsScreen,
      arguments: {'portfolio': portfolio},
    );
    if (changed == true && mounted) _cubit.load();
  }

  Future<void> _edit(PortfolioModel portfolio) async {
    await PortfolioActions.edit(portfolio);
    if (mounted) _cubit.load();
  }

  Future<void> _more(PortfolioModel portfolio) async {
    final action = await PortfolioMoreSheet.show(context, portfolio);
    if (!mounted) return;
    switch (action) {
      case PortfolioMoreAction.copyLink:
        PortfolioActions.copyLink(portfolio);
      case PortfolioMoreAction.toggle:
        _cubit.toggleActive(portfolio);
      case PortfolioMoreAction.delete:
        final confirmed = await SettingsConfirmDialog.show(
          context,
          title: LocaleKeys.portfolios_delete.tr(),
          message: LocaleKeys.portfolios_deleteConfirm.tr(),
        );
        if (confirmed) _cubit.delete(portfolio);
      case null:
        break;
    }
  }

  Future<void> _create() async {
    await NavigationService.push(Routes.newCardStartScreen);
    if (mounted) _cubit.load();
  }

  @override
  Widget build(BuildContext context) {
    final topBar = FlowTopBar(
      eyebrow: LocaleKeys.portfolios_eyebrow.tr(),
      title: LocaleKeys.portfolios_title.tr(),
      showBack: widget.showBack,
      action: InkWell(
        onTap: _create,
        customBorder: const CircleBorder(),
        child: Container(
          width: 35.w,
          height: 35.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.white.themeColor,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.topIconBorder.themeColor),
          ),
          child: Icon(Icons.add_rounded,
              size: 19.sp, color: AppColors.topIconColor.themeColor),
        ),
      ),
    );
    return Scaffold(
      backgroundColor: AppColors.backgroundColor.themeColor,
      body: Column(
        children: [
          widget.showBack ? SafeArea(bottom: false, child: topBar) : topBar,
          Expanded(
            child: BlocBuilder<PortfoliosCubit, PortfoliosState>(
              bloc: _cubit,
              builder: (context, state) => CustomScreenStateLayout(
                isLoading:
                    state is PortfoliosInitial || state is PortfoliosLoading,
                error: state is PortfoliosError
                    ? ErrorModel(
                        code: ErrorEnum.otherError,
                        errorMessage: state.message,
                      )
                    : null,
                onRetry: _cubit.load,
                builder: (context) {
                  final portfolios = (state as PortfoliosSuccess).portfolios;
                  final filtered = _filtered(portfolios);
                  return RefreshIndicator(
                    color: AppColors.accentTeal.themeColor,
                    onRefresh: _cubit.load,
                    child: ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      padding: EdgeInsets.fromLTRB(22.w, 6.h, 22.w, 28.h),
                      children: [
                        FlowPageTitle(
                          eyebrow: LocaleKeys.portfolios_countEyebrow
                              .tr(args: ['${portfolios.length}']),
                          title: LocaleKeys.portfolios_pageTitle.tr(),
                          subtitle: LocaleKeys.portfolios_pageSubtitle.tr(),
                        ),
                        CustomTextField(
                          hint: LocaleKeys.portfolios_search.tr(),
                          onChanged: (value) => setState(() => _query = value),
                          borderRadius: 14.r,
                          fillColor: AppColors.white.themeColor,
                          borderColor: AppColors.studioPanelBorder.themeColor,
                          focusedBorderColor: AppColors.accentTeal.themeColor,
                          prefixIcon: Icon(
                            Icons.search_rounded,
                            size: 19.sp,
                            color: AppColors.textSecondaryColor.themeColor,
                          ),
                        ),
                        SizedBox(height: 14.h),
                        FilterChipsBar<String>(
                          allLabel: LocaleKeys.portfolios_all.tr(),
                          options: const [_activeFilter, _pausedFilter],
                          labelOf: (filter) => filter == _activeFilter
                              ? LocaleKeys.portfolios_active.tr()
                              : LocaleKeys.portfolios_paused.tr(),
                          selected: _filter,
                          onSelected: (filter) =>
                              setState(() => _filter = filter),
                        ),
                        SizedBox(height: 18.h),
                        if (filtered.isEmpty)
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 40.h),
                            child: AppText(
                              LocaleKeys.portfolios_empty.tr(),
                              fontSize: 10.sp,
                              textAlign: TextAlign.center,
                              color: AppColors.textSecondaryColor.themeColor,
                            ),
                          )
                        else
                          for (final portfolio in filtered)
                            PortfolioListItem(
                              portfolio: portfolio,
                              onOpen: () => _openDetails(portfolio),
                              onMore: () => _more(portfolio),
                              onEdit: () => _edit(portfolio),
                              onShare: () => PortfolioActions.share(portfolio),
                              onPreview: () =>
                                  PortfolioActions.preview(portfolio),
                            ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

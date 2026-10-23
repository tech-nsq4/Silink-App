import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/di/injection.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/locale_keys.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/flow_top_bar.dart';
import '../../settings/presentation/widgets/settings_confirm_dialog.dart';
import '../data/models/portfolio_model.dart';
import '../logic/portfolios_cubit.dart';
import 'widgets/portfolio_action_bar.dart';
import 'widgets/portfolio_actions.dart';
import 'widgets/portfolio_dates_card.dart';
import 'widgets/portfolio_details_header.dart';
import 'widgets/portfolio_publish_card.dart';
import 'widgets/portfolio_status_switch.dart';

class PortfolioDetailsScreen extends StatefulWidget {
  const PortfolioDetailsScreen({super.key, required this.portfolio});

  final PortfolioModel portfolio;

  @override
  State<PortfolioDetailsScreen> createState() => _PortfolioDetailsScreenState();
}

class _PortfolioDetailsScreenState extends State<PortfolioDetailsScreen> {
  late final PortfoliosCubit _cubit = getIt<PortfoliosCubit>()
    ..seed([widget.portfolio]);
  bool _changed = false;

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  void _close() => Navigator.of(context).pop(_changed);

  Future<void> _toggle(PortfolioModel portfolio) async {
    _changed = true;
    await _cubit.toggleActive(portfolio);
  }

  Future<void> _delete(PortfolioModel portfolio) async {
    final confirmed = await SettingsConfirmDialog.show(
      context,
      title: LocaleKeys.portfolios_delete.tr(),
      message: LocaleKeys.portfolios_deleteConfirm.tr(),
    );
    if (!confirmed || !mounted) return;
    if (await _cubit.delete(portfolio) && mounted) {
      _changed = true;
      _close();
    }
  }

  Widget _textButton(String label, Color color, VoidCallback onTap) => Center(
        child: TextButton(
          onPressed: onTap,
          child: AppText(label,
              fontSize: 10.sp, fontWeight: FontWeight.w800, color: color),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _close();
      },
      child: BlocBuilder<PortfoliosCubit, PortfoliosState>(
        bloc: _cubit,
        builder: (context, state) {
          final portfolio =
              state is PortfoliosSuccess && state.portfolios.isNotEmpty
                  ? state.portfolios.first
                  : widget.portfolio;
          return Scaffold(
            backgroundColor: AppColors.backgroundColor.themeColor,
            body: Column(
              children: [
                SafeArea(
                  bottom: false,
                  child: FlowTopBar(
                    title: LocaleKeys.portfolios_detailsTitle.tr(),
                    onBack: _close,
                    action: GestureDetector(
                      onTap: () async {
                        await PortfolioActions.edit(portfolio);
                        _changed = true;
                      },
                      child: AppText(
                        LocaleKeys.portfolios_edit.tr(),
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w800,
                        color: AppColors.accentTeal.themeColor,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.fromLTRB(22.w, 8.h, 22.w, 28.h),
                    children: [
                      PortfolioDetailsHeader(portfolio: portfolio),
                      SizedBox(height: 12.h),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.white.themeColor,
                          borderRadius: BorderRadius.circular(18.r),
                          border: Border.all(
                              color: AppColors.studioPanelBorder.themeColor),
                        ),
                        child: PortfolioActionBar(
                          vertical: true,
                          actions: [
                            PortfolioAction(
                              icon: Icons.visibility_outlined,
                              label: LocaleKeys.portfolios_preview.tr(),
                              onTap: () => PortfolioActions.preview(portfolio),
                            ),
                            PortfolioAction(
                              icon: Icons.qr_code_2_rounded,
                              label: LocaleKeys.portfolios_qr.tr(),
                              onTap: () =>
                                  PortfolioActions.qr(context, portfolio),
                            ),
                            PortfolioAction(
                              icon: Icons.share_outlined,
                              label: LocaleKeys.portfolios_share.tr(),
                              onTap: () => PortfolioActions.share(portfolio),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 12.h),
                      PortfolioPublishCard(
                        portfolio: portfolio,
                        onCopy: () => PortfolioActions.copyLink(portfolio),
                      ),
                      SizedBox(height: 12.h),
                      PortfolioDatesCard(portfolio: portfolio),
                      SizedBox(height: 12.h),
                      PortfolioStatusSwitch(
                        isActive: portfolio.isActive,
                        busy: state is PortfoliosSuccess &&
                            state.busyId == portfolio.id,
                        onChanged: (_) => _toggle(portfolio),
                      ),
                      SizedBox(height: 8.h),
                      if (!portfolio.isPrimary)
                        _textButton(
                          LocaleKeys.portfolios_delete.tr(),
                          AppColors.errorColor.themeColor,
                          () => _delete(portfolio),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

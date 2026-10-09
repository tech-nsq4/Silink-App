import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/router/navigation_services.dart';
import '../../../app/router/routes.dart';
import '../../../core/di/injection.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_constants.dart';
import '../../../core/utils/convert_helper.dart';
import '../../../core/utils/locale_keys.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/digital_card_preview.dart';
import '../../../core/widgets/flow_page_title.dart';
import '../../clients/data/models/client_model.dart';
import '../../clients/logic/clients_cubit.dart';
import '../../profile/logic/profile_cubit.dart';
import '../../profile_card/logic/profile_card_cubit.dart';
import 'widgets/home_card_actions.dart';
import 'widgets/home_impact_stats.dart';
import 'widgets/home_new_card_banner.dart';
import 'widgets/home_recent_clients.dart';
import 'widgets/home_section_header.dart';
import 'widgets/home_status_badge.dart';
import 'widgets/home_top_bar.dart';
import 'widgets/store_banner.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.onOpenClients});

  final VoidCallback? onOpenClients;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const int _recentLimit = 3;

  late final ClientsCubit _clientsCubit = getIt<ClientsCubit>();
  late final ProfileCardCubit _cardCubit = getIt<ProfileCardCubit>();

  @override
  void initState() {
    super.initState();
    if (kIsGuest) return;
    _clientsCubit.getClients(silent: true);
    _cardCubit.getMyCard();
  }

  Future<void> _openAndRefresh(
    String route, {
    Map<String, dynamic>? arguments,
  }) async {
    await NavigationService.push(route, arguments: arguments);
    if (mounted && !kIsGuest && !_cardCubit.isClosed) _cardCubit.getMyCard();
  }

  @override
  void dispose() {
    _clientsCubit.close();
    _cardCubit.close();
    super.dispose();
  }

  String _initials(String name) {
    final words =
        name.trim().split(' ').where((word) => word.isNotEmpty).take(2);
    return words.map((word) => word.characters.first).join();
  }

  Future<void> _refresh() async {
    if (kIsGuest) return;
    await Future.wait([
      context.read<ProfileCubit>().getProfile(),
      _clientsCubit.getClients(silent: true),
      _cardCubit.getMyCard(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor.themeColor,
      body: Column(
        children: [
          const HomeTopBar(),
          Expanded(
            child: RefreshIndicator(
              color: AppColors.accentTeal.themeColor,
              onRefresh: _refresh,
              child: ListView(
                padding: EdgeInsets.fromLTRB(22.w, 6.h, 22.w, 24.h),
                children: [
                  FlowPageTitle(
                    eyebrow: LocaleKeys.homeHub_eyebrow.tr(),
                    title: LocaleKeys.homeHub_title.tr(),
                  ),
                  BlocBuilder<ProfileCubit, ProfileState>(
                    builder: (context, state) {
                      final user = state is ProfileSuccess ? state.user : null;
                      final name = user?.fullName.trim() ?? '';
                      final published = user?.status == 'active';
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          HomeSectionHeader(
                            title: LocaleKeys.homeHub_primaryCard.tr(),
                            trailing: HomeStatusBadge(
                              label: published
                                  ? LocaleKeys.homeHub_published.tr()
                                  : LocaleKeys.homeHub_draft.tr(),
                              active: published,
                            ),
                          ),
                          BlocBuilder<ProfileCardCubit, ProfileCardState>(
                            bloc: _cardCubit,
                            buildWhen: (_, current) =>
                                current is! ProfileCardLoading,
                            builder: (context, cardState) {
                              final card = cardState is ProfileCardSuccess
                                  ? cardState.card
                                  : null;
                              final basic = card?.basic;
                              final appearance = card?.appearance;
                              final cardName =
                                  basic == null || basic.fullName.trim().isEmpty
                                      ? name
                                      : basic.fullName.trim();
                              return GestureDetector(
                                onTap: () =>
                                    _openAndRefresh(Routes.profileCardScreen),
                                child: DigitalCardPreview(
                                  name: cardName,
                                  title:
                                      basic?.jobTitle ?? user?.jobTitle ?? '',
                                  company:
                                      basic?.company ?? user?.company ?? '',
                                  initials: _initials(cardName),
                                  photoUrl: basic?.photoUrl ?? user?.photoUrl,
                                  template:
                                      card == null || card.templateSlug.isEmpty
                                          ? 'pro'
                                          : card.templateSlug,
                                  accent: ConvertHelper.hexToColor(
                                    appearance?.primaryColor ?? '',
                                    fallback: AppColors.accentTeal.themeColor,
                                  ),
                                  buttonRadius: DigitalCardPreview.shapeRadii[
                                          appearance?.buttonShape] ??
                                      12,
                                  fontFamily: appearance == null ||
                                          appearance.fontFamily.isEmpty
                                      ? null
                                      : appearance.fontFamily,
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    },
                  ),
                  SizedBox(height: 14.h),
                  HomeCardActions(
                    actions: [
                      HomeCardAction(
                        icon: Icons.qr_code_2_rounded,
                        label: LocaleKeys.homeHub_share.tr(),
                        onTap: () => _openAndRefresh(Routes.profileCardScreen),
                      ),
                      HomeCardAction(
                        icon: Icons.edit_outlined,
                        label: LocaleKeys.homeHub_edit.tr(),
                        onTap: () => _openAndRefresh(
                          Routes.profileCardScreen,
                          arguments: {'viewOnly': true},
                        ),
                      ),
                      HomeCardAction(
                        icon: Icons.contactless_outlined,
                        label: LocaleKeys.homeHub_nfc.tr(),
                        onTap: () => NavigationService.push(Routes.companyNfc),
                      ),
                    ],
                  ),
                  SizedBox(height: 26.h),
                  BlocBuilder<ClientsCubit, ClientsState>(
                    bloc: _clientsCubit,
                    builder: (context, state) {
                      final clients = state is ClientsSuccess
                          ? state.clients
                          : const <ClientModel>[];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          HomeSectionHeader(
                            title: LocaleKeys.homeHub_impact.tr(),
                            large: true,
                            actionLabel: LocaleKeys.homeHub_details.tr(),
                            onAction: () =>
                                NavigationService.push(Routes.statisticsScreen),
                          ),
                          HomeImpactStats(
                            stats: [
                              ('0', LocaleKeys.homeHub_visits.tr()),
                              (
                                '${clients.length}',
                                LocaleKeys.homeHub_potential.tr()
                              ),
                              ('0', LocaleKeys.homeHub_saves.tr()),
                            ],
                          ),
                          SizedBox(height: 22.h),
                          HomeNewCardBanner(
                            title: LocaleKeys.homeHub_newCardTitle.tr(),
                            subtitle: LocaleKeys.homeHub_newCardSubtitle.tr(),
                            onTap: () => NavigationService.push(
                                Routes.newCardStartScreen),
                          ),
                          SizedBox(height: 26.h),
                          HomeSectionHeader(
                            title: LocaleKeys.homeHub_recent.tr(),
                            large: true,
                            trailing: GestureDetector(
                              onTap: widget.onOpenClients,
                              child: AppText(
                                LocaleKeys.homeHub_all.tr(),
                                fontSize: 9.sp,
                                fontWeight: FontWeight.w700,
                                color: AppColors.accentTeal.themeColor,
                              ),
                            ),
                          ),
                          HomeRecentClients(
                            clients: clients.take(_recentLimit).toList(),
                            emptyLabel: LocaleKeys.homeHub_recentEmpty.tr(),
                            onTap: (client) => NavigationService.push(
                              Routes.clientDetailsScreen,
                              arguments: {'client': client},
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  SizedBox(height: 22.h),
                  const StoreBanner(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

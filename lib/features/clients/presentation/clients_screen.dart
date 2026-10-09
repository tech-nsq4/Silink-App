import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/router/navigation_services.dart';
import '../../../app/router/routes.dart';
import '../../../core/di/injection.dart';
import '../../../core/extensions/extensions.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/locale_keys.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/flow_page_title.dart';
import '../../../core/widgets/flow_top_bar.dart';
import '../../../core/widgets/screen_state_layout.dart';
import '../data/models/client_category_model.dart';
import '../data/models/client_model.dart';
import '../logic/clients_cubit.dart';
import 'widgets/client_tile.dart';
import '../../../core/widgets/filter_chips_bar.dart';
import 'widgets/clients_stat_card.dart';

class ClientsScreen extends StatefulWidget {
  const ClientsScreen({super.key});

  @override
  State<ClientsScreen> createState() => _ClientsScreenState();
}

class _ClientsScreenState extends State<ClientsScreen> {
  late final ClientsCubit _cubit = getIt<ClientsCubit>()..getClients();
  final TextEditingController _searchController = TextEditingController();
  String? _selectedCategoryId;
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    _cubit.close();
    super.dispose();
  }

  List<ClientModel> _byCategory(List<ClientModel> clients) {
    final id = _selectedCategoryId;
    if (id == null) return clients;
    return clients.where((c) => c.categoryIds.contains(id)).toList();
  }

  List<ClientModel> _filtered(List<ClientModel> clients) {
    final q = _query.trim().toLowerCase();
    return _byCategory(clients).where((client) {
      return q.isEmpty ||
          client.name.toLowerCase().contains(q) ||
          client.mobile.contains(q) ||
          client.whatsapp.contains(q) ||
          client.email.toLowerCase().contains(q);
    }).toList();
  }

  Future<void> _openDetails(ClientModel client) async {
    final changed = await NavigationService.push(
      Routes.clientDetailsScreen,
      arguments: {'client': client},
    );
    if (changed == true && mounted) _cubit.getClients(silent: true);
  }

  Future<void> _addClient(List<ClientCategoryModel> categories) async {
    final result = await NavigationService.push(
      Routes.clientFormScreen,
      arguments: {'categories': categories},
    );
    if (result != null && mounted) _cubit.getClients(silent: true);
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() => _query = '');
  }

  List<Color> get _tints => [
        AppColors.accentTeal.themeColor,
        AppColors.accentBlue.themeColor,
        AppColors.purple.themeColor,
        AppColors.accentGold.themeColor,
      ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClientsCubit, ClientsState>(
      bloc: _cubit,
      builder: (context, state) {
        final success = state is ClientsSuccess ? state : null;
        final clients = success?.clients ?? const <ClientModel>[];
        final categories = success?.categories ?? const <ClientCategoryModel>[];
        final filtered = _filtered(clients);
        final pending =
            _cubit.pendingFollowUps(clients.map((client) => client.id));

        return Scaffold(
          backgroundColor: AppColors.backgroundColor.themeColor,
          floatingActionButton: success == null
              ? null
              : FloatingActionButton(
                  onPressed: () => _addClient(categories),
                  backgroundColor: AppColors.accentTeal.themeColor,
                  child: Icon(
                    Icons.person_add_alt_1_rounded,
                    color: AppColors.white.light,
                  ),
                ),
          body: Column(
            children: [
              FlowTopBar(
                eyebrow: LocaleKeys.clientsHub_headerEyebrow.tr(),
                title: LocaleKeys.clientsHub_headerTitle.tr(),
                showBack: false,
              ),
              Expanded(
                child: CustomScreenStateLayout(
                  isLoading: state is ClientsLoading || state is ClientsInitial,
                  error: state is ClientsError
                      ? ErrorModel(
                          code: ErrorEnum.otherError,
                          errorMessage: state.message,
                        )
                      : null,
                  onRetry: _cubit.getClients,
                  builder: (context) => RefreshIndicator(
                    color: AppColors.accentTeal.themeColor,
                    onRefresh: () => _cubit.getClients(silent: true),
                    child: ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      padding: EdgeInsets.fromLTRB(22.w, 6.h, 22.w, 90.h),
                      children: [
                        FlowPageTitle(
                          eyebrow: LocaleKeys.clientsHub_pageEyebrow.tr(),
                          title: LocaleKeys.clientsHub_pageTitle.tr(),
                          subtitle: LocaleKeys.clientsHub_pageSubtitle.tr(),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: ClientsStatCard(
                                value: clients.length,
                                label: LocaleKeys.clientsHub_statNetwork.tr(),
                              ),
                            ),
                            12.width,
                            Expanded(
                              child: ClientsStatCard(
                                value: pending,
                                label: LocaleKeys.clientsHub_statFollowUps.tr(),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.h),
                        CustomTextField(
                          controller: _searchController,
                          hint: LocaleKeys.clientsHub_searchHint.tr(),
                          onChanged: (value) => setState(() => _query = value),
                          prefixIcon: Icon(
                            Icons.search_rounded,
                            size: 19.sp,
                            color: AppColors.textSecondaryColor.themeColor,
                          ),
                          suffixIcon: _query.isEmpty
                              ? null
                              : GestureDetector(
                                  onTap: _clearSearch,
                                  child: Icon(
                                    Icons.close_rounded,
                                    size: 18.sp,
                                    color:
                                        AppColors.textSecondaryColor.themeColor,
                                  ),
                                ),
                          borderRadius: 14.r,
                          fillColor: AppColors.white.themeColor,
                          borderColor: AppColors.studioPanelBorder.themeColor,
                          focusedBorderColor: AppColors.accentTeal.themeColor,
                        ),
                        SizedBox(height: 14.h),
                        if (categories.isNotEmpty) ...[
                          FilterChipsBar<String>(
                            allLabel: LocaleKeys.clientsHub_all.tr(),
                            options: [for (final c in categories) c.id],
                            labelOf: (id) =>
                                categories.firstWhere((c) => c.id == id).name,
                            selected: _selectedCategoryId,
                            onSelected: (id) =>
                                setState(() => _selectedCategoryId = id),
                          ),
                          SizedBox(height: 18.h),
                        ],
                        if (filtered.isEmpty)
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 40.h),
                            child: AppText(
                              clients.isEmpty
                                  ? LocaleKeys.clientsHub_empty.tr()
                                  : LocaleKeys.clientsHub_noMatch.tr(),
                              fontSize: 10.sp,
                              textAlign: TextAlign.center,
                              color: AppColors.textSecondaryColor.themeColor,
                            ),
                          )
                        else
                          for (final (index, client) in filtered.indexed)
                            Padding(
                              padding: EdgeInsets.only(bottom: 10.h),
                              child: ClientTile(
                                client: client,
                                tint: _tints[index % _tints.length],
                                onTap: () => _openDetails(client),
                              ),
                            ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

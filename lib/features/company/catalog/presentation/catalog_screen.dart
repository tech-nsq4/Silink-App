import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/router/navigation_services.dart';
import '../../../../app/router/routes.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/flow_top_bar.dart';
import '../../../../core/widgets/screen_state_layout.dart';
import '../../../profile_completion/data/models/catalog_model.dart';
import '../../data/models/company_business_type.dart';
import '../data/catalog_item_draft.dart';
import '../logic/company_catalog_cubit.dart';
import '../widgets/catalog_hub_delete_dialog.dart';
import '../widgets/catalog_hub_group_header.dart';
import '../widgets/catalog_hub_row.dart';
import '../widgets/catalog_hub_section_label.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({
    super.key,
    this.businessType = CompanyBusinessType.restaurant,
    this.companyName,
    this.providerType,
    this.providerCity,
    this.editable = true,
  });

  final CompanyBusinessType businessType;
  final String? companyName;
  final String? providerType;
  final String? providerCity;
  final bool editable;

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  late final CompanyCatalogCubit _cubit = getIt<CompanyCatalogCubit>()..load();

  bool get _isMenu =>
      widget.businessType == CompanyBusinessType.restaurant ||
      widget.businessType == CompanyBusinessType.cafe;

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  Future<void> _openForm(
    CompanyCatalogSuccess state, {
    required String kind,
    CatalogItemModel? item,
  }) async {
    final draft = await NavigationService.push(
      Routes.companyCatalogForm,
      arguments: {
        'kind': kind,
        'item': item,
        'actionTypes': state.actionTypes,
        'section': item == null ? '' : state.sectionOf(item),
        'sectionOptions': state.sectionNames,
      },
    );
    if (draft is CatalogItemDraft && mounted) {
      await _cubit.save(draft, existing: item);
    }
  }

  Future<void> _delete(CatalogItemModel item) async {
    final confirmed = await CatalogHubDeleteDialog.show(context);
    if (confirmed && mounted) _cubit.delete(item);
  }

  Widget _row(CompanyCatalogSuccess state, CatalogItemModel item,
      List<CatalogItemModel> group) {
    if (!widget.editable) return CatalogHubRow(item: item);
    final index = group.indexOf(item);
    return CatalogHubRow(
      item: item,
      busy: state.busyId == item.id,
      onToggle: () => _cubit.toggleActive(item),
      onEdit: () => _openForm(state, kind: item.kind, item: item),
      onDelete: () => _delete(item),
      onMoveUp: index > 0 ? () => _cubit.move(item, -1) : null,
      onMoveDown: index < group.length - 1 ? () => _cubit.move(item, 1) : null,
    );
  }

  List<Widget> _itemsSection(CompanyCatalogSuccess state) {
    final all = state.ofKind(CompanyCatalogCubit.itemKind);
    final items = widget.editable ? all : all.where((i) => i.isActive).toList();
    final grouped = <String, List<CatalogItemModel>>{};
    for (final item in items) {
      grouped.putIfAbsent(state.sectionOf(item), () => []).add(item);
    }
    final named = grouped.keys.where((k) => k.isNotEmpty).toList();
    return [
      CatalogHubGroupHeader(
        title: LocaleKeys.catalogHub_items.tr(args: ['${items.length}']),
        actionLabel:
            widget.editable ? LocaleKeys.catalogHub_addItem.tr() : null,
        onAction: () => _openForm(state, kind: CompanyCatalogCubit.itemKind),
      ),
      for (final section in named) ...[
        CatalogHubSectionLabel(text: section),
        for (final item in grouped[section]!) _row(state, item, items),
      ],
      if (grouped[''] != null) ...[
        if (named.isNotEmpty)
          CatalogHubSectionLabel(text: LocaleKeys.catalogHub_otherSection.tr()),
        for (final item in grouped['']!) _row(state, item, items),
      ],
    ];
  }

  List<Widget> _offersSection(CompanyCatalogSuccess state) {
    final all = state.ofKind(CompanyCatalogCubit.offerKind);
    final offers =
        widget.editable ? all : all.where((i) => i.isActive).toList();
    if (!widget.editable && offers.isEmpty) return const [];
    return [
      SizedBox(height: 14.h),
      CatalogHubGroupHeader(
        title: LocaleKeys.catalogHub_offers.tr(args: ['${offers.length}']),
        actionLabel:
            widget.editable ? LocaleKeys.catalogHub_addOffer.tr() : null,
        highlighted: false,
        onAction: () => _openForm(state, kind: CompanyCatalogCubit.offerKind),
      ),
      for (final offer in offers) _row(state, offer, offers),
    ];
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
              eyebrow: widget.companyName,
              title: _isMenu
                  ? LocaleKeys.catalogHub_titleMenu.tr()
                  : LocaleKeys.catalogHub_titleCatalog.tr(),
            ),
          ),
          Expanded(
            child: BlocBuilder<CompanyCatalogCubit, CompanyCatalogState>(
              bloc: _cubit,
              builder: (context, state) => CustomScreenStateLayout(
                isLoading: state is CompanyCatalogInitial ||
                    state is CompanyCatalogLoading,
                error: state is CompanyCatalogError
                    ? ErrorModel(
                        code: ErrorEnum.otherError,
                        errorMessage: state.message,
                      )
                    : null,
                onRetry: _cubit.load,
                builder: (context) {
                  final ready = state as CompanyCatalogSuccess;
                  return RefreshIndicator(
                    color: AppColors.accentTeal.themeColor,
                    onRefresh: _cubit.load,
                    child: ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.fromLTRB(22.w, 4.h, 22.w, 28.h),
                      children: [
                        if (widget.editable)
                          Padding(
                            padding: EdgeInsets.only(bottom: 16.h),
                            child: AppText(
                              LocaleKeys.catalogHub_intro.tr(),
                              fontSize: 9.sp,
                              height: 1.7,
                              color: AppColors.textSecondaryColor.themeColor,
                            ),
                          ),
                        ..._itemsSection(ready),
                        ..._offersSection(ready),
                        if (!widget.editable && ready.items.isEmpty)
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 40.h),
                            child: AppText(
                              LocaleKeys.catalogHub_empty.tr(),
                              fontSize: 10.sp,
                              textAlign: TextAlign.center,
                              color: AppColors.textSecondaryColor.themeColor,
                            ),
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

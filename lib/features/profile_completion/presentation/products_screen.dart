import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/convert_helper.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:Silink/core/widgets/screen_state_layout.dart';
import 'package:Silink/features/profile_completion/data/models/catalog_model.dart';
import 'package:Silink/features/profile_completion/logic/profile_completion_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widgets/product_edit_sheet.dart';
import 'widgets/product_row_card.dart';
import 'widgets/profile_catalog_item_details.dart';

class ProductsStep extends StatefulWidget {
  const ProductsStep({super.key});

  @override
  State<ProductsStep> createState() => _ProductsStepState();
}

class _ProductsStepState extends State<ProductsStep> {
  String _selectedKind = 'product';
  final Map<String, List<String>> _order = {'product': [], 'service': []};
  final Set<String> _locallyOff = {};

  @override
  void initState() {
    super.initState();
    context.read<ProfileCompletionCubit>().loadCatalog();
  }

  List<CatalogItemModel> _orderedItems(List<CatalogItemModel> items) {
    final order = _order[_selectedKind]!;
    final ids = items.map((i) => i.id).toSet();
    final kept = order.where(ids.contains).toList();
    final knownIds = kept.toSet();
    kept.addAll(items.map((i) => i.id).where((id) => !knownIds.contains(id)));
    _order[_selectedKind] = kept;
    final byId = {for (final i in items) i.id: i};
    return kept.map((id) => byId[id]!).toList();
  }

  void _move(List<CatalogItemModel> ordered, int index, int delta) {
    setState(() {
      final order = List<String>.from(_order[_selectedKind]!);
      final from = order.indexOf(ordered[index].id);
      final to = from + delta;
      if (from == -1 || to < 0 || to >= order.length) return;
      final id = order.removeAt(from);
      order.insert(to, id);
      _order[_selectedKind] = order;
    });
  }

  String get _addTitle => _selectedKind == 'service'
      ? LocaleKeys.products_addServiceTitle.tr()
      : LocaleKeys.products_addTitle.tr();

  String _editTitle(String kind) => kind == 'service'
      ? LocaleKeys.products_editServiceTitle.tr()
      : LocaleKeys.products_editTitle.tr();

  Future<void> _addItem(CatalogModel catalog) async {
    final result = await showProductEditSheet(
      context,
      title: _addTitle,
      actionTypes: catalog.actionTypes,
      initialKind: _selectedKind,
    );
    if (result == null || !mounted) return;
    context.read<ProfileCompletionCubit>().addCatalogItem(
          kind: result.kind,
          name: result.name,
          description: result.description,
          priceLabel: result.priceLabel,
          price: result.price,
          actionType: result.actionType,
          actionUrl: result.actionUrl,
          image: result.image,
        );
  }

  Future<void> _editItem(CatalogModel catalog, CatalogItemModel item) async {
    final result = await showProductEditSheet(
      context,
      title: _editTitle(item.kind),
      actionTypes: catalog.actionTypes,
      initial: item,
    );
    if (result == null || !mounted) return;
    context.read<ProfileCompletionCubit>().updateCatalogItem(
          id: item.id,
          kind: result.kind,
          name: result.name,
          description: result.description,
          priceLabel: result.priceLabel,
          price: result.price,
          actionType: result.actionType,
          actionUrl: result.actionUrl,
          image: result.image,
        );
  }

  Future<void> _openItem(
    CatalogItemModel item, {
    required bool visible,
  }) async {
    await openProfileCatalogItemDetails(
      context,
      item,
      visible: visible,
    );
  }

  Future<void> _deleteItem(CatalogItemModel item) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: AppText(LocaleKeys.products_deleteConfirmTitle.tr()),
        content: AppText(LocaleKeys.products_deleteConfirmMessage.tr()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: AppText(LocaleKeys.common_cancel.tr()),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: AppText(
              LocaleKeys.common_delete.tr(),
              color: AppColors.errorColor.themeColor,
            ),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    context
        .read<ProfileCompletionCubit>()
        .deleteCatalogItem(id: item.id, kind: item.kind);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCompletionCubit, ProfileCompletionState>(
      builder: (context, state) {
        return CustomScreenStateLayout(
          isLoading: state.catalogLoading && state.catalog == null,
          error: state.catalogError != null
              ? ErrorModel(
                  code: ErrorEnum.otherError,
                  errorMessage: state.catalogError!,
                )
              : null,
          onRetry: () =>
              context.read<ProfileCompletionCubit>().loadCatalog(force: true),
          builder: (context) {
            final catalog = state.catalog;
            if (catalog == null) return const SizedBox.shrink();
            final cubit = context.read<ProfileCompletionCubit>();
            final items =
                catalog.items.where((i) => i.kind == _selectedKind).toList();
            final ordered = _orderedItems(items);

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 19.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    LocaleKeys.products_title.tr(),
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w800,
                  ),
                  4.height,
                  AppText(
                    LocaleKeys.products_subtitle.tr(),
                    fontSize: 14.sp,
                  ),
                  16.height,
                  for (final section in catalog.sections) ...[
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 14.w, vertical: 12.h),
                      margin: EdgeInsets.only(bottom: 10.h),
                      decoration: BoxDecoration(
                        color: AppColors.white.themeColor,
                        borderRadius: BorderRadius.circular(14.r),
                        border: Border.all(
                            color: AppColors.dividerColor.themeColor),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 36.w,
                            height: 36.w,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppColors.fieldFill,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Icon(
                              section.type == 'service'
                                  ? Icons.work_outline
                                  : Icons.inventory_2_outlined,
                              size: 18.sp,
                              color: AppColors.textSecondaryColor.themeColor,
                            ),
                          ),
                          10.width,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(
                                  section.label,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                                AppText(
                                  section.description,
                                  fontSize: 11.sp,
                                  color:
                                      AppColors.textSecondaryColor.themeColor,
                                ),
                              ],
                            ),
                          ),
                          Switch(
                            value: section.enabled,
                            onChanged: (v) {
                              cubit.toggleCatalogSection(section.type, v);
                              cubit.saveCatalogSettings();
                            },
                            activeThumbColor: AppColors.mint.themeColor,
                          ),
                        ],
                      ),
                    ),
                  ],
                  10.height,
                  Row(
                    children: [
                      Expanded(
                          child: _kindTab(
                              LocaleKeys.products_kindProduct.tr(), 'product')),
                      8.width,
                      Expanded(
                          child: _kindTab(
                              LocaleKeys.products_kindService.tr(), 'service')),
                    ],
                  ),
                  16.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: state.isSavingCatalogItem
                            ? null
                            : () => _addItem(catalog),
                        borderRadius: BorderRadius.circular(20.r),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 14.w, vertical: 8.h),
                          decoration: BoxDecoration(
                            color: AppColors.mint.themeColor
                                .withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.add,
                                  size: 16.sp,
                                  color: AppColors.mint.themeColor),
                              4.width,
                              AppText(
                                _addTitle,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w700,
                                color: AppColors.mint.themeColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                      AppText(
                        (_selectedKind == 'service'
                                ? LocaleKeys.products_serviceCountLabel
                                : LocaleKeys.products_countLabel)
                            .tr(namedArgs: {'count': items.length.toString()}),
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ],
                  ),
                  16.height,
                  if (items.isEmpty)
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 24.h),
                      child: Center(
                        child: AppText(
                          LocaleKeys.products_emptyHint.tr(),
                          fontSize: 13.sp,
                          color: AppColors.textSecondaryColor.themeColor,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  else
                    for (final entry in ordered.indexed)
                      ProductRowCard(
                        name: entry.$2.name,
                        priceLabel: entry.$2.priceLabel,
                        price: ConvertHelper.formatPriceWithCurrency(
                            entry.$2.price),
                        imageUrl: entry.$2.imageUrl,
                        enabled: !_locallyOff.contains(entry.$2.id),
                        canMoveUp: entry.$1 > 0,
                        canMoveDown: entry.$1 < ordered.length - 1,
                        isSaving: state.savingCatalogItemId == entry.$2.id,
                        onTap: () => _openItem(
                          entry.$2,
                          visible: !_locallyOff.contains(entry.$2.id),
                        ),
                        onToggle: (v) => setState(() => v
                            ? _locallyOff.remove(entry.$2.id)
                            : _locallyOff.add(entry.$2.id)),
                        onMoveUp: () => _move(ordered, entry.$1, -1),
                        onMoveDown: () => _move(ordered, entry.$1, 1),
                        onEdit: () => _editItem(catalog, entry.$2),
                        onDelete: () => _deleteItem(entry.$2),
                      ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _kindTab(String label, String kind) {
    final selected = _selectedKind == kind;
    return InkWell(
      onTap: () => setState(() => _selectedKind = kind),
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.primaryColor.themeColor
              : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Center(
          child: AppText(
            label,
            fontSize: 12.sp,
            fontWeight: FontWeight.w700,
            color:
                selected ? Colors.white : AppColors.textPrimaryColor.themeColor,
          ),
        ),
      ),
    );
  }
}

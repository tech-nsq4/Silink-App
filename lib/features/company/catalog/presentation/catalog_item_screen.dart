import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/app_overlay.dart';
import 'package:Silink/core/utils/helper_methods.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_button.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:Silink/features/company/data/models/company_catalog_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/catalog_item_action_bar.dart';
import '../widgets/catalog_item_details_content.dart';
import '../widgets/catalog_item_details_header.dart';
import '../widgets/catalog_item_form_sheet.dart';
import '../widgets/catalog_item_manage_button.dart';

class CatalogItemResult {
  const CatalogItemResult.updated(this.item) : deleted = false;

  const CatalogItemResult.deleted()
      : item = null,
        deleted = true;

  final CompanyCatalogItem? item;
  final bool deleted;
}

class CatalogItemScreen extends StatefulWidget {
  const CatalogItemScreen({
    super.key,
    required this.item,
    required this.categoryLabel,
    required this.categories,
    this.providerName,
    this.providerType,
    this.providerCity,
    this.editable = true,
  });

  final CompanyCatalogItem item;
  final String categoryLabel;
  final List<CompanyCatalogCategory> categories;
  final String? providerName;
  final String? providerType;
  final String? providerCity;
  final bool editable;

  @override
  State<CatalogItemScreen> createState() => _CatalogItemScreenState();
}

class _CatalogItemScreenState extends State<CatalogItemScreen> {
  late CompanyCatalogItem _item = widget.item;

  CompanyCatalogCategory? get _category {
    for (final category in widget.categories) {
      if (category.id == _item.categoryId) return category;
    }
    return widget.categories.isEmpty ? null : widget.categories.first;
  }

  Future<void> _edit() async {
    final category = _category;
    if (category == null) return;
    final result = await showCatalogItemFormSheet(
      context,
      title: LocaleKeys.company_edit_item_title.tr(),
      categories: widget.categories,
      initialCategory: category,
      initial: _item,
    );
    if (result == null || !mounted) return;
    setState(() => _item = result);
    AppOverlay.showSuccess(LocaleKeys.company_item_updated.tr());
  }

  void _toggleVisible() {
    setState(() => _item = _item.copyWith(visible: !_item.visible));
    AppOverlay.showSuccess(LocaleKeys.company_item_updated.tr());
  }

  void _close() {
    Navigator.of(context).pop(
      CatalogItemResult.updated(_item),
    );
  }

  void _delete() {
    AppOverlay.showSuccess(LocaleKeys.company_item_deleted.tr());
    Navigator.of(context).pop(const CatalogItemResult.deleted());
  }

  Future<void> _order() async {
    final actionUrl = _item.actionUrl.trim();
    if (actionUrl.isEmpty) {
      AppOverlay.showSuccess(LocaleKeys.company_add_to_order.tr());
      return;
    }
    try {
      await HelperMethods.openLink(actionUrl);
    } catch (_) {
      if (mounted) {
        AppOverlay.showError(LocaleKeys.common_somethingWentWrong.tr());
      }
    }
  }

  void _handleAction(CompanyCatalogItemAction action) {
    switch (action) {
      case CompanyCatalogItemAction.edit:
        _edit();
      case CompanyCatalogItemAction.toggleVisibility:
        _toggleVisible();
      case CompanyCatalogItemAction.delete:
        _confirmDelete();
    }
  }

  @override
  Widget build(BuildContext context) {
    final category = _category;
    final title = category?.id == 'service'
        ? LocaleKeys.company_service_details_title.tr()
        : LocaleKeys.company_item_details_title.tr();
    return Scaffold(
      body: Column(
        children: [
          CatalogItemDetailsHeader(
            title: title,
            onBack: _close,
            onClose: _close,
            action: widget.editable
                ? CatalogItemManageButton(
                    visible: _item.visible,
                    onSelected: _handleAction,
                  )
                : null,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: CatalogItemDetailsContent(
                item: _item,
                category: category,
                providerName: widget.providerName,
                providerType: widget.providerType,
                providerCity: widget.providerCity,
                showHiddenBadge: widget.editable,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CatalogItemActionBar(
        label: LocaleKeys.company_order_now.tr(),
        onPressed: _order,
      ),
    );
  }

  Future<void> _confirmDelete() async {
    final shouldDelete = await showModalBottomSheet<bool>(
      context: context,
      backgroundColor: AppColors.cardColor.themeColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (sheetContext) => Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppText(
              LocaleKeys.company_delete_item.tr(),
              fontSize: 17.sp,
              fontWeight: FontWeight.w800,
            ),
            20.height,
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    onTap: () => Navigator.of(sheetContext).pop(false),
                    title: LocaleKeys.company_cancel.tr(),
                    isOutlined: true,
                    color: Colors.transparent,
                    borderColor: AppColors.borderColor.themeColor,
                    textColor: AppColors.textPrimaryColor.themeColor,
                    height: 44,
                    radius: 12,
                    fontSize: 13,
                  ),
                ),
                12.width,
                Expanded(
                  child: CustomButton(
                    onTap: () => Navigator.of(sheetContext).pop(true),
                    title: LocaleKeys.company_delete_item.tr(),
                    color: AppColors.errorColor.themeColor,
                    borderColor: AppColors.errorColor.themeColor,
                    height: 44,
                    radius: 12,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
    if (shouldDelete == true) _delete();
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:Silink/app/router/navigation_services.dart';
import 'package:Silink/app/router/routes.dart';
import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_constants.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/app_overlay.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:Silink/features/company/data/models/company_business_type.dart';
import 'package:Silink/features/company/data/models/company_catalog_item.dart';

import '../widgets/catalog_category_chips.dart';
import '../widgets/catalog_header.dart';
import '../widgets/catalog_item_card.dart';
import '../widgets/catalog_item_form_sheet.dart';
import 'catalog_item_screen.dart';

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
  late final CompanyCatalogData _data = CompanyCatalogData.sampleFor(
    widget.businessType,
    companyName: widget.companyName,
  );
  late final List<CompanyCatalogItem> _items = [..._data.items];
  String? _selectedCategoryId;

  List<CompanyCatalogItem> get _visibleItems => _selectedCategoryId == null
      ? _items
      : _items
          .where((item) => item.categoryId == _selectedCategoryId)
          .toList(growable: false);

  String get _providerType {
    final providedType = widget.providerType?.trim();
    if (providedType != null && providedType.isNotEmpty) return providedType;
    return switch (widget.businessType) {
      CompanyBusinessType.restaurant ||
      CompanyBusinessType.cafe => LocaleKeys.company_ind_food.tr(),
      CompanyBusinessType.clinic => LocaleKeys.company_business_clinic.tr(),
      CompanyBusinessType.mall => LocaleKeys.company_business_mall.tr(),
      CompanyBusinessType.other => LocaleKeys.company_business_other.tr(),
    };
  }

  CompanyCatalogCategory _categoryOf(CompanyCatalogItem item) =>
      _data.categoryById(item.categoryId) ?? _data.categories.first;

  Future<void> _addItem(CompanyCatalogCategory category) async {
    final result = await showCatalogItemFormSheet(
      context,
      title: LocaleKeys.company_add_item_title.tr(),
      categories: _data.categories,
      initialCategory: category,
    );
    if (result == null || !mounted) return;
    setState(() {
      _items.add(
        result.copyWith(id: 'item-${DateTime.now().microsecondsSinceEpoch}'),
      );
    });
    AppOverlay.showSuccess(LocaleKeys.products_itemSaved.tr());
  }

  void _onAddTap(CompanyCatalogItem item) {
    if (widget.editable) {
      _addItem(_categoryOf(item));
      return;
    }
    AppOverlay.showSuccess(LocaleKeys.company_add_to_order.tr());
  }

  Future<void> _openItem(CompanyCatalogItem item) async {
    final category = _categoryOf(item);
    final result = await NavigationService.push(
      Routes.companyCatalogItem,
      arguments: {
        'item': item,
        'categoryLabel': category.labelKey.tr(),
        'categories': _data.categories,
        'providerName': _data.companyName,
        'providerType': _providerType,
        'providerCity': widget.providerCity,
        'editable': widget.editable,
      },
    );
    if (result is! CatalogItemResult || !mounted) return;
    final index = _items.indexWhere((current) => current.id == item.id);
    if (index == -1) return;
    setState(() {
      if (result.deleted) {
        _items.removeAt(index);
      } else if (result.item != null) {
        _items[index] = result.item!;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final items = _visibleItems;
    return Scaffold(
      body: Column(
        children: [
          CatalogHeader(
            title: _data.mode.titleKey.tr(),
            subtitle: _data.companyName,
            titleIcon: _data.mode.titleIcon,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 19.w),
                    child: CatalogCategoryChips(
                      categories: _data.categories,
                      selectedId: _selectedCategoryId,
                      onSelected: (id) => setState(
                        () => _selectedCategoryId = id,
                      ),
                    ),
                  ),
                  16.height,
                  if (items.isEmpty) _emptyView() else _grid(items),
                  24.height,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _grid(List<CompanyCatalogItem> items) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 19.w),
      itemCount: items.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: AppConstants.catalogGridColumns,
        mainAxisSpacing: 16.h,
        crossAxisSpacing: 12.w,
        childAspectRatio: AppConstants.catalogGridAspectRatio,
      ),
      itemBuilder: (context, index) {
        final item = items[index];
        return CatalogItemCard(
          item: item,
          category: _categoryOf(item),
          showHiddenBadge: widget.editable,
          onTap: () => _openItem(item),
          onAdd: () => _onAddTap(item),
        );
      },
    );
  }

  Widget _emptyView() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 19.w),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 28.h),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.cardColor.themeColor,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColors.borderColor.themeColor),
        ),
        child: AppText(
          LocaleKeys.company_catalog_empty.tr(),
          fontSize: 13.sp,
          color: AppColors.textSecondaryColor.themeColor,
        ),
      ),
    );
  }
}

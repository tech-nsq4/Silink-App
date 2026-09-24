import 'package:Silink/app/router/navigation_services.dart';
import 'package:Silink/app/router/routes.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/features/company/data/models/company_catalog_item.dart';
import 'package:Silink/features/profile_completion/data/models/catalog_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

const profileCatalogDetailsCategories = <CompanyCatalogCategory>[
  CompanyCatalogCategory(
    id: 'product',
    labelKey: 'company.products_section',
    icon: Icons.inventory_2_outlined,
    gradientValues: [0xFF3FA299, 0xFF1F8A70],
  ),
  CompanyCatalogCategory(
    id: 'service',
    labelKey: 'company.services_section',
    icon: Icons.miscellaneous_services_outlined,
    gradientValues: [0xFF2563EB, 0xFF1B5583],
  ),
];

CompanyCatalogItem profileCatalogItemToDetailsItem(
  CatalogItemModel item, {
  bool visible = true,
}) {
  return CompanyCatalogItem(
    id: item.id,
    name: item.name,
    categoryId: item.kind,
    description: item.description,
    price: item.price,
    priceLabel: item.priceLabel,
    actionType: item.actionType,
    actionUrl: item.actionUrl,
    imageUrl: item.imageUrl,
    visible: visible,
  );
}

Future<dynamic> openProfileCatalogItemDetails(
  BuildContext context,
  CatalogItemModel item, {
  required bool visible,
}) {
  return NavigationService.push(
    Routes.companyCatalogItem,
    arguments: {
      'item': profileCatalogItemToDetailsItem(item, visible: visible),
      'categoryLabel': item.kind == 'service'
          ? LocaleKeys.company_services_section.tr()
          : LocaleKeys.company_products_section.tr(),
      'categories': profileCatalogDetailsCategories,
      'editable': false,
    },
  );
}

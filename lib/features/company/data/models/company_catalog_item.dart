import 'package:Silink/core/utils/locale_keys.dart';
import 'package:flutter/material.dart';

import 'company_business_type.dart';

enum CompanyCatalogMode { menu, catalog }

extension CompanyCatalogModeX on CompanyCatalogMode {
  bool get isMenu => this == CompanyCatalogMode.menu;

  String get titleKey =>
      isMenu ? LocaleKeys.company_menu_title : LocaleKeys.company_catalog_title;

  IconData get titleIcon =>
      isMenu ? Icons.restaurant_menu_rounded : Icons.grid_view_rounded;
}

extension CompanyBusinessTypeCatalogX on CompanyBusinessType {
  CompanyCatalogMode get catalogMode =>
      this == CompanyBusinessType.restaurant || this == CompanyBusinessType.cafe
          ? CompanyCatalogMode.menu
          : CompanyCatalogMode.catalog;
}

class CompanyCatalogCategory {
  const CompanyCatalogCategory({
    required this.id,
    required this.labelKey,
    required this.icon,
    required this.gradientValues,
  });

  final String id;
  final String labelKey;
  final IconData icon;
  final List<int> gradientValues;

  List<Color> get gradient =>
      gradientValues.map(Color.new).toList(growable: false);
}

class CompanyCatalogItem {
  const CompanyCatalogItem({
    required this.id,
    required this.name,
    required this.categoryId,
    this.description = '',
    this.price = '',
    this.priceLabel = '',
    this.actionType = '',
    this.actionUrl = '',
    this.imageUrl,
    this.visible = true,
  });

  final String id;
  final String name;
  final String categoryId;
  final String description;
  final String price;
  final String priceLabel;
  final String actionType;
  final String actionUrl;
  final String? imageUrl;
  final bool visible;

  CompanyCatalogItem copyWith({
    String? id,
    String? name,
    String? categoryId,
    String? description,
    String? price,
    String? priceLabel,
    String? actionType,
    String? actionUrl,
    String? imageUrl,
    bool? visible,
  }) =>
      CompanyCatalogItem(
        id: id ?? this.id,
        name: name ?? this.name,
        categoryId: categoryId ?? this.categoryId,
        description: description ?? this.description,
        price: price ?? this.price,
        priceLabel: priceLabel ?? this.priceLabel,
        actionType: actionType ?? this.actionType,
        actionUrl: actionUrl ?? this.actionUrl,
        imageUrl: imageUrl ?? this.imageUrl,
        visible: visible ?? this.visible,
      );
}

class CompanyCatalogData {
  const CompanyCatalogData({
    required this.mode,
    required this.companyName,
    required this.categories,
    required this.items,
  });

  final CompanyCatalogMode mode;
  final String companyName;
  final List<CompanyCatalogCategory> categories;
  final List<CompanyCatalogItem> items;

  List<CompanyCatalogItem> itemsOf(String? categoryId) => categoryId == null
      ? items
      : items
          .where((item) => item.categoryId == categoryId)
          .toList(growable: false);

  CompanyCatalogCategory? categoryById(String? id) {
    for (final category in categories) {
      if (category.id == id) return category;
    }
    return null;
  }

  static CompanyCatalogData _menuSample(String companyName) =>
      CompanyCatalogData(
        mode: CompanyCatalogMode.menu,
        companyName: companyName,
        categories: const [
          CompanyCatalogCategory(
            id: 'drinks',
            labelKey: 'company.menu_cat_drinks',
            icon: Icons.local_cafe_outlined,
            gradientValues: [0xFF9C6644, 0xFF58351F],
          ),
          CompanyCatalogCategory(
            id: 'main',
            labelKey: 'company.menu_cat_main',
            icon: Icons.dinner_dining_outlined,
            gradientValues: [0xFFD9822B, 0xFF8A4B12],
          ),
          CompanyCatalogCategory(
            id: 'appetizers',
            labelKey: 'company.menu_cat_appetizers',
            icon: Icons.lunch_dining_outlined,
            gradientValues: [0xFF6A994E, 0xFF386641],
          ),
        ],
        items: const [
          CompanyCatalogItem(
            id: 'menu-1',
            name: 'شاي أحمر بالنعناع',
            categoryId: 'drinks',
            description: 'شاي أحمر طازج مع أوراق النعناع',
            price: '10',
          ),
          CompanyCatalogItem(
            id: 'menu-2',
            name: 'قهوة عربية',
            categoryId: 'drinks',
            description: 'قهوة عربية بالهيل والزعفران',
            price: '12',
          ),
          CompanyCatalogItem(
            id: 'menu-3',
            name: 'مندي لحم',
            categoryId: 'main',
            description: 'مندي لحم طازج مع الأرز البسمتي',
            price: '65',
          ),
          CompanyCatalogItem(
            id: 'menu-4',
            name: 'كبسة دجاج',
            categoryId: 'main',
            description: 'كبسة دجاج بالبهارات السعودية',
            price: '48',
          ),
          CompanyCatalogItem(
            id: 'menu-5',
            name: 'فتوش',
            categoryId: 'appetizers',
            description: 'سلطة فتوش بالخضار الطازجة والخبز المحمص',
            price: '24',
          ),
          CompanyCatalogItem(
            id: 'menu-6',
            name: 'حمص بالطحينة',
            categoryId: 'appetizers',
            description: 'حمص كريمي مع الطحينة وزيت الزيتون',
            price: '18',
          ),
        ],
      );

  static CompanyCatalogData _catalogSample(String companyName) =>
      CompanyCatalogData(
        mode: CompanyCatalogMode.catalog,
        companyName: companyName,
        categories: const [
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
        ],
        items: const [
          CompanyCatalogItem(
            id: 'catalog-1',
            name: 'استشارة أعمال',
            categoryId: 'service',
            description: 'جلسة استشارية مدتها ٤٥ دقيقة',
            price: '500',
            priceLabel: 'يبدأ من',
          ),
          CompanyCatalogItem(
            id: 'catalog-2',
            name: 'باقة التسويق الرقمي',
            categoryId: 'product',
            price: '2,400',
            priceLabel: 'يبدأ من',
          ),
        ],
      );

  static CompanyCatalogData sampleFor(
    CompanyBusinessType businessType, {
    String? companyName,
  }) {
    final name = companyName?.trim().isNotEmpty == true
        ? companyName!.trim()
        : 'مطعم دار الضيافة';
    return businessType.catalogMode.isMenu
        ? _menuSample(name)
        : _catalogSample(name);
  }
}

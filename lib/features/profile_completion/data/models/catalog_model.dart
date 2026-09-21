import 'package:equatable/equatable.dart';

class CatalogSectionToggle extends Equatable {
  final String type;
  final String label;
  final String description;
  final bool enabled;

  const CatalogSectionToggle({
    required this.type,
    required this.label,
    required this.description,
    required this.enabled,
  });

  factory CatalogSectionToggle.fromJson(Map<String, dynamic> json) =>
      CatalogSectionToggle(
        type: json['type'] as String? ?? '',
        label: json['label'] as String? ?? '',
        description: json['description'] as String? ?? '',
        enabled: json['enabled'] as bool? ?? false,
      );

  CatalogSectionToggle copyWith({bool? enabled}) => CatalogSectionToggle(
        type: type,
        label: label,
        description: description,
        enabled: enabled ?? this.enabled,
      );

  @override
  List<Object?> get props => [type, label, description, enabled];
}

class CatalogActionType extends Equatable {
  final String type;
  final String label;

  const CatalogActionType({required this.type, required this.label});

  factory CatalogActionType.fromJson(Map<String, dynamic> json) =>
      CatalogActionType(
        type: json['type'] as String? ?? '',
        label: json['label'] as String? ?? '',
      );

  @override
  List<Object?> get props => [type, label];
}

class CatalogItemModel extends Equatable {
  final String id;
  final String kind;
  final String name;
  final String description;
  final String priceLabel;
  final String price;
  final String actionType;
  final String actionUrl;
  final String? imageUrl;

  const CatalogItemModel({
    required this.id,
    required this.kind,
    required this.name,
    required this.description,
    required this.priceLabel,
    required this.price,
    required this.actionType,
    required this.actionUrl,
    this.imageUrl,
  });

  factory CatalogItemModel.fromJson(Map<String, dynamic> json) =>
      CatalogItemModel(
        id: json['id']?.toString() ?? '',
        kind: json['kind'] as String? ?? 'product',
        name: json['name'] as String? ?? '',
        description: json['description'] as String? ?? '',
        priceLabel: json['priceLabel'] as String? ?? '',
        price: json['price']?.toString() ?? '',
        actionType: json['actionType'] as String? ?? '',
        actionUrl: json['actionUrl'] as String? ?? '',
        imageUrl: json['imageUrl'] as String? ?? json['image'] as String?,
      );

  @override
  List<Object?> get props => [
        id,
        kind,
        name,
        description,
        priceLabel,
        price,
        actionType,
        actionUrl,
        imageUrl,
      ];
}

class CatalogModel extends Equatable {
  final bool productsEnabled;
  final bool servicesEnabled;
  final List<CatalogSectionToggle> sections;
  final List<CatalogActionType> actionTypes;
  final List<CatalogItemModel> items;

  const CatalogModel({
    required this.productsEnabled,
    required this.servicesEnabled,
    required this.sections,
    required this.actionTypes,
    required this.items,
  });

  factory CatalogModel.fromJson(Map<String, dynamic> json) => CatalogModel(
        productsEnabled: json['productsEnabled'] as bool? ?? false,
        servicesEnabled: json['servicesEnabled'] as bool? ?? false,
        sections: (json['sections'] as List<dynamic>? ?? [])
            .map((e) => CatalogSectionToggle.fromJson(e as Map<String, dynamic>))
            .toList(),
        actionTypes: (json['actionTypes'] as List<dynamic>? ?? [])
            .map((e) => CatalogActionType.fromJson(e as Map<String, dynamic>))
            .toList(),
        items: (json['items'] as List<dynamic>? ?? [])
            .map((e) => CatalogItemModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  CatalogModel copyWith({
    bool? productsEnabled,
    bool? servicesEnabled,
    List<CatalogSectionToggle>? sections,
    List<CatalogActionType>? actionTypes,
    List<CatalogItemModel>? items,
  }) =>
      CatalogModel(
        productsEnabled: productsEnabled ?? this.productsEnabled,
        servicesEnabled: servicesEnabled ?? this.servicesEnabled,
        sections: sections ?? this.sections,
        actionTypes: actionTypes ?? this.actionTypes,
        items: items ?? this.items,
      );

  @override
  List<Object?> get props =>
      [productsEnabled, servicesEnabled, sections, actionTypes, items];
}

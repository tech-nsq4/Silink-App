import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/locale_keys.dart';

enum ProductBadge { none, specialOffer, bestSeller }

extension ProductBadgeX on ProductBadge {
  String get value => switch (this) {
        ProductBadge.none => 'none',
        ProductBadge.specialOffer => 'special_offer',
        ProductBadge.bestSeller => 'best_seller',
      };

  String get labelKey => switch (this) {
        ProductBadge.specialOffer => LocaleKeys.store_special_offer,
        ProductBadge.bestSeller => LocaleKeys.store_badge_best_seller,
        ProductBadge.none => '',
      };

  static ProductBadge fromString(String value) => switch (value) {
        'special_offer' => ProductBadge.specialOffer,
        'best_seller' => ProductBadge.bestSeller,
        _ => ProductBadge.none,
      };
}

enum ProductCategory { nfcCards, metalCards, phoneStickers }

extension ProductCategoryX on ProductCategory {
  String get value => switch (this) {
        ProductCategory.nfcCards => 'nfc_cards',
        ProductCategory.metalCards => 'metal_cards',
        ProductCategory.phoneStickers => 'phone_stickers',
      };

  String get labelKey => switch (this) {
        ProductCategory.nfcCards => LocaleKeys.store_category_nfc,
        ProductCategory.metalCards => LocaleKeys.store_category_metal,
        ProductCategory.phoneStickers => LocaleKeys.store_category_stickers,
      };

  static ProductCategory fromString(String value) => switch (value) {
        'nfc_cards' => ProductCategory.nfcCards,
        'metal_cards' => ProductCategory.metalCards,
        'phone_stickers' => ProductCategory.phoneStickers,
        _ => ProductCategory.nfcCards,
      };
}

class Product extends Equatable {
  final String id;
  final String name;
  final String description;
  final ProductCategory category;
  final double price;
  final double? oldPrice;
  final double? rating;
  final int? reviewCount;
  final List<int> colorValues;
  final int defaultColorIndex;
  final List<String> colorLabelKeys;
  final bool customizable;
  final ProductBadge badge;
  final List<int> imageGradientValues;
  final String compatibility;
  final String deliveryTime;
  final List<String> packageContents;
  final double shippingCost;
  final double freeShippingThreshold;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    this.description = '',
    this.category = ProductCategory.nfcCards,
    this.oldPrice,
    this.rating,
    this.reviewCount,
    this.colorValues = const [],
    this.defaultColorIndex = 0,
    this.colorLabelKeys = const [],
    this.customizable = false,
    this.badge = ProductBadge.none,
    this.imageGradientValues = const [0xFFD8D8D8, 0xFFB8B8B8],
    this.compatibility = '',
    this.deliveryTime = '',
    this.packageContents = const [],
    this.shippingCost = AppConstants.defaultShippingCost,
    this.freeShippingThreshold = AppConstants.defaultFreeShippingThreshold,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['id'] as String,
        name: json['name'] as String,
        description: json['description'] as String? ?? '',
        category:
            ProductCategoryX.fromString(json['category'] as String? ?? ''),
        price: (json['price'] as num).toDouble(),
        oldPrice: (json['old_price'] as num?)?.toDouble(),
        rating: (json['rating'] as num?)?.toDouble(),
        reviewCount: json['review_count'] as int?,
        colorValues: _intList(json['colors']),
        defaultColorIndex: json['default_color_index'] as int? ?? 0,
        colorLabelKeys: _stringList(json['color_label_keys']),
        customizable: json['customizable'] as bool? ?? false,
        badge: ProductBadgeX.fromString(json['badge'] as String? ?? ''),
        imageGradientValues: _intList(json['image_gradient']),
        compatibility: json['compatibility'] as String? ?? '',
        deliveryTime: json['delivery_time'] as String? ?? '',
        packageContents: _stringList(json['package_contents']),
        shippingCost: (json['shipping_cost'] as num?)?.toDouble() ??
            AppConstants.defaultShippingCost,
        freeShippingThreshold:
            (json['free_shipping_threshold'] as num?)?.toDouble() ??
                AppConstants.defaultFreeShippingThreshold,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'category': category.value,
        'price': price,
        'old_price': oldPrice,
        'rating': rating,
        'review_count': reviewCount,
        'colors': colorValues,
        'default_color_index': defaultColorIndex,
        'color_label_keys': colorLabelKeys,
        'customizable': customizable,
        'badge': badge.value,
        'image_gradient': imageGradientValues,
        'compatibility': compatibility,
        'delivery_time': deliveryTime,
        'package_contents': packageContents,
        'shipping_cost': shippingCost,
        'free_shipping_threshold': freeShippingThreshold,
      };

  Product copyWith({double? shippingCost, double? freeShippingThreshold}) =>
      Product(
        id: id,
        name: name,
        description: description,
        category: category,
        price: price,
        oldPrice: oldPrice,
        rating: rating,
        reviewCount: reviewCount,
        colorValues: colorValues,
        defaultColorIndex: defaultColorIndex,
        colorLabelKeys: colorLabelKeys,
        customizable: customizable,
        badge: badge,
        imageGradientValues: imageGradientValues,
        compatibility: compatibility,
        deliveryTime: deliveryTime,
        packageContents: packageContents,
        shippingCost: shippingCost ?? this.shippingCost,
        freeShippingThreshold:
            freeShippingThreshold ?? this.freeShippingThreshold,
      );

  List<Color> get colors =>
      colorValues.map((value) => Color(value)).toList(growable: false);

  static const List<Color> fallbackGradient = [
    Color(0xFFD8D8D8),
    Color(0xFFB8B8B8),
  ];

  List<Color> get imageGradient =>
      imageGradientValues.map((value) => Color(value)).toList(growable: false);

  Color get defaultColor => colorAt(defaultColorIndex);

  Color colorAt(int index) => index >= 0 && index < colorValues.length
      ? Color(colorValues[index])
      : Colors.transparent;

  String colorLabelAt(int index) =>
      index >= 0 && index < colorLabelKeys.length ? colorLabelKeys[index] : '';

  bool get hasColors => colorValues.isNotEmpty;

  bool get hasRating => rating != null;

  bool get isDiscounted => oldPrice != null && oldPrice! > price;

  double totalFor(int quantity) => price * quantity;

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        category,
        price,
        oldPrice,
        rating,
        reviewCount,
        colorValues,
        defaultColorIndex,
        colorLabelKeys,
        customizable,
        badge,
        imageGradientValues,
        compatibility,
        deliveryTime,
        packageContents,
        shippingCost,
        freeShippingThreshold,
      ];

  static List<int> _intList(dynamic value) {
    if (value is! List) return const [];
    return value.whereType<num>().map((item) => item.toInt()).toList();
  }

  static List<String> _stringList(dynamic value) {
    if (value is! List) return const [];
    return value.whereType<String>().toList();
  }
}

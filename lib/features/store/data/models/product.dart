import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/convert_helper.dart';
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
}

class Product extends Equatable {
  final String id;
  final String name;
  final String image;
  final String description;
  final ProductCategory? category;
  final double price;
  final double? oldPrice;
  final double? rating;
  final int? reviewCount;
  final List<int> colorValues;
  final List<String?> colorImages;
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
    this.image = '',
    this.description = '',
    this.category,
    this.oldPrice,
    this.rating,
    this.reviewCount,
    this.colorValues = const [],
    this.colorImages = const [],
    this.defaultColorIndex = 0,
    this.colorLabelKeys = const [],
    this.customizable = false,
    this.badge = ProductBadge.none,
    this.imageGradientValues = const [],
    this.compatibility = '',
    this.deliveryTime = '',
    this.packageContents = const [],
    this.shippingCost = AppConstants.defaultShippingCost,
    this.freeShippingThreshold = AppConstants.defaultFreeShippingThreshold,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    final entries = parseColors(json['productColor']);
    final colors = [for (final entry in entries) entry.$1];

    return Product(
      id: json['id']?.toString() ?? '',
      name: json['name'] as String? ?? '',
      image: json['image'] as String? ?? '',
      description: json['description'] as String? ?? '',
      price: double.tryParse(json['price']?.toString() ?? '') ?? 0,
      category: ProductCategory.nfcCards,
      customizable: true,
      rating: double.tryParse(json['rating']?.toString() ?? '') ??
          AppConstants.defaultProductRating,
      reviewCount: int.tryParse(json['reviewCount']?.toString() ?? '') ??
          AppConstants.defaultProductReviewCount,
      colorValues: colors,
      colorImages: [for (final entry in entries) entry.$2],
      imageGradientValues: colors,
    );
  }

  static List<(int, String?)> parseColors(Object? raw) {
    if (raw is! List) return const [];
    return [
      for (final entry in raw)
        if (entry is String)
          (ConvertHelper.hexToColor(entry).toARGB32(), null)
        else if (entry is Map && entry['color'] is String)
          (
            ConvertHelper.hexToColor(entry['color'] as String).toARGB32(),
            (entry['image'] as String?)?.trim().isEmpty ?? true
                ? null
                : (entry['image'] as String).trim(),
          ),
    ];
  }

  List<String> get gallery => {
        if (hasImage) image,
        for (final colorImage in colorImages)
          if (colorImage != null) colorImage,
      }.toList();

  String imageForColor(int index) =>
      index >= 0 && index < colorImages.length && colorImages[index] != null
          ? colorImages[index]!
          : image;

  int? galleryIndexOfColor(int index) {
    final pages = gallery;
    final position = pages.indexOf(imageForColor(index));
    return position < 0 ? null : position;
  }

  int? colorIndexOfGallery(int page) {
    final pages = gallery;
    if (page < 0 || page >= pages.length) return null;
    final position = colorImages.indexOf(pages[page]);
    return position < 0 ? null : position;
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'image': image,
        'description': description,
        'price': price.toStringAsFixed(2),
        'productColor': [
          for (final (index, value) in colorValues.indexed)
            {
              'color': ConvertHelper.colorToHex(Color(value)),
              'image': index < colorImages.length ? colorImages[index] : null,
            },
        ],
      };

  static const List<Color> fallbackGradient = [
    Color(0xFFD8D8D8),
    Color(0xFFB8B8B8),
  ];

  List<Color> get colors =>
      colorValues.map((value) => Color(value)).toList(growable: false);

  List<Color> get imageGradient {
    if (imageGradientValues.isEmpty) return fallbackGradient;
    final gradient = imageGradientValues
        .map((value) => Color(value))
        .toList(growable: false);
    return gradient.length == 1 ? [gradient.first, gradient.first] : gradient;
  }

  Color get defaultColor => colorAt(defaultColorIndex);

  Color colorAt(int index) => index >= 0 && index < colorValues.length
      ? Color(colorValues[index])
      : Colors.transparent;

  String colorLabelAt(int index) =>
      index >= 0 && index < colorLabelKeys.length ? colorLabelKeys[index] : '';

  bool get hasColors => colorValues.isNotEmpty;

  bool get hasRating => rating != null;

  bool get hasImage => image.trim().isNotEmpty;

  bool get isDiscounted => oldPrice != null && oldPrice! > price;

  double totalFor(int quantity) => price * quantity;

  @override
  List<Object?> get props => [
        id,
        name,
        image,
        description,
        category,
        price,
        oldPrice,
        rating,
        reviewCount,
        colorValues,
        colorImages,
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
}

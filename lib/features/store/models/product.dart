import 'package:flutter/material.dart';

enum ProductBadge { none, specialOffer, bestSeller }

class Product {
  final String id;
  final String name;
  final double price;
  final double? oldPrice;
  final double? rating;
  final int? reviewCount;
  final List<Color> colorOptions;
  final int selectedColorIndex;
  final bool customizable;
  final ProductBadge badge;

  /// Placeholder gradient used instead of a real product photo.
  final List<Color> imageGradient;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    this.oldPrice,
    this.rating,
    this.reviewCount,
    this.colorOptions = const [],
    this.selectedColorIndex = 0,
    this.customizable = false,
    this.badge = ProductBadge.none,
    this.imageGradient = const [Color(0xFFD8D8D8), Color(0xFFB8B8B8)],
  });
}

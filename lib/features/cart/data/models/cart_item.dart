import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../store/data/models/product.dart';

class CartItem extends Equatable {
  final String productId;
  final String name;
  final String image;
  final double price;
  final int quantity;
  final int colorValue;
  final String colorLabelKey;
  final String summary;
  final List<int> imageGradientValues;

  const CartItem({
    required this.productId,
    required this.name,
    required this.price,
    this.image = '',
    this.quantity = 1,
    this.colorValue = 0,
    this.colorLabelKey = '',
    this.summary = '',
    this.imageGradientValues = const [],
  });

  factory CartItem.fromProduct(
    Product product, {
    int quantity = 1,
    int? colorIndex,
    String summary = '',
  }) {
    final index = colorIndex ?? product.defaultColorIndex;
    return CartItem(
      productId: product.id,
      name: product.name,
      image: product.image,
      price: product.price,
      quantity: quantity,
      colorValue: product.hasColors ? product.colorAt(index).toARGB32() : 0,
      colorLabelKey: product.colorLabelAt(index),
      summary: summary,
      imageGradientValues: product.imageGradientValues,
    );
  }

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        productId: json['product_id'] as String? ?? '',
        name: json['name'] as String? ?? '',
        image: json['image'] as String? ?? '',
        price: (json['price'] as num?)?.toDouble() ?? 0,
        quantity: (json['quantity'] as num?)?.toInt() ?? 1,
        colorValue: (json['color_value'] as num?)?.toInt() ?? 0,
        colorLabelKey: json['color_label_key'] as String? ?? '',
        summary: json['summary'] as String? ?? '',
        imageGradientValues: (json['image_gradient'] as List?)
                ?.whereType<num>()
                .map((value) => value.toInt())
                .toList(growable: false) ??
            const [],
      );

  Map<String, dynamic> toJson() => {
        'product_id': productId,
        'name': name,
        'image': image,
        'price': price,
        'quantity': quantity,
        'color_value': colorValue,
        'color_label_key': colorLabelKey,
        'summary': summary,
        'image_gradient': imageGradientValues,
      };

  double get total => price * quantity;

  bool get hasColor => colorValue != 0;

  List<Color> get imageGradient {
    if (imageGradientValues.isEmpty) return Product.fallbackGradient;
    final gradient = imageGradientValues
        .map((value) => Color(value))
        .toList(growable: false);
    return gradient.length == 1 ? [gradient.first, gradient.first] : gradient;
  }

  bool isSameAs(CartItem other) =>
      productId == other.productId &&
      colorValue == other.colorValue &&
      summary == other.summary;

  CartItem copyWith({int? quantity}) => CartItem(
        productId: productId,
        name: name,
        image: image,
        price: price,
        quantity: quantity ?? this.quantity,
        colorValue: colorValue,
        colorLabelKey: colorLabelKey,
        summary: summary,
        imageGradientValues: imageGradientValues,
      );

  @override
  List<Object?> get props => [
        productId,
        name,
        image,
        price,
        quantity,
        colorValue,
        colorLabelKey,
        summary,
        imageGradientValues,
      ];
}

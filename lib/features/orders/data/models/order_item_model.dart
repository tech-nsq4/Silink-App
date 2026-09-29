import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/convert_helper.dart';
import '../../../store/data/models/product.dart';

class OrderItemModel extends Equatable {
  final String productId;
  final String name;
  final String image;
  final List<int> colorValues;
  final int quantity;
  final double price;
  final double lineTotal;

  const OrderItemModel({
    required this.productId,
    required this.name,
    this.image = '',
    this.colorValues = const [],
    this.quantity = 1,
    this.price = 0,
    this.lineTotal = 0,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    final quantity = int.tryParse(json['quantity']?.toString() ?? '') ?? 1;
    final price = double.tryParse(json['price']?.toString() ?? '') ?? 0;

    return OrderItemModel(
      productId: json['productId']?.toString() ?? '',
      name: json['name'] as String? ?? '',
      image: json['image'] as String? ?? '',
      colorValues: (json['productColor'] as List?)
              ?.whereType<String>()
              .map((hex) => ConvertHelper.hexToColor(hex).toARGB32())
              .toList(growable: false) ??
          const [],
      quantity: quantity,
      price: price,
      lineTotal: double.tryParse(json['lineTotal']?.toString() ?? '') ??
          price * quantity,
    );
  }

  Map<String, dynamic> toJson() => {
        'productId': productId,
        'name': name,
        'image': image,
        'productColor': colorValues
            .map((value) => ConvertHelper.colorToHex(Color(value)))
            .toList(growable: false),
        'quantity': quantity,
        'price': price.toStringAsFixed(2),
        'lineTotal': lineTotal.toStringAsFixed(2),
      };

  List<Color> get imageGradient {
    if (colorValues.isEmpty) return Product.fallbackGradient;
    final gradient =
        colorValues.map((value) => Color(value)).toList(growable: false);
    return gradient.length == 1 ? [gradient.first, gradient.first] : gradient;
  }

  @override
  List<Object?> get props =>
      [productId, name, image, colorValues, quantity, price, lineTotal];
}

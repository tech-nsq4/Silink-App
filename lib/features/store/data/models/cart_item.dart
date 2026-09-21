import 'package:equatable/equatable.dart';

class CartItem extends Equatable {
  final String productId;
  final String name;
  final double price;
  final int quantity;
  final int colorValue;
  final String colorLabelKey;
  final String summary;

  const CartItem({
    required this.productId,
    required this.name,
    required this.price,
    this.quantity = 1,
    this.colorValue = 0,
    this.colorLabelKey = '',
    this.summary = '',
  });

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        productId: json['product_id'] as String,
        name: json['name'] as String,
        price: (json['price'] as num).toDouble(),
        quantity: json['quantity'] as int? ?? 1,
        colorValue: json['color_value'] as int? ?? 0,
        colorLabelKey: json['color_label_key'] as String? ?? '',
        summary: json['summary'] as String? ?? '',
      );

  Map<String, dynamic> toJson() => {
        'product_id': productId,
        'name': name,
        'price': price,
        'quantity': quantity,
        'color_value': colorValue,
        'color_label_key': colorLabelKey,
        'summary': summary,
      };

  CartItem copyWith({int? quantity, String? summary}) => CartItem(
        productId: productId,
        name: name,
        price: price,
        quantity: quantity ?? this.quantity,
        colorValue: colorValue,
        colorLabelKey: colorLabelKey,
        summary: summary ?? this.summary,
      );

  double get total => price * quantity;

  bool matches(String id, int color) => productId == id && colorValue == color;

  @override
  List<Object?> get props => [
        productId,
        name,
        price,
        quantity,
        colorValue,
        colorLabelKey,
        summary,
      ];
}

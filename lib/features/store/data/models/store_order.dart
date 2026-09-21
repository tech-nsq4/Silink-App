import 'package:equatable/equatable.dart';

import 'cart_item.dart';
import 'payment_method.dart';
import 'shipping_address.dart';

class StoreOrder extends Equatable {
  final String number;
  final String createdAt;
  final PaymentMethod paymentMethod;
  final ShippingAddress address;
  final List<CartItem> items;
  final double subtotal;
  final double shipping;
  final double total;

  const StoreOrder({
    required this.number,
    required this.createdAt,
    required this.paymentMethod,
    required this.address,
    required this.items,
    this.subtotal = 0,
    this.shipping = 0,
    this.total = 0,
  });

  factory StoreOrder.fromJson(Map<String, dynamic> json) => StoreOrder(
        number: json['number'] as String? ?? '',
        createdAt: json['created_at'] as String? ?? '',
        paymentMethod:
            PaymentMethodX.fromString(json['payment_method'] as String? ?? ''),
        address: ShippingAddress.fromJson(
          (json['address'] as Map?)?.cast<String, dynamic>() ?? const {},
        ),
        items: ((json['items'] as List?) ?? const [])
            .whereType<Map<String, dynamic>>()
            .map(CartItem.fromJson)
            .toList(growable: false),
        subtotal: (json['subtotal'] as num?)?.toDouble() ?? 0,
        shipping: (json['shipping'] as num?)?.toDouble() ?? 0,
        total: (json['total'] as num?)?.toDouble() ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'number': number,
        'created_at': createdAt,
        'payment_method': paymentMethod.value,
        'address': address.toJson(),
        'items': items.map((item) => item.toJson()).toList(),
        'subtotal': subtotal,
        'shipping': shipping,
        'total': total,
      };

  StoreOrder copyWith({String? number, String? createdAt}) => StoreOrder(
        number: number ?? this.number,
        createdAt: createdAt ?? this.createdAt,
        paymentMethod: paymentMethod,
        address: address,
        items: items,
        subtotal: subtotal,
        shipping: shipping,
        total: total,
      );

  int get itemsCount => items.fold(0, (count, item) => count + item.quantity);

  @override
  List<Object?> get props => [
        number,
        createdAt,
        paymentMethod,
        address,
        items,
        subtotal,
        shipping,
        total,
      ];
}

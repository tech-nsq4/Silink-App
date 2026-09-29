import 'package:equatable/equatable.dart';

import '../../../cart/data/models/cart_item.dart';
import 'payment_method.dart';
import 'shipping_address.dart';

class OrderModel extends Equatable {
  final String number;
  final DateTime createdAt;
  final DateTime expectedDeliveryAt;
  final PaymentMethod paymentMethod;
  final ShippingAddress address;
  final List<CartItem> items;
  final double subtotal;
  final double shipping;
  final double total;

  const OrderModel({
    required this.number,
    required this.createdAt,
    required this.expectedDeliveryAt,
    required this.paymentMethod,
    required this.address,
    required this.items,
    required this.subtotal,
    required this.shipping,
    required this.total,
  });

  factory OrderModel.fromJson(
    Map<String, dynamic> json, {
    required DateTime fallbackCreatedAt,
    required DateTime fallbackExpectedDeliveryAt,
    required PaymentMethod paymentMethod,
    required ShippingAddress address,
    required List<CartItem> items,
    required double subtotal,
    required double shipping,
  }) {
    double? parseAmount(Object? value) =>
        value == null ? null : double.tryParse(value.toString());
    DateTime? parseDate(Object? value) =>
        value == null ? null : DateTime.tryParse(value.toString());

    final resolvedSubtotal = parseAmount(json['subtotal']) ?? subtotal;
    final resolvedShipping = parseAmount(json['shipping']) ?? shipping;

    return OrderModel(
      number: (json['orderNumber'] ?? json['number'] ?? json['id'] ?? '')
          .toString(),
      createdAt: parseDate(json['createdAt']) ?? fallbackCreatedAt,
      expectedDeliveryAt:
          parseDate(json['expectedDeliveryAt']) ?? fallbackExpectedDeliveryAt,
      paymentMethod: paymentMethod,
      address: address,
      items: List.unmodifiable(items),
      subtotal: resolvedSubtotal,
      shipping: resolvedShipping,
      total: parseAmount(json['total']) ?? resolvedSubtotal + resolvedShipping,
    );
  }

  int get itemsCount => items.fold(0, (count, item) => count + item.quantity);

  Map<String, dynamic> toJson() => {
        'orderNumber': number,
        'createdAt': createdAt.toIso8601String(),
        'expectedDeliveryAt': expectedDeliveryAt.toIso8601String(),
        'paymentType': paymentMethod.value,
        'address': address.toJson(),
        'items': items.map((item) => item.toJson()).toList(growable: false),
        'subtotal': subtotal,
        'shipping': shipping,
        'total': total,
      };

  @override
  List<Object?> get props => [
        number,
        createdAt,
        expectedDeliveryAt,
        paymentMethod,
        address,
        items,
        subtotal,
        shipping,
        total,
      ];
}

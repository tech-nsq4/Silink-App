import 'package:equatable/equatable.dart';

import '../../../checkout/data/models/payment_method.dart';
import 'order_item_model.dart';
import 'order_status.dart';

class MyOrderModel extends Equatable {
  final String id;
  final String fullName;
  final String phone;
  final String cityId;
  final String city;
  final String district;
  final String street;
  final String notes;
  final PaymentMethod paymentType;
  final OrderStatus status;
  final String statusValue;
  final DateTime? cancelledAt;
  final List<OrderItemModel> products;
  final int itemsCount;
  final double total;
  final String currency;
  final String deliveryEstimate;

  const MyOrderModel({
    required this.id,
    this.fullName = '',
    this.phone = '',
    this.cityId = '',
    this.city = '',
    this.district = '',
    this.street = '',
    this.notes = '',
    this.paymentType = PaymentMethod.cashOnDelivery,
    this.status = OrderStatus.unknown,
    this.statusValue = '',
    this.cancelledAt,
    this.products = const [],
    this.itemsCount = 0,
    this.total = 0,
    this.currency = '',
    this.deliveryEstimate = '',
  });

  factory MyOrderModel.fromJson(Map<String, dynamic> json) {
    final products = (json['products'] as List?)
            ?.whereType<Map<String, dynamic>>()
            .map(OrderItemModel.fromJson)
            .toList(growable: false) ??
        const <OrderItemModel>[];
    final statusValue = json['status']?.toString() ?? '';

    return MyOrderModel(
      id: json['id']?.toString() ?? '',
      fullName: json['fullName'] as String? ?? '',
      phone: json['phone']?.toString() ?? '',
      cityId: json['cityId']?.toString() ?? '',
      city: json['city'] as String? ?? '',
      district: json['district'] as String? ?? '',
      street: json['street'] as String? ?? '',
      notes: json['notes'] as String? ?? '',
      paymentType: PaymentMethod.fromValue(json['paymentType']?.toString()),
      status: OrderStatus.fromValue(statusValue),
      statusValue: statusValue,
      cancelledAt: DateTime.tryParse(json['cancelledAt']?.toString() ?? ''),
      products: products,
      itemsCount: int.tryParse(json['itemsCount']?.toString() ?? '') ??
          products.fold<int>(0, (count, item) => count + item.quantity),
      total: double.tryParse(json['total']?.toString() ?? '') ?? 0,
      currency: json['currency'] as String? ?? '',
      deliveryEstimate: json['deliveryEstimate'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'fullName': fullName,
        'phone': phone,
        'cityId': cityId,
        'city': city,
        'district': district,
        'street': street,
        'notes': notes,
        'paymentType': paymentType.value,
        'status': statusValue,
        'cancelledAt': cancelledAt?.toIso8601String(),
        'products': products.map((item) => item.toJson()).toList(),
        'itemsCount': itemsCount,
        'total': total.toStringAsFixed(2),
        'currency': currency,
        'deliveryEstimate': deliveryEstimate,
      };

  String get shortNumber {
    final trimmed = id.trim();
    final short =
        trimmed.length > 8 ? trimmed.substring(trimmed.length - 8) : trimmed;
    return short.toUpperCase();
  }

  bool get isCancelled =>
      status == OrderStatus.cancelled || cancelledAt != null;

  bool get canCancel => status == OrderStatus.placed && cancelledAt == null;

  MyOrderModel markCancelled() => MyOrderModel(
        id: id,
        fullName: fullName,
        phone: phone,
        cityId: cityId,
        city: city,
        district: district,
        street: street,
        notes: notes,
        paymentType: paymentType,
        status: OrderStatus.cancelled,
        statusValue: OrderStatus.cancelled.name,
        cancelledAt: DateTime.now(),
        products: products,
        itemsCount: itemsCount,
        total: total,
        currency: currency,
        deliveryEstimate: deliveryEstimate,
      );

  @override
  List<Object?> get props => [
        id,
        fullName,
        phone,
        cityId,
        city,
        district,
        street,
        notes,
        paymentType,
        status,
        statusValue,
        cancelledAt,
        products,
        itemsCount,
        total,
        currency,
        deliveryEstimate,
      ];
}

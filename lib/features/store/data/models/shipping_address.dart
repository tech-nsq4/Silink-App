import 'package:equatable/equatable.dart';

class ShippingAddress extends Equatable {
  final String fullName;
  final String phone;
  final String address;
  final String city;
  final String district;
  final String street;
  final String details;

  const ShippingAddress({
    this.fullName = '',
    this.phone = '',
    this.address = '',
    this.city = '',
    this.district = '',
    this.street = '',
    this.details = '',
  });

  factory ShippingAddress.fromJson(Map<String, dynamic> json) =>
      ShippingAddress(
        fullName: json['full_name'] as String? ?? '',
        phone: json['phone'] as String? ?? '',
        address: json['address'] as String? ?? '',
        city: json['city'] as String? ?? '',
        district: json['district'] as String? ?? '',
        street: json['street'] as String? ?? '',
        details: json['details'] as String? ?? '',
      );

  Map<String, dynamic> toJson() => {
        'full_name': fullName,
        'phone': phone,
        'address': address,
        'city': city,
        'district': district,
        'street': street,
        'details': details,
      };

  ShippingAddress copyWith({
    String? fullName,
    String? phone,
    String? address,
    String? city,
    String? district,
    String? street,
    String? details,
  }) =>
      ShippingAddress(
        fullName: fullName ?? this.fullName,
        phone: phone ?? this.phone,
        address: address ?? this.address,
        city: city ?? this.city,
        district: district ?? this.district,
        street: street ?? this.street,
        details: details ?? this.details,
      );

  bool get isComplete =>
      fullName.trim().isNotEmpty &&
      phone.trim().isNotEmpty &&
      address.trim().isNotEmpty &&
      city.trim().isNotEmpty;

  List<String> get lines => [
        street,
        district,
        city,
        address,
        details,
      ].where((line) => line.trim().isNotEmpty).toList(growable: false);

  String get searchQuery => lines.join(', ');

  @override
  List<Object?> get props =>
      [fullName, phone, address, city, district, street, details];
}

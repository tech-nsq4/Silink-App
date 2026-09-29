import 'package:equatable/equatable.dart';

import 'city_model.dart';

class ShippingAddress extends Equatable {
  final String fullName;
  final String phone;
  final CityModel? city;
  final String district;
  final String street;
  final String notes;

  const ShippingAddress({
    this.fullName = '',
    this.phone = '',
    this.city,
    this.district = '',
    this.street = '',
    this.notes = '',
  });

  List<String> get areaParts => [city?.name ?? '', district, street]
      .where((part) => part.trim().isNotEmpty)
      .toList(growable: false);

  factory ShippingAddress.fromJson(Map<String, dynamic> json) =>
      ShippingAddress(
        fullName: json['fullName'] as String? ?? '',
        phone: json['phone'] as String? ?? '',
        city: json['city'] is Map<String, dynamic>
            ? CityModel.fromJson(json['city'] as Map<String, dynamic>)
            : null,
        district: json['district'] as String? ?? '',
        street: json['street'] as String? ?? '',
        notes: json['notes'] as String? ?? '',
      );

  Map<String, dynamic> toJson() => {
        'fullName': fullName,
        'phone': phone,
        'cityId': city?.id ?? '',
        'district': district,
        'street': street,
        'notes': notes,
      };

  @override
  List<Object?> get props => [fullName, phone, city, district, street, notes];
}

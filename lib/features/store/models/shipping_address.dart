class ShippingAddress {
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
}

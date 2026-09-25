import 'package:equatable/equatable.dart';

class ProfileCardProduct extends Equatable {
  final String id;
  final String kind;
  final String name;
  final String description;
  final String? imageUrl;
  final String priceLabel;
  final String price;
  final String actionType;
  final String actionUrl;
  final int sortOrder;
  final bool isActive;

  const ProfileCardProduct({
    required this.id,
    required this.kind,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.priceLabel,
    required this.price,
    required this.actionType,
    required this.actionUrl,
    required this.sortOrder,
    required this.isActive,
  });

  bool get hasImage => imageUrl != null && imageUrl!.trim().isNotEmpty;

  factory ProfileCardProduct.fromJson(Map<String, dynamic> json) =>
      ProfileCardProduct(
        id: json['id']?.toString() ?? '',
        kind: json['kind'] as String? ?? 'product',
        name: json['name'] as String? ?? '',
        description: json['description'] as String? ?? '',
        imageUrl: json['imageUrl'] as String?,
        priceLabel: json['priceLabel']?.toString() ?? '',
        price: json['price']?.toString() ?? '',
        actionType: json['actionType'] as String? ?? '',
        actionUrl: json['actionUrl'] as String? ?? '',
        sortOrder: (json['sortOrder'] as num?)?.toInt() ?? 0,
        isActive: json['isActive'] as bool? ?? true,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'kind': kind,
        'name': name,
        'description': description,
        'imageUrl': imageUrl,
        'priceLabel': priceLabel,
        'price': price,
        'actionType': actionType,
        'actionUrl': actionUrl,
        'sortOrder': sortOrder,
        'isActive': isActive,
      };

  @override
  List<Object?> get props => [
        id,
        kind,
        name,
        description,
        imageUrl,
        priceLabel,
        price,
        actionType,
        actionUrl,
        sortOrder,
        isActive,
      ];
}

import 'package:equatable/equatable.dart';

import 'client_category_model.dart';

class ClientModel extends Equatable {
  const ClientModel({
    required this.id,
    required this.name,
    required this.mobile,
    this.email = '',
    this.whatsapp = '',
    this.note = '',
    this.categories = const [],
  });

  final String id;
  final String name;
  final String mobile;
  final String email;
  final String whatsapp;
  final String note;
  final List<ClientCategoryModel> categories;

  Set<String> get categoryIds => categories.map((c) => c.id).toSet();

  String get whatsappOrMobile => whatsapp.trim().isEmpty ? mobile : whatsapp;

  factory ClientModel.fromJson(Map<String, dynamic> json) => ClientModel(
        id: json['id']?.toString() ?? '',
        name: json['name'] as String? ?? '',
        mobile: json['mobile']?.toString() ?? '',
        email: json['email'] as String? ?? '',
        whatsapp: json['whatsapp']?.toString() ?? '',
        note: json['note'] as String? ?? '',
        categories: (json['categories'] as List<dynamic>? ?? [])
            .whereType<Map<String, dynamic>>()
            .map(ClientCategoryModel.fromJson)
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'mobile': mobile,
        'email': email,
        'whatsapp': whatsapp,
        'note': note,
        'categories': categories.map((c) => c.toJson()).toList(),
      };

  ClientModel copyWith({List<ClientCategoryModel>? categories}) => ClientModel(
        id: id,
        name: name,
        mobile: mobile,
        email: email,
        whatsapp: whatsapp,
        note: note,
        categories: categories ?? this.categories,
      );

  @override
  List<Object?> get props =>
      [id, name, mobile, email, whatsapp, note, categories];
}

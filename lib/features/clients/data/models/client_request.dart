import 'package:equatable/equatable.dart';

import 'client_model.dart';

class ClientRequest extends Equatable {
  const ClientRequest({
    required this.name,
    required this.mobile,
    this.email = '',
    this.whatsapp = '',
    this.note = '',
    this.categoryIds = const [],
  });

  static const String defaultCountryCode = '+966';

  final String name;
  final String mobile;
  final String email;
  final String whatsapp;
  final String note;
  final List<String> categoryIds;

  factory ClientRequest.fromClient(
    ClientModel client, {
    List<String>? categoryIds,
  }) =>
      ClientRequest(
        name: client.name,
        mobile: client.mobile,
        email: client.email,
        whatsapp: client.whatsapp,
        note: client.note,
        categoryIds: categoryIds ?? client.categoryIds.toList(),
      );

  static String withCountryCode(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty || trimmed.startsWith('+')) return trimmed;
    final digits =
        trimmed.replaceAll(RegExp(r'\D'), '').replaceFirst(RegExp(r'^0+'), '');
    return '$defaultCountryCode$digits';
  }

  Map<String, dynamic> toJson() => {
        'name': name.trim(),
        'mobile': withCountryCode(mobile),
        'email': email.trim(),
        'whatsapp': withCountryCode(whatsapp),
        'note': note.trim(),
        'categoryIds': categoryIds,
      };

  @override
  List<Object?> get props => [name, mobile, email, whatsapp, note, categoryIds];
}

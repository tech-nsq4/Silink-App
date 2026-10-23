import 'package:equatable/equatable.dart';

class InvitationEmployee extends Equatable {
  const InvitationEmployee({
    required this.name,
    required this.email,
    required this.phone,
    required this.position,
    this.imageUrl,
  });

  final String name;
  final String email;
  final String phone;
  final String position;
  final String? imageUrl;

  factory InvitationEmployee.fromJson(Map<String, dynamic> json) =>
      InvitationEmployee(
        name: json['name'] as String? ?? '',
        email: json['email'] as String? ?? '',
        phone: json['phone'] as String? ?? '',
        position: json['position'] as String? ?? '',
        imageUrl: json['imageUrl'] as String?,
      );

  @override
  List<Object?> get props => [name, email, phone, position, imageUrl];
}

class InvitationCompany extends Equatable {
  const InvitationCompany({
    required this.name,
    required this.about,
    required this.website,
    required this.phone,
    required this.email,
    this.logoUrl,
  });

  final String name;
  final String about;
  final String website;
  final String phone;
  final String email;
  final String? logoUrl;

  factory InvitationCompany.fromJson(Map<String, dynamic> json) =>
      InvitationCompany(
        name: json['companyName'] as String? ?? '',
        about: json['about'] as String? ?? '',
        website: json['website'] as String? ?? '',
        phone: json['contactPhone'] as String? ?? '',
        email: json['companyEmail'] as String? ?? '',
        logoUrl: json['logoUrl'] as String?,
      );

  @override
  List<Object?> get props => [name, about, website, phone, email, logoUrl];
}

class InvitationDetailsModel extends Equatable {
  const InvitationDetailsModel({
    required this.status,
    required this.employee,
    required this.company,
    this.expiresAt,
  });

  final String status;
  final DateTime? expiresAt;
  final InvitationEmployee employee;
  final InvitationCompany company;

  bool get isPending => status == 'pending';

  factory InvitationDetailsModel.fromJson(Map<String, dynamic> json) =>
      InvitationDetailsModel(
        status: json['status'] as String? ?? '',
        expiresAt: DateTime.tryParse(json['expiresAt'] as String? ?? ''),
        employee: InvitationEmployee.fromJson(
          json['employee'] as Map<String, dynamic>? ?? const {},
        ),
        company: InvitationCompany.fromJson(
          json['company'] as Map<String, dynamic>? ?? const {},
        ),
      );

  @override
  List<Object?> get props => [status, expiresAt, employee, company];
}

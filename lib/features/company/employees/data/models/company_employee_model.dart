import 'package:equatable/equatable.dart';

enum CompanyEmployeeStatus {
  active,
  pending,
  suspended;

  static CompanyEmployeeStatus fromApi(String? value) => switch (value) {
        'active' => CompanyEmployeeStatus.active,
        'pending' || 'invited' => CompanyEmployeeStatus.pending,
        _ => CompanyEmployeeStatus.suspended,
      };
}

class CompanyEmployeeModel extends Equatable {
  const CompanyEmployeeModel({
    required this.id,
    required this.name,
    required this.email,
    required this.status,
    this.phone = '',
    this.whatsapp = '',
    this.position = '',
    this.imageUrl,
    this.companyOwnerId = '',
    this.createdAt,
    this.hasProfile = false,
    this.hasNfc = false,
    this.visits = 0,
    this.leads = 0,
  });

  final String id;
  final String name;
  final String email;
  final String phone;
  final String whatsapp;
  final String position;
  final String? imageUrl;
  final CompanyEmployeeStatus status;
  final String companyOwnerId;
  final DateTime? createdAt;

  final bool hasProfile;
  final bool hasNfc;
  final int visits;
  final int leads;

  factory CompanyEmployeeModel.fromJson(Map<String, dynamic> json) =>
      CompanyEmployeeModel(
        id: json['id'] as String? ?? '',
        name: json['name'] as String? ?? '',
        email: json['email'] as String? ?? '',
        phone: json['phone'] as String? ?? '',
        whatsapp: json['whatsapp'] as String? ?? '',
        position: json['position'] as String? ?? '',
        imageUrl: json['imageUrl'] as String?,
        status: CompanyEmployeeStatus.fromApi(json['status'] as String?),
        companyOwnerId: json['companyOwnerId'] as String? ?? '',
        createdAt: DateTime.tryParse(json['createdAt'] as String? ?? ''),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'phone': phone,
        'whatsapp': whatsapp,
        'position': position,
        'imageUrl': imageUrl,
        'status': status.name,
        'companyOwnerId': companyOwnerId,
        'createdAt': createdAt?.toIso8601String(),
      };

  String get initials {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty || parts.first.isEmpty) return '؟';
    return parts.first[0];
  }

  CompanyEmployeeModel copyWith({
    String? name,
    String? email,
    String? phone,
    String? whatsapp,
    String? position,
    String? imageUrl,
    CompanyEmployeeStatus? status,
    bool? hasProfile,
    bool? hasNfc,
    int? visits,
    int? leads,
  }) {
    return CompanyEmployeeModel(
      id: id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      whatsapp: whatsapp ?? this.whatsapp,
      position: position ?? this.position,
      imageUrl: imageUrl ?? this.imageUrl,
      status: status ?? this.status,
      companyOwnerId: companyOwnerId,
      createdAt: createdAt,
      hasProfile: hasProfile ?? this.hasProfile,
      hasNfc: hasNfc ?? this.hasNfc,
      visits: visits ?? this.visits,
      leads: leads ?? this.leads,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        phone,
        whatsapp,
        position,
        imageUrl,
        status,
        companyOwnerId,
        createdAt,
        hasProfile,
        hasNfc,
        visits,
        leads,
      ];
}

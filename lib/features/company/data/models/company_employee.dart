enum CompanyEmployeeStatus { active, pending, suspended }

class CompanyEmployee {
  const CompanyEmployee({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
    required this.permission,
    this.status = CompanyEmployeeStatus.active,
    this.visits = 0,
    this.cardsCount = 0,
  });

  final String id;
  final String name;
  final String email;
  final String phone;
  final String role;
  final String permission;
  final CompanyEmployeeStatus status;
  final int visits;
  final int cardsCount;

  String get initial => name.trim().isEmpty ? 'M' : name.trim().substring(0, 1);

  CompanyEmployee copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? role,
    String? permission,
    CompanyEmployeeStatus? status,
    int? visits,
    int? cardsCount,
  }) {
    return CompanyEmployee(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      permission: permission ?? this.permission,
      status: status ?? this.status,
      visits: visits ?? this.visits,
      cardsCount: cardsCount ?? this.cardsCount,
    );
  }
}

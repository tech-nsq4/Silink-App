enum CompanyEmployeeStatus { active, pending, suspended }

class CompanyEmployeeItem {
  const CompanyEmployeeItem({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.jobTitle,
    required this.status,
    this.department = '',
    this.hasProfile = false,
    this.hasNfc = false,
    this.visits = 0,
    this.leads = 0,
  });

  final String id;
  final String fullName;
  final String email;
  final String phone;
  final String jobTitle;
  final String department;
  final CompanyEmployeeStatus status;
  final bool hasProfile;
  final bool hasNfc;
  final int visits;
  final int leads;

  String get initials {
    final parts = fullName.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty || parts.first.isEmpty) return '؟';
    return parts.first[0];
  }

  CompanyEmployeeItem copyWith({
    String? id,
    String? fullName,
    String? email,
    String? phone,
    String? jobTitle,
    String? department,
    CompanyEmployeeStatus? status,
    bool? hasProfile,
    bool? hasNfc,
    int? visits,
    int? leads,
  }) {
    return CompanyEmployeeItem(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      jobTitle: jobTitle ?? this.jobTitle,
      department: department ?? this.department,
      status: status ?? this.status,
      hasProfile: hasProfile ?? this.hasProfile,
      hasNfc: hasNfc ?? this.hasNfc,
      visits: visits ?? this.visits,
      leads: leads ?? this.leads,
    );
  }
}

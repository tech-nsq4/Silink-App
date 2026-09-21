enum CompanyCardStatus { active, suspended }

class CompanyCard {
  const CompanyCard({
    required this.id,
    required this.name,
    required this.code,
    this.status = CompanyCardStatus.active,
  });

  final String id;
  final String name;
  final String code;
  final CompanyCardStatus status;

  CompanyCard copyWith({
    String? id,
    String? name,
    String? code,
    CompanyCardStatus? status,
  }) {
    return CompanyCard(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      status: status ?? this.status,
    );
  }
}

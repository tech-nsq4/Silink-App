import 'package:equatable/equatable.dart';

class CompanySizeOption extends Equatable {
  final String type;
  final String label;
  final bool selected;

  const CompanySizeOption({
    required this.type,
    required this.label,
    required this.selected,
  });

  factory CompanySizeOption.fromJson(Map<String, dynamic> json) =>
      CompanySizeOption(
        type: json['type'] as String? ?? '',
        label: json['label'] as String? ?? '',
        selected: json['selected'] as bool? ?? false,
      );

  @override
  List<Object?> get props => [type, label, selected];
}

class CompanyCityOption extends Equatable {
  final String id;
  final String name;
  final bool selected;

  const CompanyCityOption({
    required this.id,
    required this.name,
    required this.selected,
  });

  factory CompanyCityOption.fromJson(Map<String, dynamic> json) =>
      CompanyCityOption(
        id: json['id'] as String? ?? '',
        name: json['name'] as String? ?? '',
        selected: json['selected'] as bool? ?? false,
      );

  @override
  List<Object?> get props => [id, name, selected];
}

class CompanyDetailsModel extends Equatable {
  final String userId;
  final String step;
  final String title;
  final String? companySize;
  final String? cityId;
  final String contactPhone;
  final String companyEmail;
  final List<CompanySizeOption> sizes;
  final List<CompanyCityOption> cities;

  const CompanyDetailsModel({
    required this.userId,
    required this.step,
    required this.title,
    this.companySize,
    this.cityId,
    required this.contactPhone,
    required this.companyEmail,
    required this.sizes,
    required this.cities,
  });

  factory CompanyDetailsModel.fromJson(Map<String, dynamic> json) =>
      CompanyDetailsModel(
        userId: json['userId'] as String? ?? '',
        step: json['step'] as String? ?? '',
        title: json['title'] as String? ?? '',
        companySize: json['companySize'] as String?,
        cityId: json['cityId'] as String?,
        contactPhone: json['contactPhone'] as String? ?? '',
        companyEmail: json['companyEmail'] as String? ?? '',
        sizes: (json['sizes'] as List<dynamic>? ?? [])
            .map((e) => CompanySizeOption.fromJson(e as Map<String, dynamic>))
            .toList(),
        cities: (json['cities'] as List<dynamic>? ?? [])
            .map((e) => CompanyCityOption.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  CompanyDetailsModel copyWith({String? companySize, String? cityId}) =>
      CompanyDetailsModel(
        userId: userId,
        step: step,
        title: title,
        companySize: companySize ?? this.companySize,
        cityId: cityId ?? this.cityId,
        contactPhone: contactPhone,
        companyEmail: companyEmail,
        sizes: sizes,
        cities: cities,
      );

  @override
  List<Object?> get props => [
        userId,
        step,
        title,
        companySize,
        cityId,
        contactPhone,
        companyEmail,
        sizes,
        cities,
      ];
}

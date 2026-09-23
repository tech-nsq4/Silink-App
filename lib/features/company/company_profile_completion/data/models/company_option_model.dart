import 'package:equatable/equatable.dart';

class CompanyOptionModel extends Equatable {
  final String id;
  final String name;
  final String description;
  final bool selected;

  const CompanyOptionModel({
    required this.id,
    required this.name,
    required this.description,
    required this.selected,
  });

  factory CompanyOptionModel.fromJson(Map<String, dynamic> json) =>
      CompanyOptionModel(
        id: json['id'] as String? ?? '',
        name: json['name'] as String? ?? '',
        description: json['description'] as String? ?? '',
        selected: json['selected'] as bool? ?? false,
      );

  @override
  List<Object?> get props => [id, name, description, selected];
}

class CompanyIndustryModel extends Equatable {
  final String userId;
  final String step;
  final String title;
  final String? selectedId;
  final List<CompanyOptionModel> industries;

  const CompanyIndustryModel({
    required this.userId,
    required this.step,
    required this.title,
    this.selectedId,
    required this.industries,
  });

  factory CompanyIndustryModel.fromJson(Map<String, dynamic> json) =>
      CompanyIndustryModel(
        userId: json['userId'] as String? ?? '',
        step: json['step'] as String? ?? '',
        title: json['title'] as String? ?? '',
        selectedId: json['selected'] as String?,
        industries: (json['industries'] as List<dynamic>? ?? [])
            .map((e) => CompanyOptionModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  CompanyIndustryModel copyWith({String? selectedId}) => CompanyIndustryModel(
        userId: userId,
        step: step,
        title: title,
        selectedId: selectedId ?? this.selectedId,
        industries: industries,
      );

  @override
  List<Object?> get props => [userId, step, title, selectedId, industries];
}

class CompanySubIndustryModel extends Equatable {
  final String userId;
  final String step;
  final String title;
  final String? parentId;
  final String? selectedId;
  final List<CompanyOptionModel> industries;

  const CompanySubIndustryModel({
    required this.userId,
    required this.step,
    required this.title,
    this.parentId,
    this.selectedId,
    required this.industries,
  });

  factory CompanySubIndustryModel.fromJson(Map<String, dynamic> json) =>
      CompanySubIndustryModel(
        userId: json['userId'] as String? ?? '',
        step: json['step'] as String? ?? '',
        title: json['title'] as String? ?? '',
        parentId: json['parentId'] as String?,
        selectedId: json['selected'] as String?,
        industries: (json['industries'] as List<dynamic>? ?? [])
            .map((e) => CompanyOptionModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  CompanySubIndustryModel copyWith({String? selectedId}) =>
      CompanySubIndustryModel(
        userId: userId,
        step: step,
        title: title,
        parentId: parentId,
        selectedId: selectedId ?? this.selectedId,
        industries: industries,
      );

  @override
  List<Object?> get props =>
      [userId, step, title, parentId, selectedId, industries];
}

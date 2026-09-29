import 'package:equatable/equatable.dart';

class FileCategoryModel extends Equatable {
  const FileCategoryModel({required this.id, required this.name});

  final String id;
  final String name;

  factory FileCategoryModel.fromJson(Map<String, dynamic> json) =>
      FileCategoryModel(
        id: json['id']?.toString() ?? '',
        name: json['name'] as String? ?? '',
      );

  Map<String, dynamic> toJson() => {'id': id, 'name': name};

  @override
  List<Object?> get props => [id, name];
}

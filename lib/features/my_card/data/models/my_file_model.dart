import 'package:equatable/equatable.dart';

import 'file_category_model.dart';

class MyFileModel extends Equatable {
  const MyFileModel({
    required this.id,
    required this.name,
    this.note = '',
    this.fileUrl,
    this.categories = const [],
  });

  final String id;
  final String name;
  final String note;
  final String? fileUrl;
  final List<FileCategoryModel> categories;

  factory MyFileModel.fromJson(Map<String, dynamic> json) => MyFileModel(
        id: json['id']?.toString() ?? '',
        name: json['name'] as String? ?? '',
        note: json['note'] as String? ?? '',
        fileUrl: json['file'] as String?,
        categories: (json['categories'] as List? ?? const [])
            .whereType<Map<String, dynamic>>()
            .map(FileCategoryModel.fromJson)
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'note': note,
        'file': fileUrl,
        'categories': categories.map((c) => c.toJson()).toList(),
      };

  List<String> get categoryIds => categories.map((c) => c.id).toList();

  String get initials {
    final trimmed = name.trim();
    return trimmed.isEmpty ? '؟' : trimmed[0];
  }

  @override
  List<Object?> get props => [id, name, note, fileUrl, categories];
}

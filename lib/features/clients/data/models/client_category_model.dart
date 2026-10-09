import 'package:equatable/equatable.dart';

class ClientCategoryModel extends Equatable {
  const ClientCategoryModel({required this.id, required this.name});

  final String id;
  final String name;

  factory ClientCategoryModel.fromJson(Map<String, dynamic> json) =>
      ClientCategoryModel(
        id: json['id']?.toString() ?? '',
        name: json['name'] as String? ?? '',
      );

  Map<String, dynamic> toJson() => {'id': id, 'name': name};

  @override
  List<Object?> get props => [id, name];
}

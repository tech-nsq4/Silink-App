import 'package:equatable/equatable.dart';

class CityModel extends Equatable {
  final String id;
  final String name;

  const CityModel({required this.id, required this.name});

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
        id: json['id']?.toString() ?? '',
        name: json['name'] as String? ?? '',
      );

  Map<String, dynamic> toJson() => {'id': id, 'name': name};

  @override
  List<Object?> get props => [id, name];
}

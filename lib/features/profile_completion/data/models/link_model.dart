import 'package:equatable/equatable.dart';

class LinkModel extends Equatable {
  final String type;
  final String label;
  final String value;
  final bool visible;
  final String placeholder;

  const LinkModel({
    required this.type,
    required this.label,
    required this.value,
    required this.visible,
    required this.placeholder,
  });

  factory LinkModel.fromJson(Map<String, dynamic> json) => LinkModel(
        type: json['type'] as String? ?? '',
        label: json['label'] as String? ?? '',
        value: json['value'] as String? ?? '',
        visible: json['visible'] as bool? ?? false,
        placeholder: json['placeholder'] as String? ?? '',
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'value': value,
        'visible': visible,
      };

  LinkModel copyWith({String? value, bool? visible}) => LinkModel(
        type: type,
        label: label,
        value: value ?? this.value,
        visible: visible ?? this.visible,
        placeholder: placeholder,
      );

  @override
  List<Object?> get props => [type, label, value, visible, placeholder];
}

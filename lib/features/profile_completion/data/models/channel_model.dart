import 'package:equatable/equatable.dart';

class ChannelModel extends Equatable {
  final String type;
  final String label;
  final String value;
  final bool visible;
  final String placeholder;

  const ChannelModel({
    required this.type,
    required this.label,
    required this.value,
    required this.visible,
    required this.placeholder,
  });

  factory ChannelModel.fromJson(Map<String, dynamic> json) => ChannelModel(
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

  ChannelModel copyWith({String? value, bool? visible}) => ChannelModel(
        type: type,
        label: label,
        value: value ?? this.value,
        visible: visible ?? this.visible,
        placeholder: placeholder,
      );

  @override
  List<Object?> get props => [type, label, value, visible, placeholder];
}

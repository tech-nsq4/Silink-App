import 'package:equatable/equatable.dart';

class ArrangementSectionModel extends Equatable {
  final String type;
  final String label;
  final String? hint;
  final bool visible;
  final bool locked;
  final int sortOrder;

  const ArrangementSectionModel({
    required this.type,
    required this.label,
    this.hint,
    required this.visible,
    required this.locked,
    required this.sortOrder,
  });

  factory ArrangementSectionModel.fromJson(Map<String, dynamic> json) =>
      ArrangementSectionModel(
        type: json['type'] as String? ?? '',
        label: json['label'] as String? ?? '',
        hint: json['hint'] as String?,
        visible: json['visible'] as bool? ?? true,
        locked: json['locked'] as bool? ?? false,
        sortOrder: json['sortOrder'] as int? ?? 0,
      );

  ArrangementSectionModel copyWith({bool? visible}) => ArrangementSectionModel(
        type: type,
        label: label,
        hint: hint,
        visible: visible ?? this.visible,
        locked: locked,
        sortOrder: sortOrder,
      );

  @override
  List<Object?> get props => [type, label, hint, visible, locked, sortOrder];
}

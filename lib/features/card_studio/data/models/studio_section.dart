import 'package:equatable/equatable.dart';

class StudioSection extends Equatable {
  const StudioSection({required this.type, this.visible = true});

  static const List<StudioSection> defaults = [
    StudioSection(type: 'bio'),
    StudioSection(type: 'services'),
    StudioSection(type: 'products', visible: false),
    StudioSection(type: 'links'),
    StudioSection(type: 'channels'),
  ];

  final String type;
  final bool visible;

  StudioSection copyWith({bool? visible}) =>
      StudioSection(type: type, visible: visible ?? this.visible);

  @override
  List<Object?> get props => [type, visible];
}

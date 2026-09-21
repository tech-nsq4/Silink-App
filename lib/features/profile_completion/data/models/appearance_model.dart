import 'package:equatable/equatable.dart';

class AppearanceBackground extends Equatable {
  final String type;
  final String label;
  final String color;

  const AppearanceBackground({
    required this.type,
    required this.label,
    required this.color,
  });

  factory AppearanceBackground.fromJson(Map<String, dynamic> json) =>
      AppearanceBackground(
        type: json['type'] as String? ?? '',
        label: json['label'] as String? ?? '',
        color: json['color'] as String? ?? '#FFFFFF',
      );

  @override
  List<Object?> get props => [type, label, color];
}

class AppearanceShape extends Equatable {
  final String type;
  final String label;
  final double radius;

  const AppearanceShape({
    required this.type,
    required this.label,
    required this.radius,
  });

  factory AppearanceShape.fromJson(Map<String, dynamic> json) =>
      AppearanceShape(
        type: json['type'] as String? ?? '',
        label: json['label'] as String? ?? '',
        radius: (json['radius'] as num?)?.toDouble() ?? 12,
      );

  @override
  List<Object?> get props => [type, label, radius];
}

class AppearanceFont extends Equatable {
  final String id;
  final String name;
  final String sample;
  final String family;

  const AppearanceFont({
    required this.id,
    required this.name,
    required this.sample,
    required this.family,
  });

  factory AppearanceFont.fromJson(Map<String, dynamic> json) => AppearanceFont(
        id: json['id']?.toString() ?? '',
        name: json['name'] as String? ?? '',
        sample: json['sample'] as String? ?? '',
        family: json['family'] as String? ?? '',
      );

  @override
  List<Object?> get props => [id, name, sample, family];
}

class AppearanceModel extends Equatable {
  final String primaryColor;
  final String coverColor;
  final String background;
  final String buttonShape;
  final String fontId;
  final List<String> colors;
  final List<AppearanceBackground> backgrounds;
  final List<AppearanceShape> shapes;
  final List<AppearanceFont> fonts;

  const AppearanceModel({
    required this.primaryColor,
    required this.coverColor,
    required this.background,
    required this.buttonShape,
    required this.fontId,
    required this.colors,
    required this.backgrounds,
    required this.shapes,
    required this.fonts,
  });

  factory AppearanceModel.fromJson(Map<String, dynamic> json) =>
      AppearanceModel(
        primaryColor: json['primaryColor'] as String? ?? '#0D9488',
        coverColor: json['coverColor'] as String? ?? '#0D9488',
        background: json['background'] as String? ?? 'white',
        buttonShape: json['buttonShape'] as String? ?? 'rounded',
        fontId: json['fontId']?.toString() ?? '',
        colors: (json['colors'] as List<dynamic>? ?? [])
            .map((e) => e.toString())
            .toList(),
        backgrounds: (json['backgrounds'] as List<dynamic>? ?? [])
            .map((e) =>
                AppearanceBackground.fromJson(e as Map<String, dynamic>))
            .toList(),
        shapes: (json['shapes'] as List<dynamic>? ?? [])
            .map((e) => AppearanceShape.fromJson(e as Map<String, dynamic>))
            .toList(),
        fonts: (json['fonts'] as List<dynamic>? ?? [])
            .map((e) => AppearanceFont.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'primaryColor': primaryColor,
        'coverColor': coverColor,
        'background': background,
        'buttonShape': buttonShape,
        'fontId': fontId,
      };

  AppearanceModel copyWith({
    String? primaryColor,
    String? coverColor,
    String? background,
    String? buttonShape,
    String? fontId,
  }) =>
      AppearanceModel(
        primaryColor: primaryColor ?? this.primaryColor,
        coverColor: coverColor ?? this.coverColor,
        background: background ?? this.background,
        buttonShape: buttonShape ?? this.buttonShape,
        fontId: fontId ?? this.fontId,
        colors: colors,
        backgrounds: backgrounds,
        shapes: shapes,
        fonts: fonts,
      );

  @override
  List<Object?> get props => [
        primaryColor,
        coverColor,
        background,
        buttonShape,
        fontId,
        colors,
        backgrounds,
        shapes,
        fonts,
      ];
}

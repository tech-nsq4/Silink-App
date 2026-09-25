import 'package:equatable/equatable.dart';

class ProfileCardAppearance extends Equatable {
  final String primaryColor;
  final String coverColor;
  final String background;
  final String buttonShape;
  final String fontFamily;

  const ProfileCardAppearance({
    required this.primaryColor,
    required this.coverColor,
    required this.background,
    required this.buttonShape,
    required this.fontFamily,
  });

  factory ProfileCardAppearance.fromJson(Map<String, dynamic> json) {
    final font = json['font'] as Map<String, dynamic>? ?? const {};
    return ProfileCardAppearance(
      primaryColor: json['primaryColor'] as String? ?? '',
      coverColor: json['coverColor'] as String? ?? '',
      background: json['background'] as String? ?? 'white',
      buttonShape: json['buttonShape'] as String? ?? 'rounded',
      fontFamily: font['family'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'primaryColor': primaryColor,
        'coverColor': coverColor,
        'background': background,
        'buttonShape': buttonShape,
        'font': {'family': fontFamily},
      };

  @override
  List<Object?> get props =>
      [primaryColor, coverColor, background, buttonShape, fontFamily];
}

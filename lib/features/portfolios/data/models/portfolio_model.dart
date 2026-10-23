import 'package:equatable/equatable.dart';

import '../../../profile_card/data/models/profile_card_model.dart';

class PortfolioModel extends Equatable {
  const PortfolioModel({
    required this.id,
    required this.name,
    required this.profileType,
    required this.isActive,
    required this.shareUrl,
    required this.fullName,
    required this.jobTitle,
    required this.company,
    this.photoUrl,
    this.card,
    this.createdAt,
    this.updatedAt,
    this.isPrimary = false,
  });

  final String id;
  final String name;
  final String profileType;
  final bool isActive;
  final String shareUrl;
  final String fullName;
  final String jobTitle;
  final String company;
  final String? photoUrl;
  final ProfileCardModel? card;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool isPrimary;

  bool get isBusiness => profileType == 'business';

  String get displayName => fullName.trim().isNotEmpty ? fullName : name;

  factory PortfolioModel.fromJson(
    Map<String, dynamic> json, {
    bool isPrimary = false,
  }) {
    final steps = json['steps'] as Map<String, dynamic>? ?? const {};
    final card = steps['card'];
    return PortfolioModel(
      id: json['id']?.toString() ?? '',
      name: json['name'] as String? ?? '',
      profileType: json['profileType'] as String? ?? '',
      isActive: json['isActive'] as bool? ?? true,
      shareUrl: json['shareUrl'] as String? ?? '',
      fullName: json['fullName'] as String? ?? '',
      jobTitle: json['jobTitle'] as String? ?? '',
      company: json['company'] as String? ?? '',
      photoUrl: json['photoUrl'] as String?,
      card:
          card is Map<String, dynamic> ? ProfileCardModel.fromJson(card) : null,
      createdAt: DateTime.tryParse(json['createdAt'] as String? ?? ''),
      updatedAt: DateTime.tryParse(json['updatedAt'] as String? ?? ''),
      isPrimary: isPrimary,
    );
  }

  PortfolioModel copyWith({bool? isActive}) => PortfolioModel(
        id: id,
        name: name,
        profileType: profileType,
        isActive: isActive ?? this.isActive,
        shareUrl: shareUrl,
        fullName: fullName,
        jobTitle: jobTitle,
        company: company,
        photoUrl: photoUrl,
        card: card,
        createdAt: createdAt,
        updatedAt: updatedAt,
        isPrimary: isPrimary,
      );

  @override
  List<Object?> get props => [
        id,
        name,
        profileType,
        isActive,
        shareUrl,
        fullName,
        jobTitle,
        company,
        photoUrl,
        card,
        createdAt,
        updatedAt,
        isPrimary,
      ];
}

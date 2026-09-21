import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum CardLifecycleStatus { active, draft, paused }

extension CardLifecycleStatusX on CardLifecycleStatus {
  String get value {
    switch (this) {
      case CardLifecycleStatus.active:
        return 'active';
      case CardLifecycleStatus.draft:
        return 'draft';
      case CardLifecycleStatus.paused:
        return 'paused';
    }
  }

  static CardLifecycleStatus fromString(String value) {
    switch (value) {
      case 'active':
        return CardLifecycleStatus.active;
      case 'draft':
        return CardLifecycleStatus.draft;
      case 'paused':
        return CardLifecycleStatus.paused;
      default:
        return CardLifecycleStatus.draft;
    }
  }
}

class MyCardModel extends Equatable {
  final String id;
  final String name;
  final String role;
  final String company;
  final String initials;
  final int avatarColorValue;
  final CardCategory category;
  final int categoryColorValue;
  final CardLifecycleStatus status;
  final bool isPublished;
  final bool isDefault;
  final bool hasNfc;
  final String? nfcCardName;
  final String? nfcCardCode;
  final bool nfcActive;
  final int visitsCount;
  final int clientsCount;
  final DateTime lastUpdated;
  final DateTime createdAt;
  final String link;

  const MyCardModel({
    required this.id,
    required this.name,
    required this.role,
    required this.company,
    required this.initials,
    required this.avatarColorValue,
    required this.category,
    required this.categoryColorValue,
    required this.status,
    required this.isPublished,
    required this.visitsCount,
    required this.clientsCount,
    required this.lastUpdated,
    required this.createdAt,
    required this.link,
    this.isDefault = false,
    this.hasNfc = false,
    this.nfcCardName,
    this.nfcCardCode,
    this.nfcActive = false,
  });

  Color get avatarColor => Color(avatarColorValue);
  Color get categoryColor => Color(categoryColorValue);

  factory MyCardModel.fromJson(Map<String, dynamic> json) => MyCardModel(
        id: json['id'] as String,
        name: json['name'] as String,
        role: json['role'] as String,
        company: json['company'] as String? ?? '',
        initials: json['initials'] as String,
        avatarColorValue: json['avatar_color'] as int? ?? 0xFF17B78F,
        category: CardCategoryX.fromString(json['category'] as String),
        categoryColorValue: json['category_color'] as int? ?? 0xFF2F6FED,
        status: CardLifecycleStatusX.fromString(
            json['status'] as String? ?? 'draft'),
        isPublished: json['is_published'] as bool? ?? false,
        visitsCount: json['visits_count'] as int? ?? 0,
        clientsCount: json['clients_count'] as int? ?? 0,
        lastUpdated: DateTime.parse(json['last_updated'] as String),
        createdAt: DateTime.parse(json['created_at'] as String),
        link: json['link'] as String,
        isDefault: json['is_default'] as bool? ?? false,
        hasNfc: json['has_nfc'] as bool? ?? false,
        nfcCardName: json['nfc_card_name'] as String?,
        nfcCardCode: json['nfc_card_code'] as String?,
        nfcActive: json['nfc_active'] as bool? ?? false,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'role': role,
        'company': company,
        'initials': initials,
        'avatar_color': avatarColorValue,
        'category': category.value,
        'category_color': categoryColorValue,
        'status': status.value,
        'is_published': isPublished,
        'visits_count': visitsCount,
        'clients_count': clientsCount,
        'last_updated': lastUpdated.toIso8601String(),
        'created_at': createdAt.toIso8601String(),
        'link': link,
        'is_default': isDefault,
        'has_nfc': hasNfc,
        'nfc_card_name': nfcCardName,
        'nfc_card_code': nfcCardCode,
        'nfc_active': nfcActive,
      };

  @override
  List<Object?> get props => [
        id,
        name,
        role,
        company,
        initials,
        avatarColorValue,
        category,
        categoryColorValue,
        status,
        isPublished,
        isDefault,
        hasNfc,
        nfcCardName,
        nfcCardCode,
        nfcActive,
        visitsCount,
        clientsCount,
        lastUpdated,
        createdAt,
        link,
      ];
}

enum CardCategory { business, personal, freelancer }

extension CardCategoryX on CardCategory {
  String get value {
    switch (this) {
      case CardCategory.business:
        return 'business';
      case CardCategory.personal:
        return 'personal';
      case CardCategory.freelancer:
        return 'freelancer';
    }
  }

  static CardCategory fromString(String value) {
    switch (value) {
      case 'business':
        return CardCategory.business;
      case 'freelancer':
        return CardCategory.freelancer;
      case 'personal':
      default:
        return CardCategory.personal;
    }
  }
}

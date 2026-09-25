import 'package:equatable/equatable.dart';

import 'profile_card_appearance.dart';
import 'profile_card_basic_info.dart';
import 'profile_card_contact_item.dart';
import 'profile_card_product.dart';

enum ProfileCardSectionType {
  basic,
  bio,
  channels,
  links,
  products,
  services,
  unknown
}

class ProfileCardSection extends Equatable {
  final ProfileCardSectionType type;
  final String label;
  final int sortOrder;

  const ProfileCardSection({
    required this.type,
    required this.label,
    required this.sortOrder,
  });

  static ProfileCardSectionType _typeFrom(String? raw) =>
      ProfileCardSectionType.values.firstWhere(
        (type) => type.name == raw,
        orElse: () => ProfileCardSectionType.unknown,
      );

  factory ProfileCardSection.fromJson(Map<String, dynamic> json) =>
      ProfileCardSection(
        type: _typeFrom(json['type'] as String?),
        label: json['label'] as String? ?? '',
        sortOrder: (json['sortOrder'] as num?)?.toInt() ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'type': type.name,
        'label': label,
        'sortOrder': sortOrder,
      };

  @override
  List<Object?> get props => [type, label, sortOrder];
}

class ProfileCardModel extends Equatable {
  final String userId;
  final String templateSlug;
  final ProfileCardAppearance appearance;
  final List<ProfileCardSection> sections;
  final ProfileCardBasicInfo basic;
  final String bio;
  final List<ProfileCardContactItem> channels;
  final List<ProfileCardContactItem> links;
  final List<ProfileCardProduct> products;

  const ProfileCardModel({
    required this.userId,
    required this.templateSlug,
    required this.appearance,
    required this.sections,
    required this.basic,
    required this.bio,
    required this.channels,
    required this.links,
    required this.products,
  });

  ProfileCardContactItem? get whatsapp {
    final matches = channels.where((c) => c.type == 'whatsapp' && c.isShown);
    return matches.isEmpty ? null : matches.first;
  }

  List<ProfileCardContactItem> get socialChannels =>
      channels.where((c) => c.type != 'whatsapp' && c.isShown).toList();

  List<ProfileCardContactItem> get visibleLinks =>
      links.where((l) => l.isShown).toList();

  List<ProfileCardProduct> _activeOfKind(String kind) =>
      products.where((p) => p.isActive && p.kind == kind).toList()
        ..sort((a, b) => a.sortOrder.compareTo(b.sortOrder));

  List<ProfileCardProduct> get activeCatalogItems {
    final productItems = _activeOfKind('product');
    final serviceItems = _activeOfKind('service');
    return [
      for (int i = 0;
          i < productItems.length || i < serviceItems.length;
          i++) ...[
        if (i < productItems.length) productItems[i],
        if (i < serviceItems.length) serviceItems[i],
      ],
    ];
  }

  bool isFirstCatalogSection(ProfileCardSection section) {
    final catalogSections = sections.where((s) =>
        s.type == ProfileCardSectionType.products ||
        s.type == ProfileCardSectionType.services);
    return catalogSections.isNotEmpty && catalogSections.first == section;
  }

  String labelOf(ProfileCardSectionType type) {
    final matches = sections.where((s) => s.type == type);
    return matches.isEmpty ? '' : matches.first.label;
  }

  static List<Map<String, dynamic>> _items(Map<String, dynamic> data) =>
      (data['items'] as List<dynamic>? ?? const [])
          .whereType<Map<String, dynamic>>()
          .toList();

  factory ProfileCardModel.fromJson(Map<String, dynamic> json) {
    final rawSections = (json['sections'] as List<dynamic>? ?? const [])
        .whereType<Map<String, dynamic>>()
        .toList();
    final sectionData = <String, Map<String, dynamic>>{
      for (final section in rawSections)
        section['type'] as String? ?? '':
            section['data'] as Map<String, dynamic>? ?? const {},
    };
    final template = json['template'] as Map<String, dynamic>? ?? const {};

    return ProfileCardModel(
      userId: json['userId']?.toString() ?? '',
      templateSlug: template['slug'] as String? ?? '',
      appearance: ProfileCardAppearance.fromJson(
        json['appearance'] as Map<String, dynamic>? ?? const {},
      ),
      sections: rawSections.map(ProfileCardSection.fromJson).toList()
        ..sort((a, b) => a.sortOrder.compareTo(b.sortOrder)),
      basic: ProfileCardBasicInfo.fromJson(sectionData['basic'] ?? const {}),
      bio: sectionData['bio']?['bio'] as String? ?? '',
      channels: _items(sectionData['channels'] ?? const {})
          .map(ProfileCardContactItem.fromJson)
          .toList(),
      links: _items(sectionData['links'] ?? const {})
          .map(ProfileCardContactItem.fromJson)
          .toList(),
      products: [
        ..._items(sectionData['products'] ?? const {}).map((json) =>
            ProfileCardProduct.fromJson({'kind': 'product', ...json})),
        ..._items(sectionData['services'] ?? const {}).map((json) =>
            ProfileCardProduct.fromJson({'kind': 'service', ...json})),
      ],
    );
  }

  @override
  List<Object?> get props => [
        userId,
        templateSlug,
        appearance,
        sections,
        basic,
        bio,
        channels,
        links,
        products,
      ];
}

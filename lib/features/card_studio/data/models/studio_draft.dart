import 'dart:io';

import 'package:equatable/equatable.dart';

import '../../../../core/utils/convert_helper.dart';
import '../../../../core/widgets/public_profile/public_profile_data.dart';
import 'studio_contact.dart';
import 'studio_item.dart';
import 'studio_section.dart';

class StudioDraft extends Equatable {
  const StudioDraft({
    this.name = '',
    this.title = '',
    this.company = '',
    this.bio = '',
    this.phone = '',
    this.email = '',
    this.location = '',
    this.lat,
    this.lng,
    this.photoUrl,
    this.photoFile,
    this.password = '',
    this.channels = const [],
    this.links = const [],
    this.items = const [],
    this.servicesEnabled = false,
    this.productsEnabled = false,
    this.template = 'pro',
    this.primaryColor = '#0D9488',
    this.background = 'white',
    this.buttonShape = 'rounded',
    this.fontFamily = 'Tajawal',
    this.sections = StudioSection.defaults,
  });

  factory StudioDraft.empty() => StudioDraft(
        channels: [
          for (final type in StudioContact.channelTypes)
            StudioContact(type: type),
        ],
        links: [
          for (final type in StudioContact.linkTypes) StudioContact(type: type),
        ],
      );

  static const List<String> templates = ['simple', 'pro', 'personal'];
  static const List<String> palette = [
    '#0D9488',
    '#2563EB',
    '#111827',
    '#7C3AED',
    '#EA580C',
    '#DC2626',
  ];
  static const List<String> backgrounds = ['white', 'light', 'gradient'];
  static const List<String> buttonShapes = ['pill', 'rounded', 'square'];
  static const List<String> fonts = ['Tajawal', 'Cairo', 'Almarai'];

  final String name;
  final String title;
  final String company;
  final String bio;
  final String phone;
  final String email;
  final String location;
  final double? lat;
  final double? lng;
  final String? photoUrl;
  final File? photoFile;
  final String password;
  final List<StudioContact> channels;
  final List<StudioContact> links;
  final List<StudioItem> items;
  final bool servicesEnabled;
  final bool productsEnabled;
  final String template;
  final String primaryColor;
  final String background;
  final String buttonShape;
  final String fontFamily;
  final List<StudioSection> sections;

  bool get hasServices => items.any((item) => item.isService);
  bool get hasProducts => items.any((item) => !item.isService);

  String get initials {
    final parts =
        name.trim().split(RegExp(r'\s+')).where((part) => part.isNotEmpty);
    final letters = parts.map((part) => part.substring(0, 1)).join();
    return letters.length > 2 ? letters.substring(0, 2) : letters;
  }

  StudioDraft withCatalogSections() {
    return copyWith(
      sections: [
        for (final section in sections)
          switch (section.type) {
            'services' => section.copyWith(visible: hasServices),
            'products' => section.copyWith(visible: hasProducts),
            _ => section,
          },
      ],
    );
  }

  PublicProfileData toPublicProfile({
    required String Function(String type) labelOf,
  }) {
    final visibleSections = <PublicProfileSection>[];
    for (final section in sections.where((s) => s.visible)) {
      final mapped = switch (section.type) {
        'bio' => PublicProfileSection.bio,
        'services' || 'products' => PublicProfileSection.catalog,
        'links' => PublicProfileSection.links,
        _ => PublicProfileSection.channels,
      };
      if (!visibleSections.contains(mapped)) visibleSections.add(mapped);
    }
    final shownKinds = {
      for (final section in sections.where((s) => s.visible))
        if (section.type == 'services' && servicesEnabled) 'service',
      for (final section in sections.where((s) => s.visible))
        if (section.type == 'products' && productsEnabled) 'product',
    };
    return PublicProfileData(
      name: name,
      title: title,
      company: company,
      bio: bio,
      phone: phone,
      email: email,
      location: location,
      photoUrl: photoUrl,
      photoFile: photoFile,
      accent: ConvertHelper.hexToColor(primaryColor),
      template: template,
      background: background,
      buttonShape: buttonShape,
      fontFamily: fontFamily,
      sections: visibleSections,
      items: [
        for (final item in items)
          if (item.visible && shownKinds.contains(item.kind))
            PublicProfileItem(
              id: item.localId,
              kind: item.kind,
              name: item.name,
              description: item.description,
              price: item.price,
              priceLabel: item.priceLabel,
              imageUrl: item.imageUrl,
              imageFile: item.imageFile,
            ),
      ],
      channels: [
        for (final channel in channels)
          if (channel.isShown)
            PublicProfileContact(
              type: channel.type,
              label: labelOf(channel.type),
              url: channel.url,
            ),
      ],
      links: [
        for (final link in links)
          if (link.isShown)
            PublicProfileContact(
              type: link.type,
              label: labelOf(link.type),
              url: link.url,
            ),
      ],
    );
  }

  StudioDraft copyWith({
    String? name,
    String? title,
    String? company,
    String? bio,
    String? phone,
    String? email,
    String? location,
    double? lat,
    double? lng,
    String? photoUrl,
    File? photoFile,
    String? password,
    List<StudioContact>? channels,
    List<StudioContact>? links,
    List<StudioItem>? items,
    bool? servicesEnabled,
    bool? productsEnabled,
    String? template,
    String? primaryColor,
    String? background,
    String? buttonShape,
    String? fontFamily,
    List<StudioSection>? sections,
  }) =>
      StudioDraft(
        name: name ?? this.name,
        title: title ?? this.title,
        company: company ?? this.company,
        bio: bio ?? this.bio,
        phone: phone ?? this.phone,
        email: email ?? this.email,
        location: location ?? this.location,
        lat: lat ?? this.lat,
        lng: lng ?? this.lng,
        photoUrl: photoUrl ?? this.photoUrl,
        photoFile: photoFile ?? this.photoFile,
        password: password ?? this.password,
        channels: channels ?? this.channels,
        links: links ?? this.links,
        items: items ?? this.items,
        servicesEnabled: servicesEnabled ?? this.servicesEnabled,
        productsEnabled: productsEnabled ?? this.productsEnabled,
        template: template ?? this.template,
        primaryColor: primaryColor ?? this.primaryColor,
        background: background ?? this.background,
        buttonShape: buttonShape ?? this.buttonShape,
        fontFamily: fontFamily ?? this.fontFamily,
        sections: sections ?? this.sections,
      );

  @override
  List<Object?> get props => [
        name,
        title,
        company,
        bio,
        phone,
        email,
        location,
        lat,
        lng,
        photoUrl,
        photoFile,
        password,
        channels,
        links,
        items,
        servicesEnabled,
        productsEnabled,
        template,
        primaryColor,
        background,
        buttonShape,
        fontFamily,
        sections,
      ];
}

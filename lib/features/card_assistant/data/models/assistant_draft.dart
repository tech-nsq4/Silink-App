import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

import '../../../../core/widgets/public_profile/public_profile_data.dart';
import '../../../card_studio/data/models/studio_draft.dart';
import '../../../card_studio/data/models/studio_item.dart';

class AssistantDraft extends Equatable {
  const AssistantDraft({
    this.name = '',
    this.title = '',
    this.company = '',
    this.bio = '',
    this.phone = '',
    this.email = '',
    this.location = '',
    this.services = '',
    this.website = '',
  });

  final String name;
  final String title;
  final String company;
  final String bio;
  final String phone;
  final String email;
  final String location;
  final String services;
  final String website;

  bool get isComplete => name.trim().isNotEmpty && title.trim().isNotEmpty;

  bool get isFreelance => company.trim().isEmpty;

  List<String> get serviceList => services
      .split(RegExp(r'[،,]'))
      .map((s) => s.trim())
      .where((s) => s.isNotEmpty)
      .toList();

  String get initials {
    final parts = name.trim().split(RegExp(r'\s+')).where((p) => p.isNotEmpty);
    final letters = parts.map((p) => p.characters.first).join();
    return letters.length > 2 ? letters.substring(0, 2) : letters;
  }

  AssistantDraft copyWith({
    String? name,
    String? title,
    String? company,
    String? bio,
    String? phone,
    String? email,
    String? location,
    String? services,
    String? website,
  }) =>
      AssistantDraft(
        name: name ?? this.name,
        title: title ?? this.title,
        company: company ?? this.company,
        bio: bio ?? this.bio,
        phone: phone ?? this.phone,
        email: email ?? this.email,
        location: location ?? this.location,
        services: services ?? this.services,
        website: website ?? this.website,
      );

  PublicProfileData toPublicProfile({required String whatsappLabel}) =>
      PublicProfileData(
        name: name,
        title: title,
        company: company,
        bio: bio,
        phone: phone,
        email: email,
        location: location,
        items: [
          for (final (index, service) in serviceList.indexed)
            PublicProfileItem(
                id: 'service-$index', kind: 'service', name: service),
        ],
        channels: [
          if (phone.trim().isNotEmpty)
            PublicProfileContact(
              type: 'whatsapp',
              label: whatsappLabel,
              url: 'https://wa.me/${phone.replaceAll(RegExp(r'\D'), '')}',
            ),
        ],
        links: [
          if (website.trim().isNotEmpty)
            PublicProfileContact(type: 'website', label: website, url: website),
        ],
      );

  StudioDraft toStudioDraft() {
    final empty = StudioDraft.empty();
    final hasPhone = phone.trim().isNotEmpty;
    final hasWebsite = website.trim().isNotEmpty;
    return empty.copyWith(
      name: name,
      title: title,
      company: company,
      bio: bio,
      phone: phone,
      email: email,
      location: location,
      channels: [
        for (final channel in empty.channels)
          channel.type == 'whatsapp' && hasPhone
              ? channel.copyWith(value: phone, visible: true)
              : channel,
      ],
      links: [
        for (final link in empty.links)
          link.type == 'website' && hasWebsite
              ? link.copyWith(value: website, visible: true)
              : link,
      ],
      items: [
        for (final (index, service) in serviceList.indexed)
          StudioItem(
            localId: 'assistant-$index',
            kind: 'service',
            name: service,
          ),
      ],
      servicesEnabled: serviceList.isNotEmpty,
    ).withCatalogSections();
  }

  @override
  List<Object?> get props =>
      [name, title, company, bio, phone, email, location, services, website];
}

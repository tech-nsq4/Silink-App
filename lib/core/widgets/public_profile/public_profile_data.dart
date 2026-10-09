import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum PublicProfileSection { bio, catalog, links, channels }

class PublicProfileItem extends Equatable {
  const PublicProfileItem({
    required this.id,
    required this.kind,
    required this.name,
    this.description = '',
    this.price = '',
    this.priceLabel = '',
    this.imageUrl,
    this.imageFile,
  });

  final String id;
  final String kind;
  final String name;
  final String description;
  final String price;
  final String priceLabel;
  final String? imageUrl;
  final File? imageFile;

  bool get isService => kind == 'service';

  @override
  List<Object?> get props =>
      [id, kind, name, description, price, priceLabel, imageUrl, imageFile];
}

class PublicProfileContact extends Equatable {
  const PublicProfileContact({
    required this.type,
    required this.label,
    required this.url,
  });

  final String type;
  final String label;
  final String url;

  String get host {
    final uri = Uri.tryParse(url);
    final host = uri?.host ?? '';
    return (host.isEmpty ? url : host).replaceFirst(RegExp(r'^www\.'), '');
  }

  @override
  List<Object?> get props => [type, label, url];
}

class PublicProfileData extends Equatable {
  const PublicProfileData({
    required this.name,
    required this.title,
    this.company = '',
    this.bio = '',
    this.phone = '',
    this.email = '',
    this.location = '',
    this.photoUrl,
    this.photoFile,
    this.accent = const Color(0xFF0D9488),
    this.template = 'pro',
    this.background = 'light',
    this.buttonShape = 'rounded',
    this.fontFamily,
    this.items = const [],
    this.channels = const [],
    this.links = const [],
    this.sections = const [
      PublicProfileSection.bio,
      PublicProfileSection.catalog,
      PublicProfileSection.links,
      PublicProfileSection.channels,
    ],
  });

  final String name;
  final String title;
  final String company;
  final String bio;
  final String phone;
  final String email;
  final String location;
  final String? photoUrl;
  final File? photoFile;
  final Color accent;
  final String template;
  final String background;
  final String buttonShape;
  final String? fontFamily;
  final List<PublicProfileItem> items;
  final List<PublicProfileContact> channels;
  final List<PublicProfileContact> links;
  final List<PublicProfileSection> sections;

  static const Map<String, double> _buttonRadii = {
    'pill': 999,
    'rounded': 12,
    'square': 4,
  };

  bool get isFreelance => company.trim().isEmpty;
  bool get isPro => template == 'pro';
  bool get isPersonal => template == 'personal';
  double get buttonRadius => _buttonRadii[buttonShape] ?? 12;

  PublicProfileContact? get whatsapp {
    final matches = channels.where((c) => c.type == 'whatsapp');
    return matches.isEmpty ? null : matches.first;
  }

  String get initials {
    final parts =
        name.trim().split(RegExp(r'\s+')).where((part) => part.isNotEmpty);
    final letters = parts.map((part) => part.characters.first).join();
    return letters.length > 2 ? letters.substring(0, 2) : letters;
  }

  @override
  List<Object?> get props => [
        name,
        title,
        company,
        bio,
        phone,
        email,
        location,
        photoUrl,
        photoFile,
        accent,
        template,
        background,
        buttonShape,
        fontFamily,
        items,
        channels,
        links,
        sections,
      ];
}

class PublicProfileActions {
  const PublicProfileActions({
    this.onShare,
    this.onClose,
    this.onCall,
    this.onEmail,
    this.onSaveContact,
    this.onShareData,
    this.onOpenContact,
    this.onItemTap,
    this.onMainContact,
  });

  final VoidCallback? onShare;
  final VoidCallback? onClose;
  final VoidCallback? onCall;
  final VoidCallback? onEmail;
  final VoidCallback? onSaveContact;
  final VoidCallback? onShareData;
  final ValueChanged<PublicProfileContact>? onOpenContact;
  final ValueChanged<PublicProfileItem>? onItemTap;
  final VoidCallback? onMainContact;
}

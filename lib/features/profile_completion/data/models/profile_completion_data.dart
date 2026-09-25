import 'dart:io';

import 'package:flutter/material.dart';

extension StringExtension on String {
  String get initial {
    final value = trim();
    if (value.isEmpty) return 'س';
    return value.characters.first.toUpperCase();
  }
}
enum ProfileType { work, personal, freelancer }

extension ProfileTypeApi on ProfileType {
  String get apiValue => switch (this) {
        ProfileType.work => 'business',
        ProfileType.personal => 'personal',
        ProfileType.freelancer => 'freelancer',
      };
}

enum ContactChannelType { whatsapp, linkedin, instagram, x, snapchat, tiktok }

enum ContactLinkType { website, portfolio, booking, quote, brochure, customLink }

enum RankingSectionType { bio, quickContact, channels, links, products, services }

enum ProfileTemplate { simple, professional, personal }

enum ProfileBackgroundStyle { gradient, light, white }

enum ProfileElementShape { square, curved, rounded }

enum ProfileFontStyle { tajawal, cairo, almarai }

class ToggleField {
  bool enabled;
  String value;

  ToggleField({this.enabled = false, this.value = ''});
}

class RankingSection {
  final RankingSectionType type;
  bool enabled;

  RankingSection({required this.type, this.enabled = true});
}

class ProductItem {
  String name;
  String price;
  bool enabled;

  ProductItem({
    required this.name,
    required this.price,
    this.enabled = true,
  });

  ProductItem copy() =>
      ProductItem(name: name, price: price, enabled: enabled);
}

class ProfileCompletionData {
  ProfileType? profileType;

  String fullName = '';
  String jobTitle = '';
  String company = '';
  String bio = '';
  String phone = '';
  String email = '';
  String password = '';
  String location = '';
  double? lat;
  double? lng;
  File? photo;

  final Map<ContactChannelType, ToggleField> channels = {
    for (final type in ContactChannelType.values) type: ToggleField(),
  };

  final Map<ContactLinkType, ToggleField> links = {
    for (final type in ContactLinkType.values) type: ToggleField(),
  };

  final List<RankingSection> ranking = [
    for (final type in RankingSectionType.values) RankingSection(type: type),
  ];

  ProfileTemplate template = ProfileTemplate.simple;

  Color primaryColor = const Color(0xFF17B78F);
  Color coverColor = const Color(0xFF17B78F);
  ProfileBackgroundStyle backgroundStyle = ProfileBackgroundStyle.white;
  ProfileElementShape elementShape = ProfileElementShape.rounded;
  ProfileFontStyle fontStyle = ProfileFontStyle.tajawal;

  bool productsEnabled = true;
  final List<ProductItem> products = [];

  ProfileCompletionData();

  ProfileCompletionData copy() {
    return ProfileCompletionData()
      ..profileType = profileType
      ..fullName = fullName
      ..jobTitle = jobTitle
      ..company = company
      ..bio = bio
      ..phone = phone
      ..email = email
      ..password = password
      ..location = location
      ..lat = lat
      ..lng = lng
      ..photo = photo
      ..template = template
      ..primaryColor = primaryColor
      ..coverColor = coverColor
      ..backgroundStyle = backgroundStyle
      ..elementShape = elementShape
      ..fontStyle = fontStyle
      ..productsEnabled = productsEnabled
      ..products.addAll(products.map((p) => p.copy()));
  }
}

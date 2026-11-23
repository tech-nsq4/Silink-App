import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';

class StudioPlatform {
  const StudioPlatform({
    required this.type,
    required this.host,
    required this.path,
    required this.color,
    required this.badge,
    this.badgeColor = Colors.white,
  });

  final String type;
  final String host;
  final String path;
  final Color color;
  final String badge;
  final Color badgeColor;

  String get displayBase => '$host$path';

  String get baseUrl => 'https://$displayBase';

  String compose(String handle) {
    final clean = cleanHandle(handle);
    return clean.isEmpty ? '' : '$baseUrl$clean';
  }

  bool matchesBase(String value) =>
      _withoutScheme(value).toLowerCase().startsWith(displayBase);

  bool isCustomLink(String value) =>
      isFullLink(value) && !matchesBase(value);

  String handleOf(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) return '';
    if (!isFullLink(trimmed)) return cleanHandle(trimmed);
    if (!matchesBase(trimmed)) return '';
    final rest = _withoutScheme(trimmed).substring(displayBase.length);
    return cleanHandle(rest.split(RegExp(r'[/?#]')).first);
  }

  static bool isFullLink(String raw) {
    final value = raw.trim().toLowerCase();
    return value.startsWith('http://') ||
        value.startsWith('https://') ||
        value.startsWith('www.') ||
        value.contains('/');
  }

  static String normalizeLink(String raw) {
    final value = raw.replaceAll(RegExp(r'\s'), '');
    if (value.isEmpty) return '';
    final lower = value.toLowerCase();
    if (lower.startsWith('http://') || lower.startsWith('https://')) {
      return value;
    }
    return 'https://$value';
  }

  static String _withoutScheme(String value) => value
      .trim()
      .replaceFirst(RegExp(r'^https?://', caseSensitive: false), '')
      .replaceFirst(RegExp(r'^www\.', caseSensitive: false), '');

  static String cleanHandle(String raw) =>
      raw.replaceAll(RegExp(r'\s'), '').replaceFirst(RegExp(r'^@+'), '');

  static String displayLink(String url) =>
      url.replaceFirst(RegExp(r'^https?://'), '');

  static const StudioPlatform whatsapp = StudioPlatform(
    type: 'whatsapp',
    host: 'wa.me',
    path: '/',
    color: AppColors.whatsappBrand,
    badge: 'W',
  );

  static const StudioPlatform linkedin = StudioPlatform(
    type: 'linkedin',
    host: 'linkedin.com',
    path: '/in/',
    color: AppColors.linkedinBrand,
    badge: 'in',
  );

  static const StudioPlatform instagram = StudioPlatform(
    type: 'instagram',
    host: 'instagram.com',
    path: '/',
    color: AppColors.instagramBrand,
    badge: 'IG',
  );

  static const StudioPlatform x = StudioPlatform(
    type: 'x',
    host: 'x.com',
    path: '/',
    color: AppColors.xBrand,
    badge: 'X',
  );

  static const StudioPlatform snapchat = StudioPlatform(
    type: 'snapchat',
    host: 'snapchat.com',
    path: '/add/',
    color: AppColors.snapchatBrand,
    badge: 'SC',
    badgeColor: Colors.black,
  );

  static const StudioPlatform tiktok = StudioPlatform(
    type: 'tiktok',
    host: 'tiktok.com',
    path: '/@',
    color: AppColors.tiktokBrand,
    badge: 'TT',
  );

  static const StudioPlatform generic = StudioPlatform(
    type: 'generic',
    host: '',
    path: '',
    color: AppColors.accentTealBrand,
    badge: '#',
  );

  static StudioPlatform of(String type) => switch (type) {
        'whatsapp' => whatsapp,
        'linkedin' => linkedin,
        'instagram' => instagram,
        'x' => x,
        'snapchat' => snapchat,
        'tiktok' => tiktok,
        _ => generic,
      };
}

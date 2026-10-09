import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_overlay.dart';
import '../../utils/locale_keys.dart';
import '../app_font_scope.dart';
import 'public_profile_about.dart';
import 'public_profile_catalog.dart';
import 'public_profile_connect.dart';
import 'public_profile_contact_bar.dart';
import 'public_profile_data.dart';
import 'public_profile_hero.dart';
import 'public_profile_links.dart';
import 'public_profile_meeting.dart';
import 'public_profile_powered.dart';
import 'public_profile_sticky_bar.dart';

class PublicProfileView extends StatelessWidget {
  const PublicProfileView({
    super.key,
    required this.data,
    this.actions = const PublicProfileActions(),
    this.repaintKey,
  });

  final PublicProfileData data;
  final PublicProfileActions actions;
  final GlobalKey? repaintKey;

  static void _previewNotice() =>
      AppOverlay.showSuccess(LocaleKeys.publicProfile_previewNotice.tr());

  static void _shareNotice() =>
      AppOverlay.showSuccess(LocaleKeys.publicProfile_shareNotice.tr());

  Widget? _section(PublicProfileSection section) {
    switch (section) {
      case PublicProfileSection.bio:
        return data.bio.trim().isEmpty ? null : PublicProfileAbout(data: data);
      case PublicProfileSection.catalog:
        return data.items.isEmpty
            ? null
            : PublicProfileCatalog(
                items: data.items,
                accent: data.accent,
                onItemTap: actions.onItemTap ?? (_) => _previewNotice(),
              );
      case PublicProfileSection.links:
        return data.links.isEmpty
            ? null
            : PublicProfileLinks(
                links: data.links,
                accent: data.accent,
                onTap: actions.onOpenContact ?? (_) => _previewNotice(),
              );
      case PublicProfileSection.channels:
        return data.channels.isEmpty
            ? null
            : PublicProfileConnect(
                channels: data.channels,
                accent: data.accent,
                onTap: actions.onOpenContact ?? (_) => _previewNotice(),
              );
    }
  }

  BoxDecoration get _surface => switch (data.background) {
        'white' => BoxDecoration(color: AppColors.white.themeColor),
        'gradient' => BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.profileGradientStart.themeColor,
                AppColors.profileGradientEnd.themeColor,
              ],
            ),
          ),
        _ => BoxDecoration(color: AppColors.profileSurface.themeColor),
      };

  @override
  Widget build(BuildContext context) {
    final content = DecoratedBox(
      decoration: _surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PublicProfileHero(
            data: data,
            onShare: actions.onShare ?? _shareNotice,
            onClose: actions.onClose,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                PublicProfileContactBar(
                  data: data,
                  onCall: actions.onCall ?? _previewNotice,
                  onEmail: actions.onEmail ?? _previewNotice,
                  onSaveContact: actions.onSaveContact ?? _previewNotice,
                  onShareData: actions.onShareData ?? _previewNotice,
                ),
                for (final section in data.sections)
                  if (_section(section) case final widget?) widget,
                PublicProfileMeeting(
                  buttonRadius: data.buttonRadius,
                  onTap: actions.onShareData ?? _previewNotice,
                ),
                const PublicProfilePowered(),
              ],
            ),
          ),
        ],
      ),
    );
    return AppFontScope(
      fontFamily: data.fontFamily,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: repaintKey == null
                  ? content
                  : RepaintBoundary(key: repaintKey, child: content),
            ),
          ),
          PublicProfileStickyBar(
            data: data,
            onMainContact: actions.onMainContact ?? _previewNotice,
            onSaveContact: actions.onSaveContact ?? _previewNotice,
          ),
        ],
      ),
    );
  }
}

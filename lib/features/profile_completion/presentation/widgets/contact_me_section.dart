import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_overlay.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../models/profile_completion_data.dart';
import 'channel_badge.dart';
import 'section_card.dart';
import 'social_chip.dart';

class _ChannelMeta {
  const _ChannelMeta(this.titleKey, this.badge, this.background);

  final String titleKey;
  final Widget badge;
  final Color background;

  static _ChannelMeta forType(ContactChannelType type) {
    switch (type) {
      case ContactChannelType.whatsapp:
        return _ChannelMeta(
          LocaleKeys.channels_whatsapp,
          const ChannelBadge(label: 'W', color: Color(0xFF25D366)),
          const Color(0xFFE1F5E9),
        );
      case ContactChannelType.linkedin:
        return _ChannelMeta(
          LocaleKeys.channels_linkedin,
          const ChannelBadge(label: 'in', color: Color(0xFF0A66C2)),
          const Color(0xFFE8F0FE),
        );
      case ContactChannelType.instagram:
        return _ChannelMeta(
          LocaleKeys.channels_instagram,
          const ChannelBadge(label: 'IG', color: Color(0xFFC13584)),
          const Color(0xFFFCE4EC),
        );
      case ContactChannelType.x:
        return _ChannelMeta(
          LocaleKeys.channels_x,
          const ChannelBadge(label: 'X', color: Colors.black),
          const Color(0xFFECECEC),
        );
      case ContactChannelType.snapchat:
        return _ChannelMeta(
          LocaleKeys.channels_snapchat,
          const ChannelBadge(
            label: 'SC',
            color: Color(0xFFFFFC00),
            textColor: Colors.black,
          ),
          const Color(0xFFFFFDE7),
        );
      case ContactChannelType.tiktok:
        return _ChannelMeta(
          LocaleKeys.channels_tiktok,
          const ChannelBadge(label: 'TT', color: Colors.black),
          const Color(0xFFECECEC),
        );
    }
  }
}

class ContactMeSection extends StatelessWidget {
  const ContactMeSection({super.key, required this.data});

  final ProfileCompletionData data;

  @override
  Widget build(BuildContext context) {
    final enabledTypes = data.channels.entries
        .where((e) => e.value.enabled)
        .map((e) => e.key)
        .toList();

    if (enabledTypes.isEmpty) return const SizedBox.shrink();

    return SectionCard(
      title: LocaleKeys.publish_contactMe.tr(),
      child: Wrap(
        alignment: WrapAlignment.start,
        spacing: 10.w,
        runSpacing: 10.h,
        children: [
          for (final type in enabledTypes)
            SocialChip(
              label: _ChannelMeta.forType(type).titleKey.tr(),
              badge: _ChannelMeta.forType(type).badge,
              background: _ChannelMeta.forType(type).background,
              onTap: () => AppOverlay.showSuccess(
                  LocaleKeys.common_comingSoon.tr()),
            ),
        ],
      ),
    );
  }
}
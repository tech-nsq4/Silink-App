import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:Silink/features/profile_completion/models/profile_completion_data.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widgets/channel_badge.dart';
import 'widgets/edit_field_sheet.dart';
import 'widgets/toggle_field_row.dart';

class ContactChannelsStep extends StatefulWidget {
  const ContactChannelsStep({super.key, required this.data});

  final ProfileCompletionData data;

  @override
  State<ContactChannelsStep> createState() => _ContactChannelsStepState();
}

class _ContactChannelsStepState extends State<ContactChannelsStep> {
  static const _order = ContactChannelType.values;

  String _titleFor(ContactChannelType type) {
    switch (type) {
      case ContactChannelType.whatsapp:
        return LocaleKeys.channels_whatsapp.tr();
      case ContactChannelType.linkedin:
        return LocaleKeys.channels_linkedin.tr();
      case ContactChannelType.instagram:
        return LocaleKeys.channels_instagram.tr();
      case ContactChannelType.x:
        return LocaleKeys.channels_x.tr();
      case ContactChannelType.snapchat:
        return LocaleKeys.channels_snapchat.tr();
      case ContactChannelType.tiktok:
        return LocaleKeys.channels_tiktok.tr();
    }
  }

  String _hintFor(ContactChannelType type) {
    switch (type) {
      case ContactChannelType.whatsapp:
        return LocaleKeys.channels_whatsappHint.tr();
      case ContactChannelType.linkedin:
        return LocaleKeys.channels_linkedinHint.tr();
      case ContactChannelType.instagram:
        return LocaleKeys.channels_instagramHint.tr();
      case ContactChannelType.x:
        return LocaleKeys.channels_xHint.tr();
      case ContactChannelType.snapchat:
        return LocaleKeys.channels_snapchatHint.tr();
      case ContactChannelType.tiktok:
        return LocaleKeys.channels_tiktokHint.tr();
    }
  }

  Widget _badgeFor(ContactChannelType type) {
    switch (type) {
      case ContactChannelType.whatsapp:
        return const ChannelBadge(label: 'W', color: Color(0xFF25D366));
      case ContactChannelType.linkedin:
        return const ChannelBadge(label: 'in', color: Color(0xFF0A66C2));
      case ContactChannelType.instagram:
        return const ChannelBadge(label: 'IG', color: Color(0xFFC13584));
      case ContactChannelType.x:
        return const ChannelBadge(label: 'X', color: Colors.black);
      case ContactChannelType.snapchat:
        return const ChannelBadge(
          label: 'SC',
          color: Color(0xFFFFFC00),
          textColor: Colors.black,
        );
      case ContactChannelType.tiktok:
        return const ChannelBadge(label: 'TT', color: Colors.black);
    }
  }

  Future<void> _edit(ContactChannelType type) async {
    final field = widget.data.channels[type]!;
    final result = await showEditFieldSheet(
      context,
      title: _titleFor(type),
      hint: _hintFor(type),
      initialValue: field.value,
    );
    if (result == null) return;
    setState(() {
      field.value = result;
      if (result.isNotEmpty) field.enabled = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 19.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            LocaleKeys.channels_title.tr(),
            fontSize: 20.sp,
            fontWeight: FontWeight.w800,
          ),
          4.height,
          AppText(
            LocaleKeys.channels_subtitle.tr(),
            fontSize: 14.sp,
          ),
          16.height,
          for (final type in _order) ...[
            ToggleFieldRow(
              title: _titleFor(type),
              hint: _hintFor(type),
              value: widget.data.channels[type]!.value,
              enabled: widget.data.channels[type]!.enabled,
              badge: _badgeFor(type),
              onToggle: (v) =>
                  setState(() => widget.data.channels[type]!.enabled = v),
              onEditTap: () => _edit(type),
            ),
            10.height,
          ],
        ],
      ),
    );
  }
}

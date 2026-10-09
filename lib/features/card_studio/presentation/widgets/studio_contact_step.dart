import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/locale_keys.dart';
import '../../data/models/studio_contact.dart';
import '../../data/models/studio_draft.dart';
import 'studio_editor_heading.dart';
import 'studio_labels.dart';
import 'studio_link_list.dart';
import 'studio_section_title.dart';
import 'studio_social_field.dart';

class StudioContactStep extends StatefulWidget {
  const StudioContactStep({
    super.key,
    required this.draft,
    required this.onChanged,
  });

  final StudioDraft draft;
  final ValueChanged<StudioDraft> onChanged;

  @override
  State<StudioContactStep> createState() => _StudioContactStepState();
}

class _StudioContactStepState extends State<StudioContactStep> {
  late final Map<String, TextEditingController> _channelCtrls = {
    for (final c in widget.draft.channels)
      c.type: TextEditingController(text: c.value),
  };
  late final Map<String, TextEditingController> _linkCtrls = {
    for (final l in widget.draft.links)
      l.type: TextEditingController(text: l.value),
  };

  @override
  void dispose() {
    for (final c in [..._channelCtrls.values, ..._linkCtrls.values]) {
      c.dispose();
    }
    super.dispose();
  }

  List<StudioContact> _replace(
    List<StudioContact> list,
    String type,
    StudioContact Function(StudioContact contact) change,
  ) =>
      [for (final c in list) c.type == type ? change(c) : c];

  void _updateChannel(String type, {String? value, bool? visible}) {
    final draft = widget.draft;
    widget.onChanged(draft.copyWith(
      channels: _replace(draft.channels, type,
          (c) => c.copyWith(value: value, visible: visible)),
    ));
  }

  void _updateLink(String type, {String? value, bool? visible}) {
    final draft = widget.draft;
    widget.onChanged(draft.copyWith(
      links: _replace(
          draft.links, type, (c) => c.copyWith(value: value, visible: visible)),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final draft = widget.draft;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        StudioEditorHeading(
          title: LocaleKeys.cardStudio_contactTitle.tr(),
          subtitle: LocaleKeys.cardStudio_contactSubtitle.tr(),
        ),
        for (final channel in draft.channels)
          StudioSocialField(
            label: StudioLabels.contact(channel.type),
            visible: channel.visible,
            controller: _channelCtrls[channel.type]!,
            onToggle: (v) => _updateChannel(channel.type, visible: v),
            onChanged: (v) => _updateChannel(channel.type, value: v),
          ),
        StudioSectionTitle(
          title: LocaleKeys.cardStudio_linksTitle.tr(),
          detail: LocaleKeys.cardStudio_linksSubtitle.tr(),
        ),
        StudioLinkList(
          links: draft.links,
          controllers: _linkCtrls,
          labelOf: StudioLabels.contact,
          onToggle: (type, visible) => _updateLink(type, visible: visible),
          onChanged: (type, value) => _updateLink(type, value: value),
        ),
      ],
    );
  }
}

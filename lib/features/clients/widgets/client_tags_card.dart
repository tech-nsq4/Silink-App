import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/features/clients/models/client_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'section_card.dart';

class ClientTagsCard extends StatelessWidget {
  const ClientTagsCard({
    super.key,
    required this.selectedTags,
    required this.onToggleTag,
  });

  final Set<ClientTag> selectedTags;
  final ValueChanged<ClientTag> onToggleTag;

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: LocaleKeys.clients_tags.tr(),
      children: [
        Wrap(
          spacing: 6.w,
          runSpacing: 8.h,
          children: [
            for (final tag in ClientTag.values)
              TagChip(
                label: tag.tagLabel,
              ),
          ],
        ),
      ],
    );
  }
}

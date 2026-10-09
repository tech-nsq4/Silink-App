import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/public_profile/public_profile_view.dart';
import '../../data/models/assistant_draft.dart';
import '../../../../core/widgets/creation_toolbar.dart';

class AssistantPreviewView extends StatelessWidget {
  const AssistantPreviewView({
    super.key,
    required this.draft,
    required this.onEdit,
  });

  final AssistantDraft draft;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CreationToolbar(
          hint: LocaleKeys.cardAssistant_previewHint.tr(),
          actionLabel: LocaleKeys.cardAssistant_editDraft.tr(),
          onAction: onEdit,
        ),
        Expanded(
          child: PublicProfileView(
            data: draft.toPublicProfile(
              whatsappLabel: LocaleKeys.channels_whatsapp.tr(),
            ),
          ),
        ),
      ],
    );
  }
}

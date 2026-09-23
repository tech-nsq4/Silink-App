import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/features/clients/models/client_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'section_card.dart';

class ClientSubmissionCard extends StatelessWidget {
  const ClientSubmissionCard({
    super.key,
    required this.client,
    required this.submitValue,
  });

  final ClientModel client;
  final String submitValue;

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: LocaleKeys.clients_submissionData.tr(),
      children: [
        KeyValueRow(
          label: LocaleKeys.clients_submitDate.tr(),
          value: submitValue,
        ),
        8.height,
        KeyValueRow(
          label: LocaleKeys.clients_source.tr(),
          value: client.sourceLabel,
        ),
      ],
    );
  }
}

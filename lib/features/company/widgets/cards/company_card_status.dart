import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:Silink/core/utils/locale_keys.dart';

enum CompanyCardStatus { available, active, suspended }

class CompanyCardItem {
  const CompanyCardItem({
    required this.id,
    required this.labelKey,
    required this.serial,
    required this.status,
    this.labelArgs = const <String>[],
  });

  final String id;
  final String labelKey;
  final List<String> labelArgs;
  final String serial;
  final CompanyCardStatus status;

  String get displayLabel => labelKey.tr(args: labelArgs);

  String get displayStatus => companyCardStatusLabel(status);

  CompanyCardItem copyWith({CompanyCardStatus? status}) => CompanyCardItem(
        id: id,
        labelKey: labelKey,
        labelArgs: labelArgs,
        serial: serial,
        status: status ?? this.status,
      );

  static const demoCards = <CompanyCardItem>[
    CompanyCardItem(
      id: 'c1',
      labelKey: LocaleKeys.company_card_numbered,
      labelArgs: ['001'],
      serial: 'SLK-2024-00001',
      status: CompanyCardStatus.available,
    ),
    CompanyCardItem(
      id: 'c2',
      labelKey: LocaleKeys.company_card_numbered,
      labelArgs: ['002'],
      serial: 'SLK-2024-00002',
      status: CompanyCardStatus.available,
    ),
    CompanyCardItem(
      id: 'c3',
      labelKey: LocaleKeys.company_card_numbered,
      labelArgs: ['003'],
      serial: 'SLK-2024-00003',
      status: CompanyCardStatus.active,
    ),
    CompanyCardItem(
      id: 'c4',
      labelKey: LocaleKeys.company_card_numbered,
      labelArgs: ['004'],
      serial: 'SLK-2024-00004',
      status: CompanyCardStatus.suspended,
    ),
  ];
}

Color companyCardStatusColor(CompanyCardStatus status) => switch (status) {
      CompanyCardStatus.available => const Color(0xFF0D9488),
      CompanyCardStatus.active => const Color(0xFF0D9488),
      CompanyCardStatus.suspended => const Color(0xFF64748B),
    };

String companyCardStatusLabel(CompanyCardStatus status) => switch (status) {
      CompanyCardStatus.available => LocaleKeys.company_status_available.tr(),
      CompanyCardStatus.active => LocaleKeys.company_status_active.tr(),
      CompanyCardStatus.suspended => LocaleKeys.company_status_disabled.tr(),
    };

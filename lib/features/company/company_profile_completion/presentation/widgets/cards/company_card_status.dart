import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:Silink/core/utils/app_colors.dart';
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

  String get displayLabel => LocaleKeys.companyHub_cardName.tr(args: labelArgs);

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
      serial: 'NFC-CO-001',
      status: CompanyCardStatus.available,
    ),
    CompanyCardItem(
      id: 'c2',
      labelKey: LocaleKeys.company_card_numbered,
      labelArgs: ['002'],
      serial: 'NFC-CO-002',
      status: CompanyCardStatus.available,
    ),
    CompanyCardItem(
      id: 'c3',
      labelKey: LocaleKeys.company_card_numbered,
      labelArgs: ['003'],
      serial: 'NFC-CO-003',
      status: CompanyCardStatus.active,
    ),
    CompanyCardItem(
      id: 'c4',
      labelKey: LocaleKeys.company_card_numbered,
      labelArgs: ['004'],
      serial: 'NFC-CO-004',
      status: CompanyCardStatus.suspended,
    ),
  ];
}

Color companyCardStatusColor(CompanyCardStatus status) => switch (status) {
      CompanyCardStatus.suspended => AppColors.textSecondaryColor.themeColor,
      _ => AppColors.accentTeal.themeColor,
    };

String companyCardStatusLabel(CompanyCardStatus status) => switch (status) {
      CompanyCardStatus.available => LocaleKeys.companyHub_statAvailable.tr(),
      CompanyCardStatus.active => LocaleKeys.companyHub_statActive.tr(),
      CompanyCardStatus.suspended => LocaleKeys.companyHub_statSuspended.tr(),
    };

String companyCardStatusHint(CompanyCardStatus status) => switch (status) {
      CompanyCardStatus.available => LocaleKeys.companyHub_cardReady.tr(),
      CompanyCardStatus.active => LocaleKeys.companyHub_cardLinked.tr(),
      CompanyCardStatus.suspended => LocaleKeys.companyHub_cardPaused.tr(),
    };

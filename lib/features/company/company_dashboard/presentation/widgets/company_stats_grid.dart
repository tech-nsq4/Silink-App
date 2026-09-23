import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'company_stat_tile.dart';

class CompanyStatsGrid extends StatelessWidget {
  const CompanyStatsGrid({
    super.key,
    required this.employees,
    required this.cards,
  });

  final int employees;
  final int cards;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CompanyStatTile(
            value: '$employees',
            label: LocaleKeys.company_employees.tr(),
            icon: Icons.people_outline_rounded,
          ),
        ),
        10.width,
        Expanded(
          child: CompanyStatTile(
            value: '$cards',
            label: LocaleKeys.company_cards.tr(),
            icon: Icons.credit_card_rounded,
          ),
        ),
        10.width,
        Expanded(
          child: CompanyStatTile(
            value: '57',
            label: LocaleKeys.company_fans.tr(),
            icon: Icons.favorite_border_rounded,
          ),
        ),
      ],
    );
  }
}

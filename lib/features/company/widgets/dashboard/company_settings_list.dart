import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:Silink/core/utils/locale_keys.dart';
import '../company_field.dart';
import 'company_settings_tile.dart';

class CompanySettingsList extends StatelessWidget {
  const CompanySettingsList({
    super.key,
    required this.onCards,
    required this.onBrand,
    required this.onCatalog,
    required this.onEmployees,
    required this.onQr,
    required this.onPublish,
    required this.onEdit,
  });

  final VoidCallback onCards;
  final VoidCallback onBrand;
  final VoidCallback onCatalog;
  final VoidCallback onEmployees;
  final VoidCallback onQr;
  final VoidCallback onPublish;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    return CompanySectionCard(
      title: LocaleKeys.company_settings.tr(),
      child: Column(
        children: [
          CompanySettingsTile(
            icon: Icons.credit_card_rounded,
            label: LocaleKeys.company_cards.tr(),
            onTap: onCards,
          ),
          CompanySettingsTile(
            icon: Icons.palette_outlined,
            label: LocaleKeys.company_brand.tr(),
            onTap: onBrand,
          ),
          CompanySettingsTile(
            icon: Icons.grid_view_rounded,
            label: LocaleKeys.company_catalog.tr(),
            onTap: onCatalog,
          ),
          CompanySettingsTile(
            icon: Icons.people_outline_rounded,
            label: LocaleKeys.company_employees.tr(),
            onTap: onEmployees,
          ),
          CompanySettingsTile(
            icon: Icons.qr_code_rounded,
            label: LocaleKeys.company_qr.tr(),
            onTap: onQr,
          ),
          CompanySettingsTile(
            icon: Icons.publish_rounded,
            label: LocaleKeys.company_publish.tr(),
            onTap: onPublish,
          ),
          CompanySettingsTile(
            icon: Icons.edit_outlined,
            label: LocaleKeys.company_edit.tr(),
            onTap: onEdit,
          ),
        ],
      ),
    );
  }
}

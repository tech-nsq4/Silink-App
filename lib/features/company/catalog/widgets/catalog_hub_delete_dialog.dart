import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CatalogHubDeleteDialog extends StatelessWidget {
  const CatalogHubDeleteDialog({super.key});

  static Future<bool> show(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => const CatalogHubDeleteDialog(),
    );
    return confirmed == true;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: AppText(LocaleKeys.catalogHub_deleteConfirm.tr()),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: AppText(LocaleKeys.catalogHub_cancel.tr()),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: AppText(
            LocaleKeys.catalogHub_delete.tr(),
            color: AppColors.errorColor.themeColor,
          ),
        ),
      ],
    );
  }
}

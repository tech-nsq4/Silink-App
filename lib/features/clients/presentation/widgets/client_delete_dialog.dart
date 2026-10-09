import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_text.dart';

class ClientDeleteDialog extends StatelessWidget {
  const ClientDeleteDialog({super.key});

  static Future<bool> show(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => const ClientDeleteDialog(),
    );
    return confirmed == true;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: AppText(LocaleKeys.clients_deleteConfirmTitle.tr()),
      content: AppText(LocaleKeys.clients_deleteConfirmMessage.tr()),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: AppText(LocaleKeys.common_cancel.tr()),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: AppText(
            LocaleKeys.common_delete.tr(),
            color: AppColors.errorColor.themeColor,
          ),
        ),
      ],
    );
  }
}

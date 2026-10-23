import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_text.dart';

class SettingsConfirmDialog extends StatelessWidget {
  const SettingsConfirmDialog({
    super.key,
    required this.title,
    required this.message,
  });

  final String title;
  final String message;

  static Future<bool> show(
    BuildContext context, {
    required String title,
    required String message,
  }) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => SettingsConfirmDialog(title: title, message: message),
    );
    return confirmed == true;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: AppText(title, fontWeight: FontWeight.w800),
      content: AppText(message, height: 1.6),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: AppText(LocaleKeys.settings_cancel.tr()),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: AppText(
            LocaleKeys.settings_confirm.tr(),
            fontWeight: FontWeight.w800,
            color: AppColors.errorColor.themeColor,
          ),
        ),
      ],
    );
  }
}

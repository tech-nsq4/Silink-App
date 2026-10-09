import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_images.dart';
import '../../../../core/utils/locale_keys.dart';
import 'client_action_button.dart';

class ClientQuickActions extends StatelessWidget {
  const ClientQuickActions({
    super.key,
    required this.onCall,
    required this.onWhatsapp,
    required this.onEmail,
    required this.onSaveContact,
  });

  final VoidCallback onCall;
  final VoidCallback onWhatsapp;
  final VoidCallback? onEmail;
  final VoidCallback onSaveContact;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: ClientActionButton(
                label: LocaleKeys.clients_call.tr(),
                icon: AppImages.iconsCall,
                color: AppColors.mint.themeColor,
                onTap: onCall,
              ),
            ),
            12.width,
            Expanded(
              child: ClientActionButton(
                label: LocaleKeys.clients_whatsapp.tr(),
                icon: AppImages.iconsChat,
                color: AppColors.whatsapp.themeColor,
                onTap: onWhatsapp,
              ),
            ),
          ],
        ),
        12.height,
        Row(
          children: [
            Expanded(
              child: ClientActionButton(
                label: LocaleKeys.clients_sendEmail.tr(),
                icon: AppImages.iconsGmail,
                color: AppColors.blue.themeColor,
                onTap: onEmail,
              ),
            ),
            12.width,
            Expanded(
              child: ClientActionButton(
                label: LocaleKeys.clients_saveContact.tr(),
                icon: AppImages.iconsSave,
                color: AppColors.purple.themeColor,
                onTap: onSaveContact,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

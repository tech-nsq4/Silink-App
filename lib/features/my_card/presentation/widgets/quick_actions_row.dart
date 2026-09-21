import 'package:Silink/core/utils/app_images.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_overlay.dart';
import '../../../../core/utils/locale_keys.dart';
import 'profile_action_button.dart';

class QuickActionsRow extends StatelessWidget {
  const QuickActionsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ProfileActionButton(
            icon: AppImages.iconsCall,
            label: LocaleKeys.publish_call.tr(),
            backgroundColor: AppColors.mint.themeColor,
            onTap: () =>
                AppOverlay.showSuccess(LocaleKeys.common_comingSoon.tr()),
          ),
        ),
        Expanded(
          child: ProfileActionButton(
            icon: AppImages.iconsChat,
            label: LocaleKeys.publish_whatsapp.tr(),
            backgroundColor: const Color(0xFF25D366),
            onTap: () =>
                AppOverlay.showSuccess(LocaleKeys.common_comingSoon.tr()),
          ),
        ),
        Expanded(
          child: ProfileActionButton(
            icon: AppImages.iconsGmail,
            label: LocaleKeys.publish_cardEmail.tr(),
            backgroundColor: AppColors.mint.themeColor,
            onTap: () =>
                AppOverlay.showSuccess(LocaleKeys.common_comingSoon.tr()),
          ),
        ),
        Expanded(
          child: ProfileActionButton(
            icon: AppImages.iconsContacts,
            label: LocaleKeys.publish_saveContact.tr(),
            backgroundColor: const Color(0xFF17212B),
            onTap: () =>
                AppOverlay.showSuccess(LocaleKeys.common_comingSoon.tr()),
          ),
        ),
      ],
    );
  }
}

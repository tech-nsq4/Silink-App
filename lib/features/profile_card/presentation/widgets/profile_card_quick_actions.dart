import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/app_images.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/features/profile_card/data/models/profile_card_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'profile_card_action_button.dart';

class ProfileCardQuickActions extends StatelessWidget {
  const ProfileCardQuickActions({
    super.key,
    required this.card,
    required this.primaryColor,
    required this.fontFamily,
    required this.onCall,
    required this.onWhatsapp,
    required this.onEmail,
    required this.onSaveContact,
  });

  final ProfileCardModel card;
  final Color primaryColor;
  final String? fontFamily;
  final VoidCallback onCall;
  final VoidCallback onWhatsapp;
  final VoidCallback onEmail;
  final VoidCallback onSaveContact;

  @override
  Widget build(BuildContext context) {
    final shape = card.appearance.buttonShape;

    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 6.w,
      runSpacing: 12.h,
      children: [
        if (card.basic.phone.trim().isNotEmpty)
          ProfileCardActionButton(
            icon: AppImages.iconsCall,
            label: LocaleKeys.publish_call.tr(),
            color: primaryColor,
            buttonShape: shape,
            fontFamily: fontFamily,
            onTap: onCall,
          ),
        if (card.whatsapp != null)
          ProfileCardActionButton(
            icon: AppImages.iconsChat,
            label: LocaleKeys.publish_whatsapp.tr(),
            color: AppColors.whatsapp.themeColor,
            buttonShape: shape,
            fontFamily: fontFamily,
            onTap: onWhatsapp,
          ),
        if (card.basic.email.trim().isNotEmpty)
          ProfileCardActionButton(
            icon: AppImages.iconsGmail,
            label: LocaleKeys.publish_cardEmail.tr(),
            color: primaryColor,
            buttonShape: shape,
            fontFamily: fontFamily,
            onTap: onEmail,
          ),
        ProfileCardActionButton(
          icon: AppImages.iconsContacts,
          label: LocaleKeys.publish_saveContact.tr(),
          color: AppColors.profileCardSaveContact.themeColor,
          buttonShape: shape,
          fontFamily: fontFamily,
          onTap: onSaveContact,
        ),
      ],
    );
  }
}

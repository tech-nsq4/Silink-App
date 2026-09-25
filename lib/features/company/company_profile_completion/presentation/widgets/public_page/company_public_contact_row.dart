import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/app_images.dart';
import 'package:Silink/core/utils/locale_keys.dart';

import 'company_public_contact_button.dart';

class CompanyPublicContactRow extends StatelessWidget {
  const CompanyPublicContactRow({
    super.key,
    required this.onCall,
    required this.onWhatsapp,
    required this.onEmail,
    required this.onWebsite,
    required this.onSaveContact,
  });

  final VoidCallback onCall;
  final VoidCallback onWhatsapp;
  final VoidCallback onEmail;
  final VoidCallback onWebsite;
  final VoidCallback onSaveContact;

  @override
  Widget build(BuildContext context) {
    final brand = AppColors.companyBrand.themeColor;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CompanyPublicContactButton(
          icon: AppImages.iconsCall,
          label: LocaleKeys.publish_call.tr(),
          background: brand,
          onTap: onCall,
        ),
        CompanyPublicContactButton(
          icon: AppImages.iconsChat,
          label: LocaleKeys.publish_whatsapp.tr(),
          background: AppColors.whatsapp.themeColor,
          onTap: onWhatsapp,
        ),
        CompanyPublicContactButton(
          icon: AppImages.iconsGmail,
          label: LocaleKeys.publish_cardEmail.tr(),
          background: brand,
          onTap: onEmail,
        ),
        CompanyPublicContactButton(
          icon: AppImages.iconsInternet,
          label: LocaleKeys.company_website_short.tr(),
          background: AppColors.darkSlate.themeColor,
          onTap: onWebsite,
        ),
        CompanyPublicContactButton(
          icon: AppImages.iconsContacts,
          label: LocaleKeys.company_add_contact.tr(),
          background: AppColors.purple.themeColor,
          onTap: onSaveContact,
        ),
      ],
    );
  }
}

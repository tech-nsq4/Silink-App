import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/app_images.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'company_quick_action_item.dart';

class CompanyQuickActions extends StatelessWidget {
  const CompanyQuickActions({
    super.key,
    required this.isPublished,
    this.catalogLabel,
    required this.onPrimary,
    required this.onQr,
    required this.onInvite,
    required this.onEmployees,
    required this.onCards,
    required this.onCatalog,
    required this.onEdit,
    required this.onBrand,
  });

  final bool isPublished;
  final String? catalogLabel;
  final VoidCallback onPrimary;
  final VoidCallback onQr;
  final VoidCallback onInvite;
  final VoidCallback onEmployees;
  final VoidCallback onCards;
  final VoidCallback onCatalog;
  final VoidCallback onEdit;
  final VoidCallback onBrand;

  @override
  Widget build(BuildContext context) {
    final items = <_QuickEntry>[
      _QuickEntry(
        label: isPublished
            ? LocaleKeys.company_view_page.tr()
            : LocaleKeys.company_publish_page.tr(),
        iconAsset: AppImages.iconsInternet,
        onTap: onPrimary,
      ),
      if (isPublished)
        _QuickEntry(
          label: LocaleKeys.company_qr.tr(),
          iconAsset: AppImages.iconsQrCode,
          onTap: onQr,
        ),
      _QuickEntry(
        label: LocaleKeys.company_invite_title.tr(),
        iconAsset: AppImages.iconsContacts,
        onTap: onInvite,
      ),
      _QuickEntry(
        label: LocaleKeys.company_employees_title.tr(),
        iconAsset: AppImages.iconsClients,
        onTap: onEmployees,
      ),
      _QuickEntry(
        label: LocaleKeys.company_cards_page_title.tr(),
        iconAsset: AppImages.iconsCard,
        onTap: onCards,
      ),
      _QuickEntry(
        label: catalogLabel ?? LocaleKeys.company_menu_title.tr(),
        iconAsset: AppImages.iconsFood,
        onTap: onCatalog,
      ),
      _QuickEntry(
        label: LocaleKeys.company_edit_data_title.tr(),
        iconAsset: AppImages.iconsEdit,
        onTap: onEdit,
      ),
      _QuickEntry(
        label: LocaleKeys.company_brand_identity_title.tr(),
        iconAsset: AppImages.iconsCompany,
        onTap: onBrand,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.only(start: 4.w, bottom: 8.h),
          child: AppText(
            LocaleKeys.company_quick_procedures.tr(),
            fontSize: 12.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.textSecondaryColor.themeColor,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.cardColor.themeColor,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: AppColors.borderColor.themeColor),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              for (var i = 0; i < items.length; i++)
                CompanyQuickActionItem(
                  iconAsset: items[i].iconAsset,
                  label: items[i].label,
                  onTap: items[i].onTap,
                  showDivider: i != items.length - 1,
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _QuickEntry {
  const _QuickEntry({
    required this.label,
    required this.iconAsset,
    required this.onTap,
  });

  final String label;
  final String iconAsset;
  final VoidCallback onTap;
}

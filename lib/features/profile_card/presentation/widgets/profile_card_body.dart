import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/convert_helper.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/features/profile_card/data/models/profile_card_contact_item.dart';
import 'package:Silink/features/profile_card/data/models/profile_card_model.dart';
import 'package:Silink/features/profile_card/data/models/profile_card_product.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'profile_card_about_card.dart';
import 'profile_card_cover.dart';
import 'profile_card_identity.dart';
import 'profile_card_link_tile.dart';
import 'profile_card_products_list.dart';
import 'profile_card_quick_actions.dart';
import 'profile_card_section_title.dart';
import 'profile_card_social_channels.dart';

class ProfileCardBody extends StatelessWidget {
  const ProfileCardBody({
    super.key,
    required this.card,
    required this.onCall,
    required this.onWhatsapp,
    required this.onEmail,
    required this.onSaveContact,
    required this.onOpenContact,
    required this.onProductTap,
    required this.onViewAllProducts,
    required this.repaintKey,
    required this.footer,
  });

  final ProfileCardModel card;
  final VoidCallback onCall;
  final VoidCallback onWhatsapp;
  final VoidCallback onEmail;
  final VoidCallback onSaveContact;
  final ValueChanged<ProfileCardContactItem> onOpenContact;
  final ValueChanged<ProfileCardProduct> onProductTap;
  final VoidCallback? onViewAllProducts;
  final GlobalKey repaintKey;
  final Widget footer;

  static String? fontFamilyOf(ProfileCardModel card) {
    final family = card.appearance.fontFamily.trim();
    return family.isEmpty ? null : family;
  }

  static Color primaryColorOf(ProfileCardModel card) =>
      ConvertHelper.hexToColor(
        card.appearance.primaryColor,
        fallback: AppColors.mint.themeColor,
      );

  String? get _fontFamily => fontFamilyOf(card);

  Color get _primaryColor => primaryColorOf(card);

  Color get _coverColor => ConvertHelper.hexToColor(
        card.appearance.coverColor,
        fallback: _primaryColor,
      );

  BoxDecoration get _backgroundDecoration {
    final white = AppColors.white.themeColor;
    return switch (card.appearance.background) {
      'light' =>
        BoxDecoration(color: AppColors.profileCardLightBackground.themeColor),
      'gradient' => BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [_primaryColor.withValues(alpha: 0.08), white],
          ),
        ),
      _ => BoxDecoration(color: white),
    };
  }

  Color get _footerColor => card.appearance.background == 'light'
      ? AppColors.profileCardLightBackground.themeColor
      : AppColors.white.themeColor;

  bool get _hasChannelsSection =>
      card.sections.any((s) => s.type == ProfileCardSectionType.channels);

  Widget _padded(Widget child) =>
      Padding(padding: 16.paddingHorizontal, child: child);

  Widget _quickActions() => _padded(
        ProfileCardQuickActions(
          card: card,
          primaryColor: _primaryColor,
          fontFamily: _fontFamily,
          onCall: onCall,
          onWhatsapp: onWhatsapp,
          onEmail: onEmail,
          onSaveContact: onSaveContact,
        ),
      );

  List<Widget> _sectionWidgets(ProfileCardSection section) {
    final primary = _primaryColor;
    final font = _fontFamily;

    switch (section.type) {
      case ProfileCardSectionType.bio:
        if (card.bio.trim().isEmpty) return const [];
        return [
          _padded(ProfileCardAboutCard(bio: card.bio, fontFamily: font)),
        ];
      case ProfileCardSectionType.channels:
        final socials = card.socialChannels;
        return [
          _quickActions(),
          if (socials.isNotEmpty) ...[
            16.height,
            _padded(
              ProfileCardSocialChannels(
                channels: socials,
                primaryColor: primary,
                fontFamily: font,
                onTap: onOpenContact,
              ),
            ),
          ],
        ];
      case ProfileCardSectionType.links:
        final links = card.visibleLinks;
        if (links.isEmpty) return const [];
        return [
          _padded(
            ProfileCardSectionTitle(
              title: section.label.isEmpty
                  ? LocaleKeys.publish_contactLinks.tr()
                  : section.label,
              fontFamily: font,
            ),
          ),
          12.height,
          for (int i = 0; i < links.length; i++) ...[
            if (i > 0) 8.height,
            _padded(
              ProfileCardLinkTile(
                link: links[i],
                primaryColor: primary,
                fontFamily: font,
                onTap: () => onOpenContact(links[i]),
              ),
            ),
          ],
        ];
      case ProfileCardSectionType.products:
      case ProfileCardSectionType.services:
        if (!card.isFirstCatalogSection(section)) return const [];
        final products = card.activeCatalogItems;
        if (products.isEmpty) return const [];
        return [
          _padded(Divider(height: 1, color: AppColors.dividerColor.themeColor)),
          20.height,
          _padded(
            ProfileCardSectionTitle(
              title: LocaleKeys.publish_productsAndServices.tr(),
              fontFamily: font,
              actionLabel: LocaleKeys.publish_viewAll.tr(),
              actionColor: primary,
              onAction: onViewAllProducts,
            ),
          ),
          12.height,
          ProfileCardProductsList(
            products: products,
            primaryColor: primary,
            fontFamily: font,
            onProductTap: onProductTap,
          ),
        ];
      case ProfileCardSectionType.basic:
      case ProfileCardSectionType.unknown:
        return const [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final sectionBlocks = [
      if (!_hasChannelsSection) [_quickActions()],
      for (final section in card.sections) _sectionWidgets(section),
    ].where((block) => block.isNotEmpty).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        RepaintBoundary(
          key: repaintKey,
          child: Container(
            decoration: _backgroundDecoration,
            padding: EdgeInsets.only(bottom: 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ProfileCardCover(
                  coverColor: _coverColor,
                  primaryColor: _primaryColor,
                  fullName: card.basic.fullName,
                  photoUrl: card.basic.photoUrl,
                  fontFamily: _fontFamily,
                ),
                14.height,
                ProfileCardIdentity(
                  fullName: card.basic.fullName,
                  jobTitle: card.basic.jobTitle,
                  company: card.basic.company,
                  fontFamily: _fontFamily,
                ),
                for (final block in sectionBlocks) ...[
                  24.height,
                  ...block,
                ],
              ],
            ),
          ),
        ),
        Container(color: _footerColor, child: footer),
      ],
    );
  }
}

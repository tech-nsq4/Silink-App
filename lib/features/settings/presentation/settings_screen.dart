import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/router/routes.dart';
import '../../../core/extensions/extensions.dart';
import '../../../core/utils/app_images.dart';
import '../../../core/utils/locale_keys.dart';
import '../../../core/widgets/screen_header_bar.dart';
import '../../account/widgets/account_menu_tile.dart';
import '../../account/widgets/account_section_card.dart';
import '../data/models/static_page_content.dart';
import 'widgets/settings_group_title.dart';
import 'widgets/settings_language_sheet.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  void _openPage(BuildContext context, StaticPageType type) =>
      context.pushNamed(Routes.staticPageScreen, arguments: {'type': type});

  @override
  Widget build(BuildContext context) {
    final currentLanguage = context.locale.languageCode == 'en'
        ? LocaleKeys.settings_english.tr()
        : LocaleKeys.settings_arabic.tr();

    return Scaffold(
      body: Column(
        children: [
          ScreenHeaderBar(title: LocaleKeys.settings_title.tr()),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 19.w, vertical: 16.h),
              children: [
                SettingsGroupTitle(LocaleKeys.settings_generalSection.tr()),
                AccountSectionCard(
                  children: [
                    AccountMenuTile(
                      icon: AppImages.iconsInternet,
                      label: LocaleKeys.settings_changeLanguage.tr(),
                      value: currentLanguage,
                      onTap: () => SettingsLanguageSheet.show(context),
                    ),
                    AccountMenuTile(
                      icon: AppImages.iconsPrivacy,
                      label: LocaleKeys.settings_privacySecurity.tr(),
                      onTap: () =>
                          _openPage(context, StaticPageType.privacySecurity),
                    ),
                  ],
                ),
                20.height,
                SettingsGroupTitle(LocaleKeys.settings_legalSection.tr()),
                AccountSectionCard(
                  children: [
                    AccountMenuTile(
                      icon: AppImages.iconsDoc,
                      label: LocaleKeys.settings_terms.tr(),
                      onTap: () =>
                          _openPage(context, StaticPageType.termsOfUse),
                    ),
                    AccountMenuTile(
                      icon: AppImages.iconsLock,
                      label: LocaleKeys.settings_privacyPolicy.tr(),
                      onTap: () =>
                          _openPage(context, StaticPageType.privacyPolicy),
                    ),
                    AccountMenuTile(
                      icon: AppImages.iconsInfo,
                      label: LocaleKeys.settings_about.tr(),
                      onTap: () => _openPage(context, StaticPageType.aboutUs),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

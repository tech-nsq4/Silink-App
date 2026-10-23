import '../../../../core/utils/locale_keys.dart';

enum StaticPageType { termsOfUse, privacyPolicy, aboutUs }

extension StaticPageTypeX on StaticPageType {
  String get slug => switch (this) {
        StaticPageType.termsOfUse => 'terms',
        StaticPageType.privacyPolicy => 'privacy',
        StaticPageType.aboutUs => 'about',
      };

  String get titleKey => switch (this) {
        StaticPageType.termsOfUse => LocaleKeys.settings_terms,
        StaticPageType.privacyPolicy => LocaleKeys.settings_privacyPolicy,
        StaticPageType.aboutUs => LocaleKeys.settings_about,
      };
}

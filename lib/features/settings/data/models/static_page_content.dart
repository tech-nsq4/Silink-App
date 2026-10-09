import 'package:equatable/equatable.dart';

import '../../../../core/utils/locale_keys.dart';

enum StaticPageType { privacySecurity, termsOfUse, privacyPolicy, aboutUs }

class StaticPageSection extends Equatable {
  const StaticPageSection(this.titleKey, this.bodyKey);

  final String titleKey;
  final String bodyKey;

  @override
  List<Object?> get props => [titleKey, bodyKey];
}

class StaticPageContent extends Equatable {
  const StaticPageContent({
    required this.titleKey,
    required this.introKey,
    required this.sections,
  });

  final String titleKey;
  final String introKey;
  final List<StaticPageSection> sections;

  factory StaticPageContent.of(StaticPageType type) => switch (type) {
        StaticPageType.privacySecurity => _privacySecurity,
        StaticPageType.termsOfUse => _termsOfUse,
        StaticPageType.privacyPolicy => _privacyPolicy,
        StaticPageType.aboutUs => _aboutUs,
      };

  static const _privacySecurity = StaticPageContent(
    titleKey: LocaleKeys.settings_privacySecurity,
    introKey: LocaleKeys.security_intro,
    sections: [
      StaticPageSection(
          LocaleKeys.security_accountTitle, LocaleKeys.security_accountBody),
      StaticPageSection(LocaleKeys.security_encryptionTitle,
          LocaleKeys.security_encryptionBody),
      StaticPageSection(LocaleKeys.security_visibilityTitle,
          LocaleKeys.security_visibilityBody),
      StaticPageSection(
          LocaleKeys.security_cardsTitle, LocaleKeys.security_cardsBody),
      StaticPageSection(
          LocaleKeys.security_paymentsTitle, LocaleKeys.security_paymentsBody),
      StaticPageSection(
          LocaleKeys.security_tipsTitle, LocaleKeys.security_tipsBody),
      StaticPageSection(
          LocaleKeys.security_reportTitle, LocaleKeys.security_reportBody),
    ],
  );

  static const _termsOfUse = StaticPageContent(
    titleKey: LocaleKeys.settings_terms,
    introKey: LocaleKeys.terms_intro,
    sections: [
      StaticPageSection(
          LocaleKeys.terms_acceptanceTitle, LocaleKeys.terms_acceptanceBody),
      StaticPageSection(
          LocaleKeys.terms_accountTitle, LocaleKeys.terms_accountBody),
      StaticPageSection(
          LocaleKeys.terms_usageTitle, LocaleKeys.terms_usageBody),
      StaticPageSection(
          LocaleKeys.terms_contentTitle, LocaleKeys.terms_contentBody),
      StaticPageSection(
          LocaleKeys.terms_ordersTitle, LocaleKeys.terms_ordersBody),
      StaticPageSection(LocaleKeys.terms_ipTitle, LocaleKeys.terms_ipBody),
      StaticPageSection(
          LocaleKeys.terms_terminationTitle, LocaleKeys.terms_terminationBody),
      StaticPageSection(
          LocaleKeys.terms_liabilityTitle, LocaleKeys.terms_liabilityBody),
      StaticPageSection(
          LocaleKeys.terms_changesTitle, LocaleKeys.terms_changesBody),
      StaticPageSection(LocaleKeys.terms_lawTitle, LocaleKeys.terms_lawBody),
    ],
  );

  static const _privacyPolicy = StaticPageContent(
    titleKey: LocaleKeys.settings_privacyPolicy,
    introKey: LocaleKeys.privacy_intro,
    sections: [
      StaticPageSection(
          LocaleKeys.privacy_collectTitle, LocaleKeys.privacy_collectBody),
      StaticPageSection(
          LocaleKeys.privacy_usageTitle, LocaleKeys.privacy_usageBody),
      StaticPageSection(
          LocaleKeys.privacy_sharingTitle, LocaleKeys.privacy_sharingBody),
      StaticPageSection(
          LocaleKeys.privacy_securityTitle, LocaleKeys.privacy_securityBody),
      StaticPageSection(
          LocaleKeys.privacy_rightsTitle, LocaleKeys.privacy_rightsBody),
      StaticPageSection(
          LocaleKeys.privacy_updatesTitle, LocaleKeys.privacy_updatesBody),
      StaticPageSection(
          LocaleKeys.privacy_contactTitle, LocaleKeys.privacy_contactBody),
    ],
  );

  static const _aboutUs = StaticPageContent(
    titleKey: LocaleKeys.settings_about,
    introKey: LocaleKeys.about_intro,
    sections: [
      StaticPageSection(
          LocaleKeys.about_offerTitle, LocaleKeys.about_offerBody),
      StaticPageSection(
          LocaleKeys.about_individualsTitle, LocaleKeys.about_individualsBody),
      StaticPageSection(
          LocaleKeys.about_companiesTitle, LocaleKeys.about_companiesBody),
      StaticPageSection(
          LocaleKeys.about_missionTitle, LocaleKeys.about_missionBody),
      StaticPageSection(
          LocaleKeys.about_visionTitle, LocaleKeys.about_visionBody),
      StaticPageSection(
          LocaleKeys.about_contactTitle, LocaleKeys.about_contactBody),
    ],
  );

  @override
  List<Object?> get props => [titleKey, introKey, sections];
}

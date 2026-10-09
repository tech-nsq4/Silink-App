import 'package:easy_localization/easy_localization.dart';

import '../../../../core/utils/locale_keys.dart';

abstract final class StudioLabels {
  static String contact(String type) => switch (type) {
        'whatsapp' => LocaleKeys.channels_whatsapp.tr(),
        'linkedin' => LocaleKeys.channels_linkedin.tr(),
        'instagram' => LocaleKeys.channels_instagram.tr(),
        'x' => LocaleKeys.channels_x.tr(),
        'snapchat' => LocaleKeys.channels_snapchat.tr(),
        'tiktok' => LocaleKeys.channels_tiktok.tr(),
        'website' => LocaleKeys.links_website.tr(),
        'portfolio' => LocaleKeys.links_portfolio.tr(),
        'booking' => LocaleKeys.links_booking.tr(),
        'quote' => LocaleKeys.links_quote.tr(),
        'profile' => LocaleKeys.links_brochure.tr(),
        _ => LocaleKeys.links_customLink.tr(),
      };

  static String section(String type) => switch (type) {
        'bio' => LocaleKeys.cardStudio_sectionBio.tr(),
        'services' => LocaleKeys.cardStudio_sectionServices.tr(),
        'products' => LocaleKeys.cardStudio_sectionProducts.tr(),
        'links' => LocaleKeys.cardStudio_sectionLinks.tr(),
        _ => LocaleKeys.cardStudio_sectionChannels.tr(),
      };

  static String template(String type) => switch (type) {
        'simple' => LocaleKeys.cardStudio_templateSimple.tr(),
        'personal' => LocaleKeys.cardStudio_templatePersonal.tr(),
        _ => LocaleKeys.cardStudio_templatePro.tr(),
      };

  static String background(String type) => switch (type) {
        'light' => LocaleKeys.cardStudio_backgroundLight.tr(),
        'gradient' => LocaleKeys.cardStudio_backgroundGradient.tr(),
        _ => LocaleKeys.cardStudio_backgroundWhite.tr(),
      };

  static String shape(String type) => switch (type) {
        'pill' => LocaleKeys.cardStudio_shapePill.tr(),
        'square' => LocaleKeys.cardStudio_shapeSquare.tr(),
        _ => LocaleKeys.cardStudio_shapeRounded.tr(),
      };
}

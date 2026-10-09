import 'package:Silink/app/router/navigation_services.dart';
import 'package:flutter/material.dart';

class ColorModel {
  final Color lightColor;
  final Color darkColor;

  const ColorModel({required this.lightColor, required this.darkColor});

  Color get light => lightColor;
  Color get dark => darkColor;
}

extension ColorTheme on ColorModel {
  Color get themeColor {
    final context = NavigationService.navigationKey.currentContext;
    if (context != null && Theme.of(context).brightness == Brightness.dark) {
      return darkColor;
    } else {
      return lightColor;
    }
  }
}

class AppColors {
  AppColors._();

  static const ColorModel primaryColor = ColorModel(
    lightColor: Color(0xff0a3320),
    darkColor: Color(0xff0a3320),
  );

  static const ColorModel secondaryColor = ColorModel(
    lightColor: Color(0xff1B5583),
    darkColor: Color(0xff1B5583),
  );

  static const ColorModel backgroundColor = ColorModel(
    lightColor: Color(0xFFF4F8F9),
    darkColor: Color(0xff121212),
  );

  static const ColorModel surfaceColor = ColorModel(
    lightColor: Color(0xffF5F5F5),
    darkColor: Color(0xff1E1E1E),
  );

  static const ColorModel textPrimaryColor = ColorModel(
    lightColor: Color(0xFF143440),
    darkColor: Color(0xffFFFFFF),
  );

  static const ColorModel textSecondaryColor = ColorModel(
    lightColor: Color(0xFF819BA4),
    darkColor: Color(0xffB0B0B0),
  );

  static const ColorModel errorColor = ColorModel(
    lightColor: Color(0xffD32F2F),
    darkColor: Color(0xffEF5350),
  );

  static const ColorModel successColor = ColorModel(
    lightColor: Color(0xFF0d9488),
    darkColor: Color(0xff66BB6A),
  );

  static const ColorModel dividerColor = ColorModel(
    lightColor: Color(0xffE0E0E0),
    darkColor: Color(0xff424242),
  );

  static const ColorModel hintColor = ColorModel(
    lightColor: Color(0xffBDBDBD),
    darkColor: Color(0xff616161),
  );

  static const ColorModel cardColor = ColorModel(
    lightColor: Color(0xffFFFFFF),
    darkColor: Color(0xff2C2C2C),
  );
  static const ColorModel white = ColorModel(
    lightColor: Color(0xffFFFFFF),
    darkColor: Color(0xff121212),
  );
  static const ColorModel black = ColorModel(
    lightColor: Color(0xff000000),
    darkColor: Color(0xffFFFFFF),
  );
  static const Color fieldFill = Color(0xFFF1F5F9);

  /// Golden accent — used for the final onboarding CTA button.
  static const ColorModel accentGold = ColorModel(
    lightColor: Color(0xFFD4A843),
    darkColor: Color(0xFFD4A843),
  );

  static const ColorModel infoCardBackground = ColorModel(
    lightColor: Color(0xFFFFF6E9),
    darkColor: Color(0xFFFFF6E9),
  );

  static const ColorModel infoCardBorder = ColorModel(
    lightColor: Color(0xFFfed7aa),
    darkColor: Color(0xFFFCE3B6),
  );

  static const ColorModel infoCardTitle = ColorModel(
    lightColor: Color(0xFF7A5209),
    darkColor: Color(0xFF7A5209),
  );

  static const ColorModel infoCardText = ColorModel(
    lightColor: Color(0xFF78350f),
    darkColor: Color(0xFF8A6A1E),
  );

  static const ColorModel infoCardIcon = ColorModel(
    lightColor: Color(0xFFC98A1F),
    darkColor: Color(0xFFC98A1F),
  );

  static ColorModel borderColor = ColorModel(
    lightColor: const Color(0xFFDCE7EA),
    darkColor: Colors.white,
  );

  // ─── Generated palette ────────────────────────────────────────────────────
  static const ColorModel mint = ColorModel(
    lightColor: Color(0xFF0D9488),
    darkColor: Color(0xff2C9092),
  );
  static const ColorModel darkSlate = ColorModel(
    lightColor: Color(0xFF3A4150),
    darkColor: Color(0xFF3A4150),
  );

  static const ColorModel blue = ColorModel(
    lightColor: Color(0xff2563eb),
    darkColor: Color(0xff2368E2),
  );

  static const ColorModel purple = ColorModel(
    lightColor: Color(0xFF7C3AED),
    darkColor: Color(0xFF8B5CF6),
  );

  static const ColorModel statsAccentGreen = ColorModel(
    lightColor: Color(0xFF1BAA63),
    darkColor: Color(0xFF1BAA63),
  );
  static const ColorModel statsTabSelected = ColorModel(
    lightColor: Color(0xFF1F8A70),
    darkColor: Color(0xFF1F8A70),
  );
  static const ColorModel statsCardBg = ColorModel(
    lightColor: Color(0xFFF7F8FA),
    darkColor: Color(0xFFF7F8FA),
  );
  static const ColorModel statsProgressBg = ColorModel(
    lightColor: Color(0xFFE9EBEF),
    darkColor: Color(0xFFE9EBEF),
  );
  static const ColorModel statsGradientStart = ColorModel(
    lightColor: Color(0xFF17B78F),
    darkColor: Color(0xFF17B78F),
  );
  static const ColorModel statsGradientEnd = ColorModel(
    lightColor: Color(0xFF2F6FED),
    darkColor: Color(0xFF2F6FED),
  );

  static const ColorModel brandGreen = ColorModel(
    lightColor: Color(0xFF1F8A70),
    darkColor: Color(0xFF1F8A70),
  );

  static const ColorModel brandTeal = ColorModel(
    lightColor: Color(0xFF17B78F),
    darkColor: Color(0xFF2C9092),
  );

  static const ColorModel companyBrand = ColorModel(
    lightColor: Color(0xFF3d4f2f),
    darkColor: Color(0xFF4C5A38),
  );

  static const ColorModel catalogDetailsBackground = ColorModel(
    lightColor: Color(0xFFF0F6F8),
    
    darkColor: Color(0xFFF0F6F8),
  );

  static const ColorModel profileCardToolbar = ColorModel(
    lightColor: Color(0xFF1E293B),
    darkColor: Color(0xFF1E293B),
  );

  static const ColorModel profileCardToolbarChip = ColorModel(
    lightColor: Color(0xFF334155),
    darkColor: Color(0xFF334155),
  );

  static const ColorModel profileCardToolbarBorder = ColorModel(
    lightColor: Color(0xFF475569),
    darkColor: Color(0xFF475569),
  );

  static const ColorModel profileCardToolbarText = ColorModel(
    lightColor: Color(0xFFCBD5E1),
    darkColor: Color(0xFFCBD5E1),
  );

  static const ColorModel profileCardLightBackground = ColorModel(
    lightColor: Color(0xFFF8FAFC),
    darkColor: Color(0xFFF8FAFC),
  );

  static const ColorModel profileCardSaveContact = ColorModel(
    lightColor: Color(0xFF17212B),
    darkColor: Color(0xFF17212B),
  );

  static const ColorModel whatsapp = ColorModel(
    lightColor: Color(0xFF25D366),
    darkColor: Color(0xFF25D366),
  );

  static const ColorModel saleRed = ColorModel(
    lightColor: Color(0xFFfb2c36),
    darkColor: Color(0xFFE0563E),
  );

  static const ColorModel saleRedSoft = ColorModel(
    lightColor: Color(0xFFFFEAEA),
    darkColor: Color(0xFF3A2724),
  );

  static const ColorModel mintSoft = ColorModel(
    lightColor: Color(0xFFE7F8F0),
    darkColor: Color(0xFF1B3A32),
  );

  static const ColorModel ratingGold = ColorModel(
    lightColor: Color(0xFFFFB020),
    darkColor: Color(0xFFFFB020),
  );

  static const ColorModel dropdownSurface = ColorModel(
    lightColor: Color(0xFF17212B),
    darkColor: Color(0xFF1E1E1E),
  );

  static const ColorModel disabledColor = ColorModel(
    lightColor: Color(0xFFDCE3EA),
    darkColor: Color(0xFF3A3F45),
  );

  static const ColorModel overlayOnDark = ColorModel(
    lightColor: Color(0xFFFFFFFF),
    darkColor: Color(0xFFFFFFFF),
  );

  static const ColorModel accentTeal = ColorModel(
    lightColor: Color(0xFF0D9488),
    darkColor: Color(0xFF0D9488),
  );

  static const ColorModel accentBlue = ColorModel(
    lightColor: Color(0xFF2563EB),
    darkColor: Color(0xFF2563EB),
  );

  static const ColorModel deepNavy = ColorModel(
    lightColor: Color(0xFF102E3D),
    darkColor: Color(0xFF102E3D),
  );

  static const ColorModel deepNavyLight = ColorModel(
    lightColor: Color(0xFF164C55),
    darkColor: Color(0xFF164C55),
  );

  static const ColorModel fieldLabel = ColorModel(
    lightColor: Color(0xFF5C7E8B),
    darkColor: Color(0xFF9DB6BF),
  );

  static const ColorModel fieldIcon = ColorModel(
    lightColor: Color(0xFF87A4AF),
    darkColor: Color(0xFF87A4AF),
  );

  static const ColorModel fieldHint = ColorModel(
    lightColor: Color(0xFFA9BCC3),
    darkColor: Color(0xFF6F858D),
  );

  static const ColorModel subtleText = ColorModel(
    lightColor: Color(0xFF98AFB7),
    darkColor: Color(0xFF7D939B),
  );

  static const ColorModel tabInactive = ColorModel(
    lightColor: Color(0xFFA3B5BD),
    darkColor: Color(0xFF6F858D),
  );

  static const ColorModel ghostAction = ColorModel(
    lightColor: Color(0xFF6E96A0),
    darkColor: Color(0xFF8FB3BC),
  );

  static const ColorModel softDivider = ColorModel(
    lightColor: Color(0xFFE0EAED),
    darkColor: Color(0xFF2A3A40),
  );

  static const ColorModel editorialAccent = ColorModel(
    lightColor: Color(0xFF77C9BC),
    darkColor: Color(0xFF77C9BC),
  );

  static const ColorModel editorialMuted = ColorModel(
    lightColor: Color(0xFF8FACB6),
    darkColor: Color(0xFF8FACB6),
  );

  static const ColorModel cardRear = ColorModel(
    lightColor: Color(0xFFCBDCE2),
    darkColor: Color(0xFF2E4650),
  );

  static const ColorModel cardIcon = ColorModel(
    lightColor: Color(0xFF80B4B7),
    darkColor: Color(0xFF80B4B7),
  );

  static const ColorModel cardSubtle = ColorModel(
    lightColor: Color(0xFF99BCC2),
    darkColor: Color(0xFF99BCC2),
  );

  static const ColorModel cardFooter = ColorModel(
    lightColor: Color(0xFF77A7B4),
    darkColor: Color(0xFF77A7B4),
  );

  static const ColorModel errorSoftText = ColorModel(
    lightColor: Color(0xFFB74747),
    darkColor: Color(0xFFE08A8A),
  );

  static const ColorModel errorSoftBackground = ColorModel(
    lightColor: Color(0xFFFFF0EF),
    darkColor: Color(0xFF3A2222),
  );

  static const ColorModel errorSoftBorder = ColorModel(
    lightColor: Color(0xFFEFCFCA),
    darkColor: Color(0xFF5A3333),
  );

  static const ColorModel scenePillText = ColorModel(
    lightColor: Color(0xFF439F8D),
    darkColor: Color(0xFF439F8D),
  );

  static const ColorModel onboardGlowTeal = ColorModel(
    lightColor: Color(0xFFD3ECE7),
    darkColor: Color(0xFFD3ECE7),
  );

  static const ColorModel onboardGlowBlue = ColorModel(
    lightColor: Color(0xFFD8E6F8),
    darkColor: Color(0xFFD8E6F8),
  );

  static const ColorModel dotInactive = ColorModel(
    lightColor: Color(0xFFD1DFE3),
    darkColor: Color(0xFFD1DFE3),
  );

  static const ColorModel leadAvatarBackground = ColorModel(
    lightColor: Color(0xFFE3F1ED),
    darkColor: Color(0xFFE3F1ED),
  );

  static const ColorModel leadAvatarText = ColorModel(
    lightColor: Color(0xFF4E9384),
    darkColor: Color(0xFF4E9384),
  );

  static const ColorModel leadMuted = ColorModel(
    lightColor: Color(0xFF8AA1AA),
    darkColor: Color(0xFF8AA1AA),
  );

  static const ColorModel skipText = ColorModel(
    lightColor: Color(0xFF7898A3),
    darkColor: Color(0xFF7898A3),
  );

  static const ColorModel splashBackground = ColorModel(
    lightColor: Color(0xFF0D2C3A),
    darkColor: Color(0xFF0D2C3A),
  );

  static const ColorModel splashEyebrow = ColorModel(
    lightColor: Color(0xFF77BBBC),
    darkColor: Color(0xFF77BBBC),
  );

  static const ColorModel splashBody = ColorModel(
    lightColor: Color(0xFF92B2BA),
    darkColor: Color(0xFF92B2BA),
  );

  static const ColorModel splashLoading = ColorModel(
    lightColor: Color(0xFF92ADB5),
    darkColor: Color(0xFF92ADB5),
  );

  static const ColorModel floatShadow = ColorModel(
    lightColor: Color(0xFF164759),
    darkColor: Color(0xFF164759),
  );

  static const ColorModel choiceNumber = ColorModel(
    lightColor: Color(0xFFA6BCC4),
    darkColor: Color(0xFFA6BCC4),
  );
  static const ColorModel choiceTitle = ColorModel(
    lightColor: Color(0xFF254B58),
    darkColor: Color(0xFF254B58),
  );
  static const ColorModel choiceBody = ColorModel(
    lightColor: Color(0xFF91A7B1),
    darkColor: Color(0xFF91A7B1),
  );
  static const ColorModel choiceSelected = ColorModel(
    lightColor: Color(0xFFE8F6F1),
    darkColor: Color(0xFFE8F6F1),
  );
  static const ColorModel choiceRadioBorder = ColorModel(
    lightColor: Color(0xFFCBDBDF),
    darkColor: Color(0xFFCBDBDF),
  );
  static const ColorModel pathIconBackground = ColorModel(
    lightColor: Color(0xFFE4EEF5),
    darkColor: Color(0xFFE4EEF5),
  );
  static const ColorModel pathBody = ColorModel(
    lightColor: Color(0xFF8CA5AF),
    darkColor: Color(0xFF8CA5AF),
  );
  static const ColorModel topIconBorder = ColorModel(
    lightColor: Color(0xFFE3EBED),
    darkColor: Color(0xFFE3EBED),
  );
  static const ColorModel topIconColor = ColorModel(
    lightColor: Color(0xFF435964),
    darkColor: Color(0xFF435964),
  );
  static const ColorModel topEyebrow = ColorModel(
    lightColor: Color(0xFF89999F),
    darkColor: Color(0xFF89999F),
  );
  static const ColorModel footerBorder = ColorModel(
    lightColor: Color(0xFFE4EDEF),
    darkColor: Color(0xFFE4EDEF),
  );
  static const ColorModel footerNote = ColorModel(
    lightColor: Color(0xFF8B9BA2),
    darkColor: Color(0xFF8B9BA2),
  );
  static const ColorModel pageSubtitle = ColorModel(
    lightColor: Color(0xFF7A8A91),
    darkColor: Color(0xFF7A8A91),
  );
  static const ColorModel artBack = ColorModel(
    lightColor: Color(0xFFDFEBEE),
    darkColor: Color(0xFFDFEBEE),
  );
  static const ColorModel artBackIcon = ColorModel(
    lightColor: Color(0xFF86A6B2),
    darkColor: Color(0xFF86A6B2),
  );
  static const ColorModel artBadgeBorder = ColorModel(
    lightColor: Color(0xFFD9E8E7),
    darkColor: Color(0xFFD9E8E7),
  );
  static const ColorModel artBadgeText = ColorModel(
    lightColor: Color(0xFF43897E),
    darkColor: Color(0xFF43897E),
  );
  static const ColorModel methodBorder = ColorModel(
    lightColor: Color(0xFFE0E9EB),
    darkColor: Color(0xFFE0E9EB),
  );
  static const ColorModel methodIcon = ColorModel(
    lightColor: Color(0xFF6D8992),
    darkColor: Color(0xFF6D8992),
  );
  static const ColorModel methodSelected = ColorModel(
    lightColor: Color(0xFFEFF9F6),
    darkColor: Color(0xFFEFF9F6),
  );
  static const ColorModel methodTitle = ColorModel(
    lightColor: Color(0xFF2D4854),
    darkColor: Color(0xFF2D4854),
  );
  static const ColorModel methodBody = ColorModel(
    lightColor: Color(0xFF8B9CA2),
    darkColor: Color(0xFF8B9CA2),
  );
  static const ColorModel explainerBody = ColorModel(
    lightColor: Color(0xFF879DA5),
    darkColor: Color(0xFF879DA5),
  );
  static const ColorModel stepText = ColorModel(
    lightColor: Color(0xFF637D87),
    darkColor: Color(0xFF637D87),
  );
  static const ColorModel stepBadge = ColorModel(
    lightColor: Color(0xFFE5F0EE),
    darkColor: Color(0xFFE5F0EE),
  );
  static const ColorModel assistantLine = ColorModel(
    lightColor: Color(0xFFDFE9ED),
    darkColor: Color(0xFFDFE9ED),
  );
  static const ColorModel assistantBackBorder = ColorModel(
    lightColor: Color(0xFFDCE8EC),
    darkColor: Color(0xFFDCE8EC),
  );
  static const ColorModel assistantBackIcon = ColorModel(
    lightColor: Color(0xFF6E939F),
    darkColor: Color(0xFF6E939F),
  );
  static const ColorModel assistantHeaderSmall = ColorModel(
    lightColor: Color(0xFF9DB0BA),
    darkColor: Color(0xFF9DB0BA),
  );
  static const ColorModel assistantPill = ColorModel(
    lightColor: Color(0xFFECF6F2),
    darkColor: Color(0xFFECF6F2),
  );
  static const ColorModel assistantPillText = ColorModel(
    lightColor: Color(0xFF6C9D8F),
    darkColor: Color(0xFF6C9D8F),
  );
  static const ColorModel assistantSymbol = ColorModel(
    lightColor: Color(0xFFE3F2EC),
    darkColor: Color(0xFFE3F2EC),
  );
  static const ColorModel assistantBody = ColorModel(
    lightColor: Color(0xFF829EAA),
    darkColor: Color(0xFF829EAA),
  );
  static const ColorModel assistantMethodIcon = ColorModel(
    lightColor: Color(0xFF7498A5),
    darkColor: Color(0xFF7498A5),
  );
  static const ColorModel assistantMethodTitle = ColorModel(
    lightColor: Color(0xFF426D7D),
    darkColor: Color(0xFF426D7D),
  );
  static const ColorModel assistantMethodBody = ColorModel(
    lightColor: Color(0xFF96ADB8),
    darkColor: Color(0xFF96ADB8),
  );
  static const ColorModel assistantMethodSelected = ColorModel(
    lightColor: Color(0xFFEDF8F3),
    darkColor: Color(0xFFEDF8F3),
  );
  static const ColorModel assistantSourceLabel = ColorModel(
    lightColor: Color(0xFF547B8B),
    darkColor: Color(0xFF547B8B),
  );
  static const ColorModel assistantSourceBorder = ColorModel(
    lightColor: Color(0xFFD6E5E9),
    darkColor: Color(0xFFD6E5E9),
  );
  static const ColorModel assistantSourceText = ColorModel(
    lightColor: Color(0xFF456E7E),
    darkColor: Color(0xFF456E7E),
  );
  static const ColorModel assistantSourceIcon = ColorModel(
    lightColor: Color(0xFF91AEB8),
    darkColor: Color(0xFF91AEB8),
  );
  static const ColorModel assistantSourceHint = ColorModel(
    lightColor: Color(0xFF97AFBA),
    darkColor: Color(0xFF97AFBA),
  );
  static const ColorModel assistantAssurance = ColorModel(
    lightColor: Color(0xFF84A6AD),
    darkColor: Color(0xFF84A6AD),
  );
  static const ColorModel assistantFooterNote = ColorModel(
    lightColor: Color(0xFF8EA6B0),
    darkColor: Color(0xFF8EA6B0),
  );
  static const ColorModel assistantLoading = ColorModel(
    lightColor: Color(0xFFE1F2EB),
    darkColor: Color(0xFFE1F2EB),
  );
  static const ColorModel assistantLoadingBody = ColorModel(
    lightColor: Color(0xFF8AA5B1),
    darkColor: Color(0xFF8AA5B1),
  );
  static const ColorModel assistantStepIdle = ColorModel(
    lightColor: Color(0xFFB0BFC7),
    darkColor: Color(0xFFB0BFC7),
  );
  static const ColorModel assistantStepIdleBadge = ColorModel(
    lightColor: Color(0xFFE8EEF1),
    darkColor: Color(0xFFE8EEF1),
  );
  static const ColorModel assistantStepActive = ColorModel(
    lightColor: Color(0xFF4B9B89),
    darkColor: Color(0xFF4B9B89),
  );
  static const ColorModel assistantToolbar = ColorModel(
    lightColor: Color(0xFFEAF5F0),
    darkColor: Color(0xFFEAF5F0),
  );
  static const ColorModel assistantToolbarBorder = ColorModel(
    lightColor: Color(0xFFD6E9E0),
    darkColor: Color(0xFFD6E9E0),
  );
  static const ColorModel assistantToolbarText = ColorModel(
    lightColor: Color(0xFF689E8A),
    darkColor: Color(0xFF689E8A),
  );
  static const ColorModel assistantToolbarButtonBorder = ColorModel(
    lightColor: Color(0xFFCBDED6),
    darkColor: Color(0xFFCBDED6),
  );
  static const ColorModel assistantToolbarButtonText = ColorModel(
    lightColor: Color(0xFF528E7B),
    darkColor: Color(0xFF528E7B),
  );
  static const ColorModel assistantError = ColorModel(
    lightColor: Color(0xFFFFF1ED),
    darkColor: Color(0xFFFFF1ED),
  );
  static const ColorModel assistantErrorBorder = ColorModel(
    lightColor: Color(0xFFF0D5CF),
    darkColor: Color(0xFFF0D5CF),
  );
  static const ColorModel assistantErrorText = ColorModel(
    lightColor: Color(0xFFB07C70),
    darkColor: Color(0xFFB07C70),
  );
  static const ColorModel profileHero = ColorModel(
    lightColor: Color(0xFF102F3E),
    darkColor: Color(0xFF102F3E),
  );
  static const ColorModel profileHeroDot = ColorModel(
    lightColor: Color(0xFF62C9BA),
    darkColor: Color(0xFF62C9BA),
  );
  static const ColorModel profileHeroIcon = ColorModel(
    lightColor: Color(0xFFA5C2CC),
    darkColor: Color(0xFFA5C2CC),
  );
  static const ColorModel profileKind = ColorModel(
    lightColor: Color(0xFFA0C8CE),
    darkColor: Color(0xFFA0C8CE),
  );
  static const ColorModel profileTitle = ColorModel(
    lightColor: Color(0xFFBACFD6),
    darkColor: Color(0xFFBACFD6),
  );
  static const ColorModel profileLocation = ColorModel(
    lightColor: Color(0xFFA2C0CB),
    darkColor: Color(0xFFA2C0CB),
  );
  static const ColorModel profileBaseline = ColorModel(
    lightColor: Color(0xFF96B5C2),
    darkColor: Color(0xFF96B5C2),
  );
  static const ColorModel homeBannerFill = ColorModel(
    lightColor: Color(0xFFEFF6FF),
    darkColor: Color(0xFFEFF6FF),
  );
  static const ColorModel homeBannerBorder = ColorModel(
    lightColor: Color(0xFFD6E4F5),
    darkColor: Color(0xFFD6E4F5),
  );
  static const ColorModel homeBannerAccent = ColorModel(
    lightColor: Color(0xFF2563EB),
    darkColor: Color(0xFF2563EB),
  );
  static const ColorModel homeBannerIcon = ColorModel(
    lightColor: Color(0xFFDBEAFE),
    darkColor: Color(0xFFDBEAFE),
  );
  static const ColorModel profileGradientStart = ColorModel(
    lightColor: Color(0xFFF0FDFA),
    darkColor: Color(0xFFF0FDFA),
  );
  static const ColorModel profileGradientEnd = ColorModel(
    lightColor: Color(0xFFEFF6FF),
    darkColor: Color(0xFFEFF6FF),
  );
  static const ColorModel profileSurface = ColorModel(
    lightColor: Color(0xFFF8FAFB),
    darkColor: Color(0xFFF8FAFB),
  );
  static const ColorModel profileLine = ColorModel(
    lightColor: Color(0xFFE0E9ED),
    darkColor: Color(0xFFE0E9ED),
  );
  static const ColorModel profileContactLabel = ColorModel(
    lightColor: Color(0xFF618C9B),
    darkColor: Color(0xFF618C9B),
  );
  static const ColorModel profileContactDivider = ColorModel(
    lightColor: Color(0xFFE5EDEF),
    darkColor: Color(0xFFE5EDEF),
  );
  static const ColorModel profileSectionEyebrow = ColorModel(
    lightColor: Color(0xFF6F8E9E),
    darkColor: Color(0xFF6F8E9E),
  );
  static const ColorModel profileSectionTitle = ColorModel(
    lightColor: Color(0xFF244C5E),
    darkColor: Color(0xFF244C5E),
  );
  static const ColorModel profileBody = ColorModel(
    lightColor: Color(0xFF597C8E),
    darkColor: Color(0xFF597C8E),
  );
  static const ColorModel profileAffiliation = ColorModel(
    lightColor: Color(0xFFF0F5F6),
    darkColor: Color(0xFFF0F5F6),
  );
  static const ColorModel profileAffiliationIcon = ColorModel(
    lightColor: Color(0xFF83A5B3),
    darkColor: Color(0xFF83A5B3),
  );
  static const ColorModel profileAffiliationLabel = ColorModel(
    lightColor: Color(0xFFA0B4BD),
    darkColor: Color(0xFFA0B4BD),
  );
  static const ColorModel profileAffiliationName = ColorModel(
    lightColor: Color(0xFF5B7D8D),
    darkColor: Color(0xFF5B7D8D),
  );
  static const ColorModel profileItemArt = ColorModel(
    lightColor: Color(0xFFE4EFEC),
    darkColor: Color(0xFFE4EFEC),
  );
  static const ColorModel profileItemIcon = ColorModel(
    lightColor: Color(0xFF6B9E90),
    darkColor: Color(0xFF6B9E90),
  );
  static const ColorModel profileItemNumber = ColorModel(
    lightColor: Color(0xFF94B3A9),
    darkColor: Color(0xFF94B3A9),
  );
  static const ColorModel profileItemArrow = ColorModel(
    lightColor: Color(0xFF76A090),
    darkColor: Color(0xFF76A090),
  );
  static const ColorModel profileItemKind = ColorModel(
    lightColor: Color(0xFF9BB3BB),
    darkColor: Color(0xFF9BB3BB),
  );
  static const ColorModel profileItemTitle = ColorModel(
    lightColor: Color(0xFF3B6677),
    darkColor: Color(0xFF3B6677),
  );
  static const ColorModel profileItemFooterLine = ColorModel(
    lightColor: Color(0xFFEDF2F4),
    darkColor: Color(0xFFEDF2F4),
  );
  static const ColorModel profileItemFooterIcon = ColorModel(
    lightColor: Color(0xFF87A3AF),
    darkColor: Color(0xFF87A3AF),
  );
  static const ColorModel profileSocialLabel = ColorModel(
    lightColor: Color(0xFF6D8D9E),
    darkColor: Color(0xFF6D8D9E),
  );
  static const ColorModel profileMeeting = ColorModel(
    lightColor: Color(0xFFE5F2ED),
    darkColor: Color(0xFFE5F2ED),
  );
  static const ColorModel profileMeetingBorder = ColorModel(
    lightColor: Color(0xFFD7E8DF),
    darkColor: Color(0xFFD7E8DF),
  );
  static const ColorModel profileMeetingEyebrow = ColorModel(
    lightColor: Color(0xFF80A799),
    darkColor: Color(0xFF80A799),
  );
  static const ColorModel profileMeetingTitle = ColorModel(
    lightColor: Color(0xFF336758),
    darkColor: Color(0xFF336758),
  );
  static const ColorModel profileMeetingBody = ColorModel(
    lightColor: Color(0xFF91ADA3),
    darkColor: Color(0xFF91ADA3),
  );
  static const ColorModel profileMeetingButtonBorder = ColorModel(
    lightColor: Color(0xFFCBDFD6),
    darkColor: Color(0xFFCBDFD6),
  );
  static const ColorModel profileMeetingButtonText = ColorModel(
    lightColor: Color(0xFF538F7D),
    darkColor: Color(0xFF538F7D),
  );
  static const ColorModel profilePoweredLine = ColorModel(
    lightColor: Color(0xFFE4ECEF),
    darkColor: Color(0xFFE4ECEF),
  );
  static const ColorModel profilePoweredText = ColorModel(
    lightColor: Color(0xFFB0C2CA),
    darkColor: Color(0xFFB0C2CA),
  );
  static const ColorModel profilePoweredBrand = ColorModel(
    lightColor: Color(0xFF8EACB8),
    darkColor: Color(0xFF8EACB8),
  );
  static const ColorModel profileStickyBorder = ColorModel(
    lightColor: Color(0xFFDDE8EC),
    darkColor: Color(0xFFDDE8EC),
  );
  static const ColorModel profileSave = ColorModel(
    lightColor: Color(0xFFF2F6F7),
    darkColor: Color(0xFFF2F6F7),
  );
  static const ColorModel profileSaveIcon = ColorModel(
    lightColor: Color(0xFF658B9D),
    darkColor: Color(0xFF658B9D),
  );
  static const ColorModel profileProductArt = ColorModel(
    lightColor: Color(0xFFE1EAF2),
    darkColor: Color(0xFFE1EAF2),
  );
  static const ColorModel profileProductIcon = ColorModel(
    lightColor: Color(0xFF769CB5),
    darkColor: Color(0xFF769CB5),
  );
  static const ColorModel profileResourceIcon = ColorModel(
    lightColor: Color(0xFFEDF5F2),
    darkColor: Color(0xFFEDF5F2),
  );
  static const ColorModel profileResourceTitle = ColorModel(
    lightColor: Color(0xFF517B8D),
    darkColor: Color(0xFF517B8D),
  );
  static const ColorModel profileResourceHost = ColorModel(
    lightColor: Color(0xFF809FAB),
    darkColor: Color(0xFF809FAB),
  );
  static const ColorModel profileResourceArrow = ColorModel(
    lightColor: Color(0xFF84A4B2),
    darkColor: Color(0xFF84A4B2),
  );
  static const ColorModel profileTabText = ColorModel(
    lightColor: Color(0xFF9BB1BD),
    darkColor: Color(0xFF9BB1BD),
  );
  static const ColorModel studioEditorSubtitle = ColorModel(
    lightColor: Color(0xFF879BA3),
    darkColor: Color(0xFF879BA3),
  );
  static const ColorModel studioPanelBorder = ColorModel(
    lightColor: Color(0xFFE2EBED),
    darkColor: Color(0xFFE2EBED),
  );
  static const ColorModel studioFieldLabel = ColorModel(
    lightColor: Color(0xFF596E78),
    darkColor: Color(0xFF596E78),
  );
  static const ColorModel studioFieldBorder = ColorModel(
    lightColor: Color(0xFFDCE7E9),
    darkColor: Color(0xFFDCE7E9),
  );
  static const ColorModel studioFieldFill = ColorModel(
    lightColor: Color(0xFFFBFCFC),
    darkColor: Color(0xFFFBFCFC),
  );
  static const ColorModel studioFieldText = ColorModel(
    lightColor: Color(0xFF36515E),
    darkColor: Color(0xFF36515E),
  );
  static const ColorModel studioFieldHint = ColorModel(
    lightColor: Color(0xFFADBBC0),
    darkColor: Color(0xFFADBBC0),
  );
  static const ColorModel studioStepIdle = ColorModel(
    lightColor: Color(0xFFA8B5B9),
    darkColor: Color(0xFFA8B5B9),
  );
  static const ColorModel studioStepIdleBadge = ColorModel(
    lightColor: Color(0xFFE8EEF0),
    darkColor: Color(0xFFE8EEF0),
  );
  static const ColorModel studioStepComplete = ColorModel(
    lightColor: Color(0xFF608B85),
    darkColor: Color(0xFF608B85),
  );
  static const ColorModel studioStepLine = ColorModel(
    lightColor: Color(0xFFE3ECEE),
    darkColor: Color(0xFFE3ECEE),
  );
  static const ColorModel studioSaving = ColorModel(
    lightColor: Color(0xFF77A29A),
    darkColor: Color(0xFF77A29A),
  );
  static const ColorModel studioError = ColorModel(
    lightColor: Color(0xFFCC4F4F),
    darkColor: Color(0xFFCC4F4F),
  );
  static const ColorModel studioIdentityBorder = ColorModel(
    lightColor: Color(0xFFE5EDEF),
    darkColor: Color(0xFFE5EDEF),
  );
  static const ColorModel studioIdentityAvatar = ColorModel(
    lightColor: Color(0xFFEAF6F2),
    darkColor: Color(0xFFEAF6F2),
  );
  static const ColorModel studioIdentityHint = ColorModel(
    lightColor: Color(0xFF8BA0A5),
    darkColor: Color(0xFF8BA0A5),
  );
  static const ColorModel studioSuggestion = ColorModel(
    lightColor: Color(0xFFE9F5F1),
    darkColor: Color(0xFFE9F5F1),
  );
  static const ColorModel studioSuggestionBorder = ColorModel(
    lightColor: Color(0xFFCFE9E1),
    darkColor: Color(0xFFCFE9E1),
  );
  static const ColorModel studioSuggestionText = ColorModel(
    lightColor: Color(0xFF518477),
    darkColor: Color(0xFF518477),
  );
  static const ColorModel studioInputHint = ColorModel(
    lightColor: Color(0xFF9BABB0),
    darkColor: Color(0xFF9BABB0),
  );
  static const ColorModel studioTabs = ColorModel(
    lightColor: Color(0xFFEAF0F2),
    darkColor: Color(0xFFEAF0F2),
  );
  static const ColorModel studioTabText = ColorModel(
    lightColor: Color(0xFF8A9CA4),
    darkColor: Color(0xFF8A9CA4),
  );
  static const ColorModel studioTabActive = ColorModel(
    lightColor: Color(0xFF234754),
    darkColor: Color(0xFF234754),
  );
  static const ColorModel studioToggleOff = ColorModel(
    lightColor: Color(0xFFDBE5E8),
    darkColor: Color(0xFFDBE5E8),
  );
  static const ColorModel studioLinkBorder = ColorModel(
    lightColor: Color(0xFFE1EBED),
    darkColor: Color(0xFFE1EBED),
  );
  static const ColorModel studioLinkDivider = ColorModel(
    lightColor: Color(0xFFE7EEF0),
    darkColor: Color(0xFFE7EEF0),
  );
  static const ColorModel studioLinkIcon = ColorModel(
    lightColor: Color(0xFF76A5A1),
    darkColor: Color(0xFF76A5A1),
  );
  static const ColorModel studioSectionDetail = ColorModel(
    lightColor: Color(0xFF8B9BA2),
    darkColor: Color(0xFF8B9BA2),
  );
  static const ColorModel studioSummary = ColorModel(
    lightColor: Color(0xFFE8F2F1),
    darkColor: Color(0xFFE8F2F1),
  );
  static const ColorModel studioSummaryBorder = ColorModel(
    lightColor: Color(0xFFD6E9E5),
    darkColor: Color(0xFFD6E9E5),
  );
  static const ColorModel studioSummaryCount = ColorModel(
    lightColor: Color(0xFF18796C),
    darkColor: Color(0xFF18796C),
  );
  static const ColorModel studioSummaryLabel = ColorModel(
    lightColor: Color(0xFF6A968C),
    darkColor: Color(0xFF6A968C),
  );
  static const ColorModel studioSummaryButtonBorder = ColorModel(
    lightColor: Color(0xFFCCE3DF),
    darkColor: Color(0xFFCCE3DF),
  );
  static const ColorModel studioItemIcon = ColorModel(
    lightColor: Color(0xFFEFF5F6),
    darkColor: Color(0xFFEFF5F6),
  );
  static const ColorModel studioItemIconColor = ColorModel(
    lightColor: Color(0xFF6C8F99),
    darkColor: Color(0xFF6C8F99),
  );
  static const ColorModel studioRowMeta = ColorModel(
    lightColor: Color(0xFF8BA5AF),
    darkColor: Color(0xFF8BA5AF),
  );
  static const ColorModel studioRowIcon = ColorModel(
    lightColor: Color(0xFF94ABB3),
    darkColor: Color(0xFF94ABB3),
  );
  static const ColorModel studioEmptyIcon = ColorModel(
    lightColor: Color(0xFF8EA8AF),
    darkColor: Color(0xFF8EA8AF),
  );
  static const ColorModel studioEmptyTitle = ColorModel(
    lightColor: Color(0xFF476C78),
    darkColor: Color(0xFF476C78),
  );
  static const ColorModel studioEmptyBody = ColorModel(
    lightColor: Color(0xFF93A7AF),
    darkColor: Color(0xFF93A7AF),
  );
  static const ColorModel studioNote = ColorModel(
    lightColor: Color(0xFF8CA3AB),
    darkColor: Color(0xFF8CA3AB),
  );
  static const ColorModel studioLivePreview = ColorModel(
    lightColor: Color(0xFFE6EFF1),
    darkColor: Color(0xFFE6EFF1),
  );
  static const ColorModel studioLivePreviewText = ColorModel(
    lightColor: Color(0xFF83A4A9),
    darkColor: Color(0xFF83A4A9),
  );
  static const ColorModel studioLiveDot = ColorModel(
    lightColor: Color(0xFF64B7A6),
    darkColor: Color(0xFF64B7A6),
  );
  static const ColorModel studioCardStart = ColorModel(
    lightColor: Color(0xFF152E3B),
    darkColor: Color(0xFF152E3B),
  );
  static const ColorModel studioCardEnd = ColorModel(
    lightColor: Color(0xFF173544),
    darkColor: Color(0xFF173544),
  );
  static const ColorModel studioCardBrand = ColorModel(
    lightColor: Color(0xFF93B6BC),
    darkColor: Color(0xFF93B6BC),
  );
  static const ColorModel studioCardTitle = ColorModel(
    lightColor: Color(0xFFACC5CA),
    darkColor: Color(0xFFACC5CA),
  );
  static const ColorModel studioCardCompany = ColorModel(
    lightColor: Color(0xFF88A9B0),
    darkColor: Color(0xFF88A9B0),
  );
  static const ColorModel studioCardBottom = ColorModel(
    lightColor: Color(0xFFA2C3C5),
    darkColor: Color(0xFFA2C3C5),
  );
  static const ColorModel studioCardDot = ColorModel(
    lightColor: Color(0xFF69D0B9),
    darkColor: Color(0xFF69D0B9),
  );
  static const ColorModel studioCardQr = ColorModel(
    lightColor: Color(0xFFD8EDEB),
    darkColor: Color(0xFFD8EDEB),
  );
  static const ColorModel studioTemplateBorder = ColorModel(
    lightColor: Color(0xFFE0EAEC),
    darkColor: Color(0xFFE0EAEC),
  );
  static const ColorModel studioTemplateText = ColorModel(
    lightColor: Color(0xFF748D95),
    darkColor: Color(0xFF748D95),
  );
  static const ColorModel studioTemplateSelected = ColorModel(
    lightColor: Color(0xFFF5FBF8),
    darkColor: Color(0xFFF5FBF8),
  );
  static const ColorModel studioTemplateArt = ColorModel(
    lightColor: Color(0xFFF4F7F8),
    darkColor: Color(0xFFF4F7F8),
  );
  static const ColorModel studioTemplateArtAvatar = ColorModel(
    lightColor: Color(0xFFA6D9CC),
    darkColor: Color(0xFFA6D9CC),
  );
  static const ColorModel studioTemplateArtLine = ColorModel(
    lightColor: Color(0xFFB2C4CB),
    darkColor: Color(0xFFB2C4CB),
  );
  static const ColorModel studioTemplateArtLineSoft = ColorModel(
    lightColor: Color(0xFFD6E1E4),
    darkColor: Color(0xFFD6E1E4),
  );
  static const ColorModel studioTemplateArtProLine = ColorModel(
    lightColor: Color(0xFF8AADBC),
    darkColor: Color(0xFF8AADBC),
  );
  static const ColorModel studioTemplateArtPersonal = ColorModel(
    lightColor: Color(0xFFE8F5F0),
    darkColor: Color(0xFFE8F5F0),
  );
  static const ColorModel studioPaletteRing = ColorModel(
    lightColor: Color(0xFF91ABAE),
    darkColor: Color(0xFF91ABAE),
  );
  static const ColorModel studioDetailsTitle = ColorModel(
    lightColor: Color(0xFF426D7B),
    darkColor: Color(0xFF426D7B),
  );
  static const ColorModel studioDetailsLabel = ColorModel(
    lightColor: Color(0xFF8BA3AF),
    darkColor: Color(0xFF8BA3AF),
  );
  static const ColorModel studioSelectFill = ColorModel(
    lightColor: Color(0xFFF9FBFC),
    darkColor: Color(0xFFF9FBFC),
  );
  static const ColorModel studioOrderBorder = ColorModel(
    lightColor: Color(0xFFDFEAEC),
    darkColor: Color(0xFFDFEAEC),
  );
  static const ColorModel studioOrderText = ColorModel(
    lightColor: Color(0xFF69818A),
    darkColor: Color(0xFF69818A),
  );
  static const ColorModel studioOrderHandle = ColorModel(
    lightColor: Color(0xFFA6B7BD),
    darkColor: Color(0xFFA6B7BD),
  );
}

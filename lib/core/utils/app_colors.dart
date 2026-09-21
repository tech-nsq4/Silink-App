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
    lightColor: Color(0xFFF5F7FA),
    darkColor: Color(0xff121212),
  );

  static const ColorModel surfaceColor = ColorModel(
    lightColor: Color(0xffF5F5F5),
    darkColor: Color(0xff1E1E1E),
  );

  static const ColorModel textPrimaryColor = ColorModel(
    lightColor: Color(0xFF111827),
    darkColor: Color(0xffFFFFFF),
  );

  static const ColorModel textSecondaryColor = ColorModel(
    lightColor: Color(0xFF64748b),
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
    lightColor: Colors.black.withValues(alpha: 0.14),
    darkColor: Colors.white,
  );

  // ─── Generated palette ────────────────────────────────────────────────────
  static const ColorModel mint = ColorModel(
    lightColor: Color(0xff3FA299),
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

  static const ColorModel saleRed = ColorModel(
    lightColor: Color(0xFFE0563E),
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

  static const ColorModel overlayOnDark = ColorModel(
    lightColor: Color(0xFFFFFFFF),
    darkColor: Color(0xFFFFFFFF),
  );
}

import '../../../../core/utils/custom_text_field_phone/countries.dart';
import 'studio_platform.dart';

class StudioWhatsappNumber {
  const StudioWhatsappNumber({required this.iso, required this.national});

  final String iso;
  final String national;
}

abstract final class StudioWhatsapp {
  static const String defaultIso = 'SA';

  static String compose(String countryCode, String national) {
    final dial = countryCode.replaceAll(RegExp(r'\D'), '');
    final local =
        national.replaceAll(RegExp(r'\D'), '').replaceFirst(RegExp(r'^0+'), '');
    if (local.isEmpty) return '';
    return '${StudioPlatform.whatsapp.baseUrl}$dial$local';
  }

  static StudioWhatsappNumber parse(String value) {
    final digits = value.replaceAll(RegExp(r'\D'), '');
    if (digits.isEmpty) {
      return const StudioWhatsappNumber(iso: defaultIso, national: '');
    }
    Country2? match;
    for (final country in countries) {
      if (!digits.startsWith(country.dialCode)) continue;
      if (match == null || country.dialCode.length > match.dialCode.length) {
        match = country;
      }
    }
    if (match == null) {
      return StudioWhatsappNumber(iso: defaultIso, national: digits);
    }
    final rest = digits.substring(match.dialCode.length);
    return StudioWhatsappNumber(
      iso: match.code,
      national: match.code == 'EG' ? '0$rest' : rest,
    );
  }
}

import 'package:Silink/app/router/navigation_services.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

class ConvertHelper {
  static Color hexToColor(String hex, {Color fallback = const Color(0xFF17B78F)}) {
    final cleaned = hex.trim().replaceAll('#', '');
    if (cleaned.length != 6 && cleaned.length != 8) return fallback;
    final value = int.tryParse(cleaned.length == 6 ? 'FF$cleaned' : cleaned,
        radix: 16);
    return value == null ? fallback : Color(value);
  }

  static String colorToHex(Color color) =>
      '#${color.toARGB32().toRadixString(16).substring(2).toUpperCase()}';

  static String formatDateTime(
    String date, {
    String? time,
    bool includeDate = true,
    bool includeTime = false,
  }) {
    if (date.isEmpty && (time == null || time.isEmpty)) return '';

    final dateTime = _parseDateTime(date, time: time);
    if (dateTime == null) {
      return [date, time]
          .where((value) => value != null && value.trim().isNotEmpty)
          .map((value) => value!.trim())
          .join(' - ');
    }

    final locale = _languageCode;
    final parts = <String>[];

    if (includeDate) {
      final dateFormat = DateFormat('d MMMM y', locale);
      parts.add(dateFormat.format(dateTime));
    }

    if (includeTime) {
      if (locale == 'ar') {
        final timeFormat = DateFormat('hh:mm', locale);
        final period = dateTime.hour < 12 ? 'صباحًا' : 'مساءً';
        parts.add('${timeFormat.format(dateTime)} $period');
      } else {
        final timeFormat = DateFormat('hh:mm a', locale);
        parts.add(timeFormat.format(dateTime));
      }
    }

    return parts.join(' - ');
  }

  static String formatDuration(String duration) {
    final minutes = int.tryParse(duration.trim());
    if (minutes == null || minutes <= 0) return duration;

    if (_languageCode == 'ar') {
      return '$minutes دقيقة';
    }

    return '$minutes min';
  }

  static String formatPrice(double value, {int decimalDigits = 0}) {
    final format = NumberFormat.decimalPattern('en')
      ..minimumFractionDigits = decimalDigits
      ..maximumFractionDigits = decimalDigits;
    return format.format(value);
  }

  static String formatPriceWithCurrency(String rawPrice) {
    final trimmed = rawPrice.trim();
    if (trimmed.isEmpty) return '';
    final currency = LocaleKeys.store_currency.tr();
    final value = double.tryParse(trimmed);
    if (value == null) return '$trimmed $currency';
    final hasDecimals = value != value.truncateToDouble();
    return '${formatPrice(value, decimalDigits: hasDecimals ? 2 : 0)} $currency';
  }

  static DateTime? _parseDateTime(String date, {String? time}) {
    final normalizedDate = date.trim();
    final normalizedTime = (time ?? '').trim();

    final candidates = <String>[
      if (normalizedDate.isNotEmpty && normalizedTime.isNotEmpty)
        '${normalizedDate}T${_normalizeTime(normalizedTime)}',
      if (normalizedDate.isNotEmpty) normalizedDate,
    ];

    for (final value in candidates) {
      final parsed = DateTime.tryParse(value);
      if (parsed != null) return parsed;
    }

    return null;
  }

  static String _normalizeTime(String time) {
    final parts = time.split(':');
    if (parts.length == 2) {
      return '${parts[0]}:${parts[1]}:00';
    }
    return time;
  }

  static String get _languageCode {
    final context = NavigationService.navigationKey.currentContext;
    if (context != null) {
      return Localizations.localeOf(context).languageCode;
    }

    final locale = Intl.getCurrentLocale();
    if (locale.isEmpty) return 'en';
    return locale.split('_').first;
  }
}

import 'package:flutter/material.dart';

/// بيانات موعد المتابعة المحفوظ.
class FollowUpData {
  const FollowUpData({required this.date, this.time, this.reason = ''});

  final DateTime date;
  final TimeOfDay? time;
  final String reason;
}

/// ملاحظة مضافة للعميل.
class ClientNote {
  const ClientNote({required this.text, required this.createdAt});

  final String text;
  final DateTime createdAt;
}

/// ── أدوات تنسيق التاريخ والوقت ──

String formatDate(DateTime date) {
  final day = date.day.toString().padLeft(2, '0');
  final month = date.month.toString().padLeft(2, '0');
  return '$day/$month/${date.year}';
}

String formatTime(BuildContext context, TimeOfDay time) {
  final isAr = Localizations.localeOf(context).languageCode == 'ar';
  final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
  final minute = time.minute.toString().padLeft(2, '0');
  final period = time.period == DayPeriod.am
      ? (isAr ? 'ص' : 'AM')
      : (isAr ? 'م' : 'PM');
  return '$hour:$minute $period';
}

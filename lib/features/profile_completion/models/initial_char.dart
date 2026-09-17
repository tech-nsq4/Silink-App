import 'package:characters/characters.dart';

extension StringExtension on String {
  String get initial {
    final value = trim();
    if (value.isEmpty) return 'س';
    return value.characters.first.toUpperCase();
  }
}
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:easy_localization/easy_localization.dart';

class EmployeeValidators {
  const EmployeeValidators._();

  static String? required(String? value) =>
      (value == null || value.trim().isEmpty)
          ? LocaleKeys.company_error_required.tr()
          : null;

  static String? email(String? value) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) return LocaleKeys.company_error_required.tr();
    final valid = RegExp(r'^[\w.\-+]+@[\w\-]+\.[\w.\-]+$').hasMatch(trimmed);
    return valid ? null : LocaleKeys.company_error_email.tr();
  }

  static String? password(String? value) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) return LocaleKeys.company_error_required.tr();
    return optionalPassword(trimmed);
  }

  static String? optionalPassword(String? value) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty || trimmed.length >= 6) return null;
    return LocaleKeys.validation_shortPassword.tr();
  }
}

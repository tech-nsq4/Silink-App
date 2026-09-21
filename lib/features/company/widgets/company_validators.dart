class CompanyValidators {
  const CompanyValidators._();

  static String? emailValidator(String? value) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) return 'company.error_required';
    final valid = RegExp(r'^[\w.\-+]+@[\w\-]+\.[\w.\-]+$').hasMatch(trimmed);
    return valid ? null : 'company.error_email';
  }

  static String? requiredValidator(String? value) {
    return (value == null || value.trim().isEmpty)
        ? 'company.error_required'
        : null;
  }
}
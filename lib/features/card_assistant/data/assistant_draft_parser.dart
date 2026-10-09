import 'models/assistant_draft.dart';

class AssistantDraftParser {
  const AssistantDraftParser();

  static const String sampleDescription =
      'أنا أحمد، مصمم داخلي في الرياض. أقدم التصميم الداخلي وتنفيذ المنازل والمكاتب. للتواصل: 0512345678.';

  static const String sampleLink = 'https://example.com/ahmed';

  static const AssistantDraft sampleDraft = AssistantDraft(
    name: 'أحمد',
    title: 'مصمم داخلي',
    bio:
        'أساعدك في تحويل المساحات إلى أماكن تعبّر عن أسلوبك، من التصميم الداخلي إلى التنفيذ للمنازل والمكاتب.',
    phone: '0512345678',
    location: 'الرياض',
    services: 'تصميم داخلي، تنفيذ المنازل والمكاتب',
  );

  static const String _jobWords =
      'أعمل|اعمل|مصمم|مطور|مهندس|مستشار|مدير|مسوق|محاسب|طبيب';
  static const String _cities = 'الرياض|جدة|القاهرة|الدمام|مكة|دبي|الإسكندرية';

  static final RegExp _name = RegExp(
      r'(?:أنا|انا|اسمي)\s+([^،,.\n]+?)(?=\s+(?:' +
          _jobWords +
          r')|[،,.\n]|$)');
  static final RegExp _titleByVerb =
      RegExp(r'(?:أعمل|اعمل|شغلي|وظيفتي)\s*(?:كـ?|في)?\s*([^،,.\n]+)');
  static final RegExp _titleByRole = RegExp(
      r'(?:مصمم|مطور|مهندس|مستشار|مدير|مسوق|محاسب|طبيب)[^،,.\n]*?(?=\s+في\s|[،,.\n]|$)');
  static final RegExp _company = RegExp(r'(?:شركة|شركتي)\s+([^،,.\n]+)');
  static final RegExp _phone = RegExp(r'\+?\d[\d -]{7,14}\d');
  static final RegExp _email =
      RegExp(r'[\w.+-]+@[\w.-]+\.[a-z]{2,}', caseSensitive: false);
  static final RegExp _location = RegExp(r'في\s+(' + _cities + r')');
  static final RegExp _services = RegExp(r'(?:أقدم|اقدم|خدماتي)\s+([^.\n]+)');

  AssistantDraft fromDescription(String text) {
    final source = text.trim();
    if (source == sampleDescription) return sampleDraft;
    return AssistantDraft(
      name: _group(_name, source),
      title: _group(_titleByVerb, source).isNotEmpty
          ? _group(_titleByVerb, source)
          : (_titleByRole.firstMatch(source)?.group(0)?.trim() ?? ''),
      company: _group(_company, source),
      bio: source,
      phone: _phone.firstMatch(source)?.group(0) ?? '',
      email: _email.firstMatch(source)?.group(0) ?? '',
      location: _group(_location, source),
      services: _group(_services, source),
    );
  }

  AssistantDraft? fromLink(Uri uri) {
    final isSample = uri.host == 'example.com' && uri.path == '/ahmed';
    return isSample ? sampleDraft.copyWith(website: uri.toString()) : null;
  }

  String _group(RegExp pattern, String source) =>
      pattern.firstMatch(source)?.group(1)?.trim() ?? '';
}

import '../../../../core/utils/locale_keys.dart';

enum ProductFont { tajawal, cairo }

extension ProductFontX on ProductFont {
  String get family => switch (this) {
        ProductFont.tajawal => 'Tajawal',
        ProductFont.cairo => 'Cairo',
      };

  String get labelKey => switch (this) {
        ProductFont.tajawal => LocaleKeys.store_font_tajawal,
        ProductFont.cairo => LocaleKeys.store_font_cairo,
      };

  static ProductFont fromString(String value) => switch (value) {
        'cairo' => ProductFont.cairo,
        _ => ProductFont.tajawal,
      };
}

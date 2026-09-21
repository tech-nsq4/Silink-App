import '../../../core/utils/locale_keys.dart';
import 'models/product.dart';

class StoreCatalog {
  StoreCatalog._();

  static const String specialOfferId = 'titanium-card';

  static List<Product> products() =>
      _rawProducts.map(Product.fromJson).toList(growable: false);

  static Product? productById(String id) {
    for (final raw in _rawProducts) {
      if (raw['id'] == id) return Product.fromJson(raw);
    }
    return null;
  }

  static const List<Map<String, dynamic>> _rawProducts = [
    {
      'id': specialOfferId,
      'name': 'بطاقة معدنية تيتانيوم',
      'category': 'metal_cards',
      'price': 289,
      'old_price': 349,
      'rating': 4.9,
      'review_count': 187,
      'badge': 'special_offer',
      'colors': [0xFF1F1F1F, 0xFFD9B76A, 0xFFB8B8B8],
      'default_color_index': 1,
      'color_label_keys': [
        LocaleKeys.store_color_black,
        LocaleKeys.store_color_gold,
        LocaleKeys.store_color_silver,
      ],
      'customizable': true,
      'image_gradient': [0xFFD9B76A, 0xFF8A6A2F],
      'description':
          'بطاقة فاخرة من التيتانيوم النقي مع طلاء لامع وشعار مطبوع بدقة عالية للاسم والمعلومات. تصميم مميز لا يُنسى.',
      'compatibility': 'NFC مع Android، iPhone 7 فأعلى',
      'delivery_time': '5-7 أيام عمل',
      'package_contents': [
        'بطاقة تيتانيوم × 1',
        'دليل الاستخدام',
        'ملصق QR احتياطي',
      ],
    },
    {
      'id': 'gold-card',
      'name': 'بطاقة معدنية ذهبية',
      'category': 'metal_cards',
      'price': 349,
      'rating': 4.9,
      'review_count': 120,
      'colors': [0xFFD9B76A],
      'color_label_keys': [LocaleKeys.store_color_gold],
      'customizable': true,
      'image_gradient': [0xFFD9B76A, 0xFF8A6A2F],
      'description':
          'بطاقة معدنية مطلية بالذهب عيار 24 قيراط، بتشطيب لامع فاخر وحفر دقيق للاسم والشعار. رمز تميز يعكس مكانتك المهنية.',
      'compatibility': 'NFC مع Android، iPhone 7 فأعلى',
      'delivery_time': '5-7 أيام عمل',
      'package_contents': [
        'بطاقة ذهبية × 1',
        'دليل الاستخدام',
        'علبة تغليف فاخرة',
      ],
    },
    {
      'id': 'nfc-premium',
      'name': 'بطاقة NFC بريميوم',
      'category': 'nfc_cards',
      'price': 149,
      'rating': 4.8,
      'review_count': 312,
      'badge': 'best_seller',
      'colors': [0xFFFFFFFF, 0xFFD9B76A, 0xFF1F1F1F],
      'default_color_index': 1,
      'color_label_keys': [
        LocaleKeys.store_color_white,
        LocaleKeys.store_color_gold,
        LocaleKeys.store_color_black,
      ],
      'customizable': true,
      'image_gradient': [0xFF2B2B2B, 0xFF0D0D0D],
      'description':
          'بطاقة NFC ذكية عالية الجودة مع طلاء لامع وشعار مطبوع بدقة عالية. تدعم جميع الهواتف الذكية الحديثة.',
      'compatibility': 'NFC مع Android، iPhone 7 فأعلى',
      'delivery_time': '5-7 أيام عمل',
      'package_contents': [
        'بطاقة NFC × 1',
        'دليل الاستخدام',
        'ملصق QR احتياطي',
      ],
    },
    {
      'id': 'nfc-classic',
      'name': 'بطاقة NFC كلاسيك',
      'category': 'nfc_cards',
      'price': 89,
      'rating': 4.6,
      'review_count': 96,
      'colors': [0xFF2F6FED, 0xFF1F1F1F, 0xFFFFFFFF],
      'color_label_keys': [
        LocaleKeys.store_color_blue,
        LocaleKeys.store_color_black,
        LocaleKeys.store_color_white,
      ],
      'customizable': true,
      'image_gradient': [0xFF2F6FED, 0xFF17212B],
      'description':
          'بطاقة NFC بلاستيكية متينة بتصميم كلاسيكي أنيق، مثالية للاستخدام اليومي بأداء موثوق وسعر مناسب.',
      'compatibility': 'NFC مع Android، iPhone 7 فأعلى',
      'delivery_time': '3-5 أيام عمل',
      'package_contents': [
        'بطاقة NFC × 1',
        'دليل الاستخدام',
      ],
    },
    {
      'id': 'nfc-medal',
      'name': 'ميدالية NFC فاخرة',
      'category': 'nfc_cards',
      'price': 199,
      'rating': 4.7,
      'review_count': 64,
      'colors': [0xFFB8B8B8, 0xFFD9B76A],
      'default_color_index': 1,
      'color_label_keys': [
        LocaleKeys.store_color_silver,
        LocaleKeys.store_color_gold,
      ],
      'customizable': true,
      'image_gradient': [0xFFD9B76A, 0xFF8A6A2F],
      'description':
          'ميدالية NFC معدنية فاخرة تُلبس أو تُعلّق، بتصميم مميز يجمع بين الأناقة والتقنية الذكية لمشاركة بياناتك بلمسة واحدة.',
      'compatibility': 'NFC مع Android، iPhone 7 فأعلى',
      'delivery_time': '5-7 أيام عمل',
      'package_contents': [
        'ميدالية NFC × 1',
        'سلسلة معدنية',
        'دليل الاستخدام',
      ],
    },
    {
      'id': 'nfc-sticker',
      'name': 'ملصق NFC للهاتف',
      'category': 'phone_stickers',
      'price': 49,
      'rating': 4.5,
      'review_count': 210,
      'colors': [0xFF17B78F, 0xFF1F1F1F],
      'color_label_keys': [
        LocaleKeys.store_color_green,
        LocaleKeys.store_color_black,
      ],
      'image_gradient': [0xFF17B78F, 0xFF2F6FED],
      'description':
          'ملصق NFC رفيع يُلصق خلف الهاتف مباشرة، حل عملي واقتصادي لمشاركة ملفك الرقمي بلمسة واحدة من غير بطاقة منفصلة.',
      'compatibility': 'NFC مع Android، iPhone 7 فأعلى',
      'delivery_time': '3-5 أيام عمل',
      'package_contents': [
        'ملصق NFC × 1',
        'مناديل تعقيم للصق',
      ],
    },
  ];
}

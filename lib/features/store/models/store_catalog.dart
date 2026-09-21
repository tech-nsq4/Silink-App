import '../../../core/utils/locale_keys.dart';
import 'product.dart';

class StoreCatalog {
  StoreCatalog._();

  static const String specialOfferId = 'titanium-card';

  static List<Product> products() => const [
        Product(
          id: specialOfferId,
          name: 'بطاقة معدنية تيتانيوم',
          category: ProductCategory.metalCards,
          price: 289,
          oldPrice: 349,
          rating: 4.9,
          reviewCount: 187,
          badge: ProductBadge.specialOffer,
          colorValues: [0xFF1F1F1F, 0xFFD9B76A, 0xFFB8B8B8],
          defaultColorIndex: 1,
          colorLabelKeys: [
            LocaleKeys.store_color_black,
            LocaleKeys.store_color_gold,
            LocaleKeys.store_color_silver,
          ],
          customizable: true,
          imageGradientValues: [0xFFD9B76A, 0xFF8A6A2F],
          description:
              'بطاقة فاخرة من التيتانيوم النقي مع طلاء لامع وشعار مطبوع بدقة عالية للاسم والمعلومات. تصميم مميز لا يُنسى.',
          compatibility: 'NFC مع Android، iPhone 7 فأعلى',
          deliveryTime: '5-7 أيام عمل',
          packageContents: [
            'بطاقة تيتانيوم × 1',
            'دليل الاستخدام',
            'ملصق QR احتياطي',
          ],
        ),
        Product(
          id: 'gold-card',
          name: 'بطاقة معدنية ذهبية',
          category: ProductCategory.metalCards,
          price: 349,
          rating: 4.9,
          reviewCount: 120,
          colorValues: [0xFFD9B76A],
          colorLabelKeys: [LocaleKeys.store_color_gold],
          customizable: true,
          imageGradientValues: [0xFFD9B76A, 0xFF8A6A2F],
          description:
              'بطاقة معدنية مطلية بالذهب عيار 24 قيراط، بتشطيب لامع فاخر وحفر دقيق للاسم والشعار. رمز تميز يعكس مكانتك المهنية.',
          compatibility: 'NFC مع Android، iPhone 7 فأعلى',
          deliveryTime: '5-7 أيام عمل',
          packageContents: [
            'بطاقة ذهبية × 1',
            'دليل الاستخدام',
            'علبة تغليف فاخرة',
          ],
        ),
        Product(
          id: 'nfc-premium',
          name: 'بطاقة NFC بريميوم',
          price: 149,
          rating: 4.8,
          reviewCount: 312,
          badge: ProductBadge.bestSeller,
          colorValues: [0xFFFFFFFF, 0xFFD9B76A, 0xFF1F1F1F],
          defaultColorIndex: 1,
          colorLabelKeys: [
            LocaleKeys.store_color_white,
            LocaleKeys.store_color_gold,
            LocaleKeys.store_color_black,
          ],
          customizable: true,
          imageGradientValues: [0xFF2B2B2B, 0xFF0D0D0D],
          description:
              'بطاقة NFC ذكية عالية الجودة مع طلاء لامع وشعار مطبوع بدقة عالية. تدعم جميع الهواتف الذكية الحديثة.',
          compatibility: 'NFC مع Android، iPhone 7 فأعلى',
          deliveryTime: '5-7 أيام عمل',
          packageContents: [
            'بطاقة NFC × 1',
            'دليل الاستخدام',
            'ملصق QR احتياطي',
          ],
        ),
        Product(
          id: 'nfc-classic',
          name: 'بطاقة NFC كلاسيك',
          price: 89,
          rating: 4.6,
          reviewCount: 96,
          colorValues: [0xFF2F6FED, 0xFF1F1F1F, 0xFFFFFFFF],
          colorLabelKeys: [
            LocaleKeys.store_color_blue,
            LocaleKeys.store_color_black,
            LocaleKeys.store_color_white,
          ],
          customizable: true,
          imageGradientValues: [0xFF2F6FED, 0xFF17212B],
          description:
              'بطاقة NFC بلاستيكية متينة بتصميم كلاسيكي أنيق، مثالية للاستخدام اليومي بأداء موثوق وسعر مناسب.',
          compatibility: 'NFC مع Android، iPhone 7 فأعلى',
          deliveryTime: '3-5 أيام عمل',
          packageContents: [
            'بطاقة NFC × 1',
            'دليل الاستخدام',
          ],
        ),
        Product(
          id: 'nfc-medal',
          name: 'ميدالية NFC فاخرة',
          price: 199,
          rating: 4.7,
          reviewCount: 64,
          colorValues: [0xFFB8B8B8, 0xFFD9B76A],
          defaultColorIndex: 1,
          colorLabelKeys: [
            LocaleKeys.store_color_silver,
            LocaleKeys.store_color_gold,
          ],
          customizable: true,
          imageGradientValues: [0xFFD9B76A, 0xFF8A6A2F],
          description:
              'ميدالية NFC معدنية فاخرة تُلبس أو تُعلّق، بتصميم مميز يجمع بين الأناقة والتقنية الذكية لمشاركة بياناتك بلمسة واحدة.',
          compatibility: 'NFC مع Android، iPhone 7 فأعلى',
          deliveryTime: '5-7 أيام عمل',
          packageContents: [
            'ميدالية NFC × 1',
            'سلسلة معدنية',
            'دليل الاستخدام',
          ],
        ),
        Product(
          id: 'nfc-sticker',
          name: 'ملصق NFC للهاتف',
          category: ProductCategory.phoneStickers,
          price: 49,
          rating: 4.5,
          reviewCount: 210,
          colorValues: [0xFF17B78F, 0xFF1F1F1F],
          colorLabelKeys: [
            LocaleKeys.store_color_green,
            LocaleKeys.store_color_black,
          ],
          imageGradientValues: [0xFF17B78F, 0xFF2F6FED],
          description:
              'ملصق NFC رفيع يُلصق خلف الهاتف مباشرة، حل عملي واقتصادي لمشاركة ملفك الرقمي بلمسة واحدة من غير بطاقة منفصلة.',
          compatibility: 'NFC مع Android، iPhone 7 فأعلى',
          deliveryTime: '3-5 أيام عمل',
          packageContents: [
            'ملصق NFC × 1',
            'مناديل تعقيم للصق',
          ],
        ),
      ];

  static Product? productById(String id) {
    for (final product in products()) {
      if (product.id == id) return product;
    }
    return null;
  }
}

import '../../../core/utils/app_constants.dart';
import '../../../core/utils/locale_keys.dart';
import 'cart_item.dart';
import 'payment_method.dart';
import 'shipping_address.dart';
import 'store_order.dart';

class DemoStoreData {
  DemoStoreData._();

  static const List<CartItem> cartItems = [
    CartItem(
      productId: 'titanium-card',
      name: 'بطاقة معدنية تيتانيوم',
      price: 289,
      quantity: 1,
      colorValue: 0xFFD9B76A,
      colorLabelKey: LocaleKeys.store_color_gold,
    ),
    CartItem(
      productId: 'nfc-premium',
      name: 'بطاقة NFC بريميوم',
      price: 149,
      quantity: 2,
      colorValue: 0xFFFFFFFF,
      colorLabelKey: LocaleKeys.store_color_white,
    ),
  ];

  static double get subtotal =>
      cartItems.fold<double>(0, (sum, item) => sum + item.total);

  static double get shipping => AppConstants.defaultShippingCost;

  static double get total => subtotal + shipping;

  static StoreOrder get lastOrder => StoreOrder(
        number: 'SL-202609-0148',
        createdAt: '2026-09-21 14:30',
        paymentMethod: PaymentMethod.creditCard,
        address: const ShippingAddress(
          fullName: 'أحمد محمود',
          phone: '+20 100 123 4567',
          city: 'القاهرة',
          district: 'مدينة نصر',
          street: 'شارع عباس العقاد',
        ),
        items: cartItems,
        subtotal: subtotal,
        shipping: shipping,
        total: total,
      );
}

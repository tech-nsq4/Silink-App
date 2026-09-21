import 'payment_method.dart';
import 'cart_item.dart';
import 'shipping_address.dart';

class StoreOrder {
  final String number;
  final String createdAt;
  final PaymentMethod paymentMethod;
  final ShippingAddress address;
  final List<CartItem> items;
  final double subtotal;
  final double shipping;
  final double total;

  const StoreOrder({
    required this.number,
    required this.createdAt,
    required this.paymentMethod,
    required this.address,
    required this.items,
    this.subtotal = 0,
    this.shipping = 0,
    this.total = 0,
  });

  int get itemsCount => items.fold(0, (count, item) => count + item.quantity);
}

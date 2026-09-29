import '../../../core/storage/local_storage.dart';
import 'models/cart_item.dart';

class CartRepo {
  CartRepo({required LocalStorage storage}) : _storage = storage;

  final LocalStorage _storage;

  static const _cartKey = 'cart_items';

  List<CartItem> getItems() {
    final raw = _storage.read<List<dynamic>>(_cartKey) ?? const [];
    return raw
        .whereType<Map>()
        .map((json) => CartItem.fromJson(Map<String, dynamic>.from(json)))
        .toList(growable: false);
  }

  Future<void> saveItems(List<CartItem> items) => _storage.write(
        _cartKey,
        items.map((item) => item.toJson()).toList(growable: false),
      );
}

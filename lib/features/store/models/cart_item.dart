class CartItem {
  final String productId;
  final String name;
  final double price;
  final int quantity;
  final int colorValue;
  final String colorLabelKey;
  final String summary;

  const CartItem({
    required this.productId,
    required this.name,
    required this.price,
    this.quantity = 1,
    this.colorValue = 0,
    this.colorLabelKey = '',
    this.summary = '',
  });

  double get total => price * quantity;

  bool matches(String id, int color) => productId == id && colorValue == color;
}

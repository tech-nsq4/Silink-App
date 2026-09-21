part of 'cart_cubit.dart';

class CartState extends Equatable {
  final List<CartItem> items;

  const CartState({this.items = const []});

  int get itemsCount => items.fold(0, (count, item) => count + item.quantity);

  double get subtotal => items.fold(0, (sum, item) => sum + item.total);

  bool get isEmpty => items.isEmpty;

  double get shipping =>
      isEmpty || subtotal >= AppConstants.defaultFreeShippingThreshold
          ? 0
          : AppConstants.defaultShippingCost;

  double get total => subtotal + shipping;

  CartState copyWith({List<CartItem>? items}) =>
      CartState(items: items ?? this.items);

  @override
  List<Object?> get props => [items];
}

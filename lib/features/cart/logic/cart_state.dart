part of 'cart_cubit.dart';

sealed class CartState extends Equatable {
  const CartState(this.items);

  final List<CartItem> items;

  bool get isEmpty => items.isEmpty;

  int get itemsCount => items.fold(0, (count, item) => count + item.quantity);

  double get subtotal => items.fold<double>(0, (sum, item) => sum + item.total);

  double get shipping =>
      isEmpty || subtotal >= AppConstants.defaultFreeShippingThreshold
          ? 0
          : AppConstants.defaultShippingCost;

  double get total => subtotal + shipping;

  @override
  List<Object?> get props => [items];
}

final class CartInitial extends CartState {
  const CartInitial() : super(const []);
}

final class CartUpdated extends CartState {
  const CartUpdated(super.items);
}

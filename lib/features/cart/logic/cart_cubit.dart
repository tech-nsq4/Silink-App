import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/app_constants.dart';
import '../data/cart_repo.dart';
import '../data/models/cart_item.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit(this._repo) : super(const CartInitial());

  final CartRepo _repo;

  void loadCart() => emit(CartUpdated(_repo.getItems()));

  void addItem(CartItem item) {
    final items = [...state.items];
    final index = items.indexWhere(item.isSameAs);
    if (index == -1) {
      items.add(item);
    } else {
      items[index] = items[index].copyWith(
        quantity: _clampQuantity(items[index].quantity + item.quantity),
      );
    }
    _update(items);
  }

  void updateQuantity(CartItem item, int quantity) {
    if (quantity < 1) return removeItem(item);
    _update([
      for (final current in state.items)
        current.isSameAs(item)
            ? current.copyWith(quantity: _clampQuantity(quantity))
            : current,
    ]);
  }

  void removeItem(CartItem item) => _update(
        state.items.where((current) => !current.isSameAs(item)).toList(),
      );

  void clear() => _update(const []);

  int _clampQuantity(int quantity) =>
      quantity.clamp(1, AppConstants.maxCartItemQuantity);

  void _update(List<CartItem> items) {
    emit(CartUpdated(List.unmodifiable(items)));
    _repo.saveItems(items);
  }
}

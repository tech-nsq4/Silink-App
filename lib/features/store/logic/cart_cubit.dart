import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/app_constants.dart';
import '../data/models/cart_item.dart';
import '../data/models/product.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(const CartState());

  void addItem(
    Product product, {
    required int colorIndex,
    int quantity = 1,
    String summary = '',
  }) {
    final colorValue = _colorValueAt(product, colorIndex);
    final colorLabelKey = _colorLabelAt(product, colorIndex);
    final items = [...state.items];
    final index =
        items.indexWhere((item) => item.matches(product.id, colorValue));

    if (index == -1) {
      items.add(
        CartItem(
          productId: product.id,
          name: product.name,
          price: product.price,
          quantity: quantity,
          colorValue: colorValue,
          colorLabelKey: colorLabelKey,
          summary: summary,
        ),
      );
    } else {
      items[index] = items[index].copyWith(
        quantity: items[index].quantity + quantity,
        summary: summary.isEmpty ? null : summary,
      );
    }

    emit(state.copyWith(items: items));
  }

  void increase(String productId, int colorValue) =>
      _updateQuantity(productId, colorValue, 1);

  void decrease(String productId, int colorValue) =>
      _updateQuantity(productId, colorValue, -1);

  void removeItem(String productId, {int? colorValue}) {
    final items = state.items
        .where((item) =>
            item.productId != productId ||
            (colorValue != null && item.colorValue != colorValue))
        .toList(growable: false);
    emit(state.copyWith(items: items));
  }

  void clear() => emit(const CartState());

  void _updateQuantity(String productId, int colorValue, int delta) {
    final items = [...state.items];
    final index =
        items.indexWhere((item) => item.matches(productId, colorValue));
    if (index == -1) return;

    final quantity = items[index].quantity + delta;
    if (quantity < 1) {
      items.removeAt(index);
    } else {
      items[index] = items[index].copyWith(quantity: quantity);
    }

    emit(state.copyWith(items: items));
  }

  int _colorValueAt(Product product, int index) =>
      index >= 0 && index < product.colorValues.length
          ? product.colorValues[index]
          : 0;

  String _colorLabelAt(Product product, int index) =>
      index >= 0 && index < product.colorLabelKeys.length
          ? product.colorLabelKeys[index]
          : '';
}

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/network/network_exceptions.dart';
import '../../../core/utils/app_overlay.dart';
import '../../cart/data/models/cart_item.dart';
import '../data/checkout_repo.dart';
import '../data/models/order_model.dart';
import '../data/models/payment_method.dart';
import '../data/models/shipping_address.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit(this._repo) : super(const CheckoutInitial());

  final CheckoutRepo _repo;

  Future<void> placeOrder({
    required ShippingAddress address,
    required PaymentMethod paymentMethod,
    required List<CartItem> items,
    required double subtotal,
    required double shipping,
  }) async {
    if (state is CheckoutLoading) return;
    emit(const CheckoutLoading());
    try {
      final order = await _repo.createOrder(
        address: address,
        paymentMethod: paymentMethod,
        items: items,
        subtotal: subtotal,
        shipping: shipping,
      );
      emit(CheckoutSuccess(order));
    } catch (e) {
      final msg = e is NetworkException ? e.message : e.toString();
      AppOverlay.showError(msg);
      emit(CheckoutError(msg));
    }
  }
}

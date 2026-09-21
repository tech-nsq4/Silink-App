import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/network/network_exceptions.dart';
import '../../../core/utils/app_overlay.dart';
import '../data/models/cart_item.dart';
import '../data/models/payment_method.dart';
import '../data/models/shipping_address.dart';
import '../data/models/store_order.dart';
import '../data/order_repo.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit(this._repo) : super(const CheckoutState());

  final OrderRepo _repo;

  void setAddress(ShippingAddress address) =>
      emit(state.copyWith(address: address));

  void setPaymentMethod(PaymentMethod method) =>
      emit(state.copyWith(paymentMethod: method));

  void setSaveAddress(bool value) => emit(state.copyWith(saveAddress: value));

  Future<StoreOrder?> placeOrder({
    required List<CartItem> items,
    required double subtotal,
    required double shipping,
    required double total,
  }) async {
    emit(state.copyWith(
      status: CheckoutStatus.submitting,
      failureMessage: '',
    ));

    final draft = StoreOrder(
      number: '',
      createdAt: '',
      paymentMethod: state.paymentMethod,
      address: state.address,
      items: items,
      subtotal: subtotal,
      shipping: shipping,
      total: total,
    );

    try {
      final order = await _repo.placeOrder(draft);
      emit(state.copyWith(status: CheckoutStatus.success, order: order));
      return order;
    } catch (error) {
      final message = error is NetworkException ? error.message : '$error';
      AppOverlay.showError(message);
      emit(state.copyWith(
        status: CheckoutStatus.failure,
        failureMessage: message,
      ));
      return null;
    }
  }
}

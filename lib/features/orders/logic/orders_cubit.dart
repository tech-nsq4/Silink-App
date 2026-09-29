import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/network/network_exceptions.dart';
import '../../../core/utils/app_overlay.dart';
import '../data/models/my_order_model.dart';
import '../data/orders_repo.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit(this._repo) : super(const OrdersInitial());

  final OrdersRepo _repo;

  Future<void> getOrders({bool silent = false}) async {
    final keepCurrent = silent && state is OrdersSuccess;
    if (!keepCurrent) emit(const OrdersLoading());
    try {
      final orders = await _repo.getOrders();
      emit(OrdersSuccess(orders));
    } catch (e) {
      final msg = e is NetworkException ? e.message : e.toString();
      AppOverlay.showError(msg);
      if (!keepCurrent) emit(OrdersError(msg));
    }
  }

  Future<void> refresh() => getOrders(silent: true);

  void replaceOrder(MyOrderModel order) {
    final current = state;
    if (current is! OrdersSuccess) return;
    emit(OrdersSuccess([
      for (final item in current.orders) item.id == order.id ? order : item,
    ]));
  }
}

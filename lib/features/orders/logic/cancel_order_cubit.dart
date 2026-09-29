import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/network/network_exceptions.dart';
import '../../../core/utils/app_overlay.dart';
import '../../../core/utils/locale_keys.dart';
import '../data/models/my_order_model.dart';
import '../data/orders_repo.dart';

part 'cancel_order_state.dart';

class CancelOrderCubit extends Cubit<CancelOrderState> {
  CancelOrderCubit(this._repo) : super(const CancelOrderInitial());

  final OrdersRepo _repo;

  Future<void> cancel(MyOrderModel order) async {
    if (state is CancelOrderLoading) return;
    emit(const CancelOrderLoading());
    try {
      final updated = await _repo.cancelOrder(order);
      AppOverlay.showSuccess(LocaleKeys.orders_cancelled_success.tr());
      emit(CancelOrderSuccess(updated));
    } catch (e) {
      final msg = e is NetworkException ? e.message : e.toString();
      AppOverlay.showError(msg);
      emit(CancelOrderError(msg));
    }
  }
}

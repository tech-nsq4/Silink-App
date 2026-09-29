part of 'cancel_order_cubit.dart';

sealed class CancelOrderState extends Equatable {
  const CancelOrderState();

  @override
  List<Object?> get props => [];
}

final class CancelOrderInitial extends CancelOrderState {
  const CancelOrderInitial();
}

final class CancelOrderLoading extends CancelOrderState {
  const CancelOrderLoading();
}

final class CancelOrderSuccess extends CancelOrderState {
  final MyOrderModel order;
  const CancelOrderSuccess(this.order);

  @override
  List<Object?> get props => [order];
}

final class CancelOrderError extends CancelOrderState {
  final String message;
  const CancelOrderError(this.message);

  @override
  List<Object?> get props => [message];
}

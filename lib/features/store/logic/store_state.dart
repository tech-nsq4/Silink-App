part of 'store_cubit.dart';

sealed class StoreState extends Equatable {
  const StoreState();

  @override
  List<Object?> get props => [];
}

final class StoreInitial extends StoreState {
  const StoreInitial();
}

final class StoreLoading extends StoreState {
  const StoreLoading();
}

final class StoreSuccess extends StoreState {
  final List<Product> products;

  const StoreSuccess({required this.products});

  @override
  List<Object?> get props => [products];
}

final class StoreError extends StoreState {
  final String message;

  const StoreError(this.message);

  @override
  List<Object?> get props => [message];
}

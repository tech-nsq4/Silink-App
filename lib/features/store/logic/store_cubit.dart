import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/network/network_exceptions.dart';
import '../../../core/utils/app_overlay.dart';
import '../data/models/product.dart';
import '../data/store_catalog.dart';
import '../data/store_repo.dart';

part 'store_state.dart';

class StoreCubit extends Cubit<StoreState> {
  StoreCubit(this._repo) : super(const StoreInitial());

  final StoreRepo _repo;

  Future<void> loadProducts({bool force = false}) async {
    if (!force && state is StoreSuccess) return;
    emit(const StoreLoading());
    try {
      final products = await _repo.fetchProducts();
      emit(StoreSuccess(
          products: products.isEmpty ? _repo.localProducts() : products));
    } on NetworkException {
      emit(StoreSuccess(products: _repo.localProducts()));
    } catch (error) {
      final message = error is NetworkException ? error.message : '$error';
      AppOverlay.showError(message);
      emit(StoreError(message));
    }
  }

  List<Product> get products => switch (state) {
        StoreSuccess(:final products) => products,
        _ => const <Product>[],
      };

  Product? get specialOffer {
    for (final product in products) {
      if (product.id == StoreCatalog.specialOfferId) return product;
    }
    return null;
  }

  Product? productById(String id) {
    for (final product in products) {
      if (product.id == id) return product;
    }
    return _repo.localProductById(id);
  }
}

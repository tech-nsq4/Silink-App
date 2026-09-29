import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/network/network_exceptions.dart';
import '../../../core/utils/app_overlay.dart';
import '../data/models/product.dart';
import '../data/store_repo.dart';

part 'store_state.dart';

class StoreCubit extends Cubit<StoreState> {
  StoreCubit(this._repo) : super(const StoreInitial());

  final StoreRepo _repo;

  Future<void> getProducts({bool silent = false}) async {
    final keepCurrent = silent && state is StoreSuccess;
    if (!keepCurrent) emit(const StoreLoading());
    try {
      final products = await _repo.getNfcProducts();
      emit(StoreSuccess(products));
    } catch (e) {
      final msg = e is NetworkException ? e.message : e.toString();
      AppOverlay.showError(msg);
      if (!keepCurrent) emit(StoreError(msg));
    }
  }

  Future<void> refresh() => getProducts(silent: true);
}

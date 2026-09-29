import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/network/network_exceptions.dart';
import '../../../core/utils/app_overlay.dart';
import '../data/checkout_repo.dart';
import '../data/models/city_model.dart';

part 'cities_state.dart';

class CitiesCubit extends Cubit<CitiesState> {
  CitiesCubit(this._repo) : super(const CitiesInitial());

  final CheckoutRepo _repo;

  Future<void> getCities() async {
    emit(const CitiesLoading());
    try {
      final cities = await _repo.getCities();
      emit(CitiesSuccess(cities));
    } catch (e) {
      final msg = e is NetworkException ? e.message : e.toString();
      AppOverlay.showError(msg);
      emit(CitiesError(msg));
    }
  }
}

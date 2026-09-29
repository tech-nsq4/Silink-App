import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/network/network_exceptions.dart';
import '../../../core/utils/app_overlay.dart';
import '../data/models/subscription_plan.dart';
import '../data/subscription_repo.dart';

part 'subscription_state.dart';

class SubscriptionCubit extends Cubit<SubscriptionState> {
  SubscriptionCubit(this._repo) : super(const SubscriptionInitial());

  final SubscriptionRepo _repo;

  Future<void> getSubscriptions({bool silent = false}) async {
    final keepCurrent = silent && state is SubscriptionSuccess;
    if (!keepCurrent) emit(const SubscriptionLoading());
    try {
      final plans = await _repo.getSubscriptions();
      emit(SubscriptionSuccess(plans));
    } catch (e) {
      final msg = e is NetworkException ? e.message : e.toString();
      AppOverlay.showError(msg);
      if (!keepCurrent) emit(SubscriptionError(msg));
    }
  }

  Future<void> refresh() => getSubscriptions(silent: true);
}

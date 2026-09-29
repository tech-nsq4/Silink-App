import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/network/network_exceptions.dart';
import '../../../core/utils/app_overlay.dart';
import '../data/faq_repo.dart';
import '../data/models/faq.dart';

part 'faq_state.dart';

class FaqCubit extends Cubit<FaqState> {
  FaqCubit(this._repo) : super(const FaqInitial());

  final FaqRepo _repo;

  Future<void> getFaqs({bool silent = false}) async {
    final keepCurrent = silent && state is FaqSuccess;
    if (!keepCurrent) emit(const FaqLoading());
    try {
      final faqs = await _repo.getFaqs();
      emit(FaqSuccess(faqs));
    } catch (e) {
      final msg = e is NetworkException ? e.message : e.toString();
      AppOverlay.showError(msg);
      if (!keepCurrent) emit(FaqError(msg));
    }
  }

  Future<void> refresh() => getFaqs(silent: true);
}

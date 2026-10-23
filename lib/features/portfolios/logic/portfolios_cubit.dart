import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/network/network_exceptions.dart';
import '../../../core/utils/app_overlay.dart';
import '../../../core/utils/locale_keys.dart';
import '../data/models/portfolio_model.dart';
import '../data/portfolios_repo.dart';

part 'portfolios_state.dart';

class PortfoliosCubit extends Cubit<PortfoliosState> {
  PortfoliosCubit(this._repo) : super(const PortfoliosInitial());

  final PortfoliosRepo _repo;

  PortfoliosSuccess? get _ready {
    final current = state;
    return current is PortfoliosSuccess ? current : null;
  }

  String _message(Object e) => e is NetworkException ? e.message : e.toString();

  PortfolioModel? byId(String id) =>
      _ready?.portfolios.where((p) => p.id == id).firstOrNull;

  void seed(List<PortfolioModel> portfolios) =>
      emit(PortfoliosSuccess(portfolios));

  Future<void> load() async {
    if (_ready == null) emit(const PortfoliosLoading());
    try {
      final portfolios = await _repo.getPortfolios();
      if (isClosed) return;
      emit(PortfoliosSuccess(portfolios));
    } catch (e) {
      if (isClosed) return;
      final msg = _message(e);
      if (_ready == null) {
        emit(PortfoliosError(msg));
      } else {
        AppOverlay.showError(msg);
      }
    }
  }

  void _replace(PortfolioModel updated) {
    final current = _ready;
    if (current == null) return;
    emit(current.copyWith(portfolios: [
      for (final p in current.portfolios) p.id == updated.id ? updated : p,
    ]));
  }

  Future<void> toggleActive(PortfolioModel portfolio) async {
    final current = _ready;
    if (current == null || current.busyId != null) return;
    final updated = portfolio.copyWith(isActive: !portfolio.isActive);
    emit(current.copyWith(busyId: portfolio.id));
    _replace(updated);
    try {
      await _repo.setActive(portfolio.id, updated.isActive);
      emit(_ready!.copyWith(clearBusy: true));
    } catch (e) {
      AppOverlay.showError(_message(e));
      _replace(portfolio);
      emit(_ready!.copyWith(clearBusy: true));
    }
  }

  Future<bool> delete(PortfolioModel portfolio) async {
    final current = _ready;
    if (current == null || current.busyId != null) return false;
    emit(current.copyWith(busyId: portfolio.id));
    try {
      await _repo.delete(portfolio.id);
      emit(_ready!.copyWith(
        clearBusy: true,
        portfolios:
            _ready!.portfolios.where((p) => p.id != portfolio.id).toList(),
      ));
      AppOverlay.showSuccess(LocaleKeys.portfolios_deleted.tr());
      return true;
    } catch (e) {
      AppOverlay.showError(_message(e));
      emit(_ready!.copyWith(clearBusy: true));
      return false;
    }
  }
}

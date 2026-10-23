import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/network/network_exceptions.dart';
import '../data/models/remote_page.dart';
import '../data/pages_repo.dart';

part 'static_page_state.dart';

class StaticPageCubit extends Cubit<StaticPageState> {
  StaticPageCubit(this._repo) : super(const StaticPageInitial());

  final PagesRepo _repo;

  Future<void> load(String slug) async {
    emit(const StaticPageLoading());
    try {
      final page = await _repo.getPage(slug);
      if (isClosed) return;
      emit(StaticPageSuccess(page));
    } catch (e) {
      if (isClosed) return;
      emit(StaticPageError(e is NetworkException ? e.message : e.toString()));
    }
  }
}

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/network/network_exceptions.dart';
import '../../../core/utils/app_overlay.dart';
import '../data/models/file_category_model.dart';
import '../data/models/my_file_model.dart';
import '../data/my_files_repo.dart';

part 'my_files_state.dart';

class MyFilesCubit extends Cubit<MyFilesState> {
  MyFilesCubit(this._repo) : super(const MyFilesInitial());

  final MyFilesRepo _repo;

  Future<void> getFiles({bool silent = false}) async {
    final keepCurrent = silent && state is MyFilesSuccess;
    if (!keepCurrent) emit(const MyFilesLoading());
    try {
      final results = await Future.wait([
        _repo.getFiles(),
        _repo.getCategories(),
      ]);
      final files = results[0] as List<MyFileModel>;
      final categories = results[1] as List<FileCategoryModel>;
      emit(MyFilesSuccess(
        files: files,
        categories: categories,
      ));
    } catch (e) {
      final msg = e is NetworkException ? e.message : e.toString();
      AppOverlay.showError(msg);
      if (!keepCurrent) emit(MyFilesError(msg));
    }
  }

  Future<void> refresh() => getFiles(silent: true);
}

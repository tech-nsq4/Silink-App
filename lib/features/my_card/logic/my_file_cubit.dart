import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/network/network_exceptions.dart';
import '../../../core/utils/app_overlay.dart';
import '../../../core/utils/locale_keys.dart';
import '../data/models/my_file_model.dart';
import '../data/my_files_repo.dart';

part 'my_file_state.dart';

class MyFileCubit extends Cubit<MyFileState> {
  MyFileCubit(this._repo) : super(const MyFileInitial());

  final MyFilesRepo _repo;

  Future<void> getFile(String id) async {
    emit(const MyFileLoading());
    try {
      final file = await _repo.getFile(id);
      emit(MyFileLoaded(file));
    } catch (e) {
      _emitError(e);
    }
  }

  Future<void> createFile({
    required String name,
    required String note,
    required List<String> categoryIds,
    required File file,
  }) async {
    emit(const MyFileSubmitting());
    try {
      await _repo.createFile(
        name: name,
        note: note,
        categoryIds: categoryIds,
        file: file,
      );
      AppOverlay.showSuccess(LocaleKeys.myFiles_saved.tr());
      emit(const MyFileSaved());
    } catch (e) {
      _emitError(e);
    }
  }

  Future<void> updateFile({
    required String id,
    required String name,
    required String note,
    required List<String> categoryIds,
    File? file,
  }) async {
    emit(const MyFileSubmitting());
    try {
      await _repo.updateFile(
        id: id,
        name: name,
        note: note,
        categoryIds: categoryIds,
        file: file,
      );
      AppOverlay.showSuccess(LocaleKeys.myFiles_saved.tr());
      emit(const MyFileSaved());
    } catch (e) {
      _emitError(e);
    }
  }

  Future<void> deleteFile(String id) async {
    emit(const MyFileSubmitting());
    try {
      await _repo.deleteFile(id);
      AppOverlay.showSuccess(LocaleKeys.myFiles_deleted.tr());
      emit(MyFileDeleted(id));
    } catch (e) {
      _emitError(e);
    }
  }

  void _emitError(Object e) {
    final msg = e is NetworkException ? e.message : e.toString();
    AppOverlay.showError(msg);
    emit(MyFileError(msg));
  }
}

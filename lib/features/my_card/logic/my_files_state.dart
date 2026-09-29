part of 'my_files_cubit.dart';

sealed class MyFilesState extends Equatable {
  const MyFilesState();

  @override
  List<Object?> get props => [];
}

final class MyFilesInitial extends MyFilesState {
  const MyFilesInitial();
}

final class MyFilesLoading extends MyFilesState {
  const MyFilesLoading();
}

final class MyFilesSuccess extends MyFilesState {
  final List<MyFileModel> files;
  final List<FileCategoryModel> categories;
  const MyFilesSuccess({required this.files, required this.categories});

  @override
  List<Object?> get props => [files, categories];
}

final class MyFilesError extends MyFilesState {
  final String message;
  const MyFilesError(this.message);

  @override
  List<Object?> get props => [message];
}

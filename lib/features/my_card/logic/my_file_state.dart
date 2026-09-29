part of 'my_file_cubit.dart';

sealed class MyFileState extends Equatable {
  const MyFileState();

  @override
  List<Object?> get props => [];
}

final class MyFileInitial extends MyFileState {
  const MyFileInitial();
}

final class MyFileLoading extends MyFileState {
  const MyFileLoading();
}

final class MyFileLoaded extends MyFileState {
  final MyFileModel file;
  const MyFileLoaded(this.file);

  @override
  List<Object?> get props => [file];
}

final class MyFileSubmitting extends MyFileState {
  const MyFileSubmitting();
}

final class MyFileSaved extends MyFileState {
  const MyFileSaved();
}

final class MyFileDeleted extends MyFileState {
  final String id;
  const MyFileDeleted(this.id);

  @override
  List<Object?> get props => [id];
}

final class MyFileError extends MyFileState {
  final String message;
  const MyFileError(this.message);

  @override
  List<Object?> get props => [message];
}

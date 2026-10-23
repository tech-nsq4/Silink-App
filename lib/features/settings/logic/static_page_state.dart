part of 'static_page_cubit.dart';

sealed class StaticPageState extends Equatable {
  const StaticPageState();

  @override
  List<Object?> get props => [];
}

final class StaticPageInitial extends StaticPageState {
  const StaticPageInitial();
}

final class StaticPageLoading extends StaticPageState {
  const StaticPageLoading();
}

final class StaticPageSuccess extends StaticPageState {
  const StaticPageSuccess(this.page);

  final RemotePage? page;

  @override
  List<Object?> get props => [page];
}

final class StaticPageError extends StaticPageState {
  const StaticPageError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

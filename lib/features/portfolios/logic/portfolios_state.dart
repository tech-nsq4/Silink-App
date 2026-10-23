part of 'portfolios_cubit.dart';

sealed class PortfoliosState extends Equatable {
  const PortfoliosState();

  @override
  List<Object?> get props => [];
}

final class PortfoliosInitial extends PortfoliosState {
  const PortfoliosInitial();
}

final class PortfoliosLoading extends PortfoliosState {
  const PortfoliosLoading();
}

final class PortfoliosSuccess extends PortfoliosState {
  const PortfoliosSuccess(this.portfolios, {this.busyId});

  final List<PortfolioModel> portfolios;
  final String? busyId;

  PortfoliosSuccess copyWith({
    List<PortfolioModel>? portfolios,
    String? busyId,
    bool clearBusy = false,
  }) =>
      PortfoliosSuccess(
        portfolios ?? this.portfolios,
        busyId: clearBusy ? null : (busyId ?? this.busyId),
      );

  @override
  List<Object?> get props => [portfolios, busyId];
}

final class PortfoliosError extends PortfoliosState {
  const PortfoliosError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

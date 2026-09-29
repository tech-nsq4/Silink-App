part of 'cities_cubit.dart';

sealed class CitiesState extends Equatable {
  const CitiesState();

  @override
  List<Object?> get props => [];
}

final class CitiesInitial extends CitiesState {
  const CitiesInitial();
}

final class CitiesLoading extends CitiesState {
  const CitiesLoading();
}

final class CitiesSuccess extends CitiesState {
  final List<CityModel> cities;
  const CitiesSuccess(this.cities);

  @override
  List<Object?> get props => [cities];
}

final class CitiesError extends CitiesState {
  final String message;
  const CitiesError(this.message);

  @override
  List<Object?> get props => [message];
}

part of 'brand_cubit.dart';

class BrandData extends Equatable {
  final AppearanceModel appearance;
  final TemplateSettings templates;
  final CompanyProfileModel company;

  const BrandData({
    required this.appearance,
    required this.templates,
    required this.company,
  });

  @override
  List<Object?> get props => [appearance, templates, company];
}

sealed class BrandState extends Equatable {
  const BrandState();

  @override
  List<Object?> get props => [];
}

final class BrandInitial extends BrandState {
  const BrandInitial();
}

final class BrandLoading extends BrandState {
  const BrandLoading();
}

final class BrandSuccess extends BrandState {
  final BrandData data;
  const BrandSuccess(this.data);

  @override
  List<Object?> get props => [data];
}

final class BrandSaving extends BrandState {
  final BrandData data;
  const BrandSaving(this.data);

  @override
  List<Object?> get props => [data];
}

final class BrandSaved extends BrandState {
  final BrandData data;
  const BrandSaved(this.data);

  @override
  List<Object?> get props => [data];
}

final class BrandError extends BrandState {
  final String message;
  const BrandError(this.message);

  @override
  List<Object?> get props => [message];
}

part of 'company_catalog_cubit.dart';

sealed class CompanyCatalogState extends Equatable {
  const CompanyCatalogState();

  @override
  List<Object?> get props => [];
}

final class CompanyCatalogInitial extends CompanyCatalogState {
  const CompanyCatalogInitial();
}

final class CompanyCatalogLoading extends CompanyCatalogState {
  const CompanyCatalogLoading();
}

final class CompanyCatalogSuccess extends CompanyCatalogState {
  const CompanyCatalogSuccess({
    required this.items,
    required this.actionTypes,
    required this.sections,
    required this.productsEnabled,
    required this.servicesEnabled,
    this.busyId,
  });

  final List<CatalogItemModel> items;
  final List<CatalogActionType> actionTypes;
  final Map<String, String> sections;
  final bool productsEnabled;
  final bool servicesEnabled;
  final String? busyId;

  List<CatalogItemModel> ofKind(String kind) =>
      items.where((item) => item.kind == kind).toList()
        ..sort((a, b) => a.sortOrder.compareTo(b.sortOrder));

  String sectionOf(CatalogItemModel item) => sections[item.id] ?? '';

  List<String> get sectionNames => {
        for (final item in ofKind(CompanyCatalogCubit.itemKind))
          if (sectionOf(item).isNotEmpty) sectionOf(item),
      }.toList();

  CompanyCatalogSuccess copyWith({
    List<CatalogItemModel>? items,
    Map<String, String>? sections,
    bool? productsEnabled,
    bool? servicesEnabled,
    String? busyId,
    bool clearBusy = false,
  }) =>
      CompanyCatalogSuccess(
        items: items ?? this.items,
        actionTypes: actionTypes,
        sections: sections ?? this.sections,
        productsEnabled: productsEnabled ?? this.productsEnabled,
        servicesEnabled: servicesEnabled ?? this.servicesEnabled,
        busyId: clearBusy ? null : (busyId ?? this.busyId),
      );

  @override
  List<Object?> get props => [
        items,
        actionTypes,
        sections,
        productsEnabled,
        servicesEnabled,
        busyId,
      ];
}

final class CompanyCatalogError extends CompanyCatalogState {
  const CompanyCatalogError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

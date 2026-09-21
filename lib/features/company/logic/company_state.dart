import '../data/models/company.dart';
import '../data/models/company_card.dart';
import '../data/models/company_employee.dart';

class CompanyState {
  const CompanyState({
    this.company = const Company(),
    this.cards = const [],
    this.employees = const [],
    this.isLoading = false,
    this.isCreated = false,
    this.isPublished = false,
  });

  final Company company;
  final List<CompanyCard> cards;
  final List<CompanyEmployee> employees;
  final bool isLoading;
  final bool isCreated;
  final bool isPublished;

  int get activeCardsCount =>
      cards.where((card) => card.status == CompanyCardStatus.active).length;

  int get suspendedCardsCount => cards
      .where((card) => card.status == CompanyCardStatus.suspended)
      .length;

  CompanyState copyWith({
    Company? company,
    List<CompanyCard>? cards,
    List<CompanyEmployee>? employees,
    bool? isLoading,
    bool? isCreated,
    bool? isPublished,
  }) {
    return CompanyState(
      company: company ?? this.company,
      cards: cards ?? this.cards,
      employees: employees ?? this.employees,
      isLoading: isLoading ?? this.isLoading,
      isCreated: isCreated ?? this.isCreated,
      isPublished: isPublished ?? this.isPublished,
    );
  }
}

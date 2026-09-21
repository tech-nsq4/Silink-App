import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/company_repo.dart';
import '../data/models/company.dart';
import '../data/models/company_business_type.dart';
import '../data/models/company_card.dart';
import '../data/models/company_employee.dart';
import 'company_state.dart';

class CompanyCubit extends Cubit<CompanyState> {
  CompanyCubit({required CompanyRepo repo})
      : _repo = repo,
        super(const CompanyState());

  final CompanyRepo _repo;

  void updateCompany(Company company) {
    emit(state.copyWith(company: company));
  }

  void setField({
    String? name,
    String? logoUrl,
    String? registrationNumber,
    String? taxNumber,
    String? activityDescription,
    String? email,
    String? phone,
    String? website,
    CompanyBusinessType? businessType,
    String? activityNature,
    bool? hasOnlineStore,
    String? city,
    String? district,
    String? employeesRange,
    String? brandColorHex,
    bool? showLogoOnBrand,
  }) {
    emit(
      state.copyWith(
        company: state.company.copyWith(
          name: name,
          logoUrl: logoUrl,
          registrationNumber: registrationNumber,
          taxNumber: taxNumber,
          activityDescription: activityDescription,
          email: email,
          phone: phone,
          website: website,
          businessType: businessType,
          activityNature: activityNature,
          hasOnlineStore: hasOnlineStore,
          city: city,
          district: district,
          employeesRange: employeesRange,
          brandColorHex: brandColorHex,
          showLogoOnBrand: showLogoOnBrand,
        ),
      ),
    );
  }

  Future<void> submitCompany() async {
    emit(state.copyWith(isLoading: true));
    try {
      final company = await _repo.createCompany(state.company);
      emit(
        state.copyWith(
          company: company,
          isLoading: false,
          isCreated: true,
        ),
      );
    } catch (_) {
      emit(state.copyWith(isLoading: false));
      rethrow;
    }
  }

  void addCatalogItem(String item) {
    final catalog = [...state.company.catalog, item];
    emit(state.copyWith(company: state.company.copyWith(catalog: catalog)));
  }

  void toggleCatalogItem(int index) {
    final catalog = [...state.company.catalog];
    catalog[index] = catalog[index].startsWith('*OFF*')
        ? catalog[index].substring(5)
        : '*OFF*${catalog[index]}';
    emit(state.copyWith(company: state.company.copyWith(catalog: catalog)));
  }

  void removeCatalogItem(int index) {
    final catalog = [...state.company.catalog]..removeAt(index);
    emit(state.copyWith(company: state.company.copyWith(catalog: catalog)));
  }

  void addCard(String name, String code) {
    final card = CompanyCard(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      name: name,
      code: code,
    );
    emit(state.copyWith(cards: [...state.cards, card]));
  }

  void toggleCardStatus(String cardId) {
    final cards = state.cards.map((card) {
      if (card.id != cardId) return card;
      return card.copyWith(
        status: card.status == CompanyCardStatus.active
            ? CompanyCardStatus.suspended
            : CompanyCardStatus.active,
      );
    }).toList();
    emit(state.copyWith(cards: cards));
  }

  void inviteEmployee({
    required String name,
    required String email,
    required String phone,
    required String role,
    required String permission,
  }) {
    final employee = CompanyEmployee(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      name: name,
      email: email,
      phone: phone,
      role: role,
      permission: permission,
      status: CompanyEmployeeStatus.pending,
    );
    emit(state.copyWith(employees: [...state.employees, employee]));
  }

  void updateEmployee(CompanyEmployee employee) {
    final employees = state.employees
        .map((item) => item.id == employee.id ? employee : item)
        .toList();
    emit(state.copyWith(employees: employees));
  }

  void removeEmployee(String employeeId) {
    final employees =
        state.employees.where((item) => item.id != employeeId).toList();
    emit(state.copyWith(employees: employees));
  }

  void togglePublished() {
    emit(state.copyWith(isPublished: !state.isPublished));
  }

  void reset() => emit(const CompanyState());

  CompanyEmployee? employeeById(String id) {
    for (final employee in state.employees) {
      if (employee.id == id) return employee;
    }
    return null;
  }

  static String generateCardCode() {
    final random = Random();
    return 'NFC-${100 + random.nextInt(900)}';
  }

  static String? emailValidator(String? value) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) return 'company.error_required';
    final valid = RegExp(r'^[\w.\-+]+@[\w\-]+\.[\w.\-]+$').hasMatch(trimmed);
    return valid ? null : 'company.error_email';
  }

  static String? requiredValidator(String? value) {
    return (value == null || value.trim().isEmpty)
        ? 'company.error_required'
        : null;
  }
}

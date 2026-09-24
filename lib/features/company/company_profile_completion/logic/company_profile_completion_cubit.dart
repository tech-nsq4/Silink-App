import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/network_exceptions.dart';
import '../../../../core/utils/app_overlay.dart';
import '../data/company_profile_completion_repo.dart';
import '../data/models/company_details_model.dart';
import '../data/models/company_option_model.dart';
import '../data/models/company_profile_model.dart';

part 'company_profile_completion_state.dart';

class CompanyProfileCompletionCubit
    extends Cubit<CompanyProfileCompletionState> {
  CompanyProfileCompletionCubit(this._repo)
      : super(const CompanyProfileCompletionState());

  final CompanyProfileCompletionRepo _repo;

  String _errorMessage(Object e) =>
      e is NetworkException ? e.message : e.toString();

  // ─── Company ──────────────────────────────────────────────────────────────

  Future<void> loadCompanyProfile({bool force = false}) async {
    if (state.companyLoaded && !force) return;
    emit(state.copyWith(companyLoading: true, clearCompanyError: true));
    try {
      final company = await _repo.getCompanyProfile();
      emit(state.copyWith(companyLoading: false, company: company));
    } catch (e) {
      emit(state.copyWith(
        companyLoading: false,
        companyError: _errorMessage(e),
      ));
    }
  }

  void pickCompanyLogo(File file) {
    emit(state.copyWith(companyLogoFile: file));
  }

  Future<bool> saveCompanyProfile({
    required String companyName,
    required String about,
    required String website,
  }) async {
    emit(state.copyWith(isSavingStep: true));
    try {
      final company = await _repo.saveCompanyProfile(
        companyName: companyName,
        about: about,
        website: website,
        logo: state.companyLogoFile,
      );
      emit(state.copyWith(
        isSavingStep: false,
        company: company,
        clearCompanyLogoFile: true,
      ));
      return true;
    } catch (e) {
      emit(state.copyWith(isSavingStep: false));
      AppOverlay.showError(_errorMessage(e));
      return false;
    }
  }

  // ─── Industry ─────────────────────────────────────────────────────────────

  Future<void> loadIndustries({bool force = false}) async {
    if (state.industryLoaded && !force) return;
    emit(state.copyWith(industryLoading: true, clearIndustryError: true));
    try {
      final industry = await _repo.getIndustries();
      emit(state.copyWith(industryLoading: false, industry: industry));
    } catch (e) {
      emit(state.copyWith(
        industryLoading: false,
        industryError: _errorMessage(e),
      ));
    }
  }

  void selectIndustry(String id) {
    final industry = state.industry;
    if (industry == null) return;
    emit(state.copyWith(industry: industry.copyWith(selectedId: id)));
  }

  Future<bool> saveIndustry() async {
    final industry = state.industry;
    if (industry?.selectedId == null) return false;
    emit(state.copyWith(isSavingStep: true));
    try {
      final result = await _repo.saveIndustry(industry!.selectedId!);
      emit(state.copyWith(
        isSavingStep: false,
        industry: result,
        clearSubIndustry: true,
      ));
      return true;
    } catch (e) {
      emit(state.copyWith(isSavingStep: false));
      AppOverlay.showError(_errorMessage(e));
      return false;
    }
  }

  // ─── Sub-industry ─────────────────────────────────────────────────────────

  Future<void> loadSubIndustries({bool force = false}) async {
    if (state.subIndustryLoaded && !force) return;
    emit(
        state.copyWith(subIndustryLoading: true, clearSubIndustryError: true));
    try {
      final subIndustry = await _repo.getSubIndustries();
      emit(state.copyWith(subIndustryLoading: false, subIndustry: subIndustry));
    } catch (e) {
      emit(state.copyWith(
        subIndustryLoading: false,
        subIndustryError: _errorMessage(e),
      ));
    }
  }

  void selectSubIndustry(String id) {
    final subIndustry = state.subIndustry;
    if (subIndustry == null) return;
    emit(state.copyWith(subIndustry: subIndustry.copyWith(selectedId: id)));
  }

  Future<bool> saveSubIndustry() async {
    final subIndustry = state.subIndustry;
    if (subIndustry == null || subIndustry.industries.isEmpty) return true;
    if (subIndustry.selectedId == null) return false;
    emit(state.copyWith(isSavingStep: true));
    try {
      final result = await _repo.saveSubIndustry(subIndustry.selectedId!);
      emit(state.copyWith(isSavingStep: false, subIndustry: result));
      return true;
    } catch (e) {
      emit(state.copyWith(isSavingStep: false));
      AppOverlay.showError(_errorMessage(e));
      return false;
    }
  }

  // ─── Details ──────────────────────────────────────────────────────────────

  Future<void> loadDetails({bool force = false}) async {
    if (state.detailsLoaded && !force) return;
    emit(state.copyWith(detailsLoading: true, clearDetailsError: true));
    try {
      final details = await _repo.getDetails();
      emit(state.copyWith(detailsLoading: false, details: details));
    } catch (e) {
      emit(state.copyWith(
        detailsLoading: false,
        detailsError: _errorMessage(e),
      ));
    }
  }

  void selectCompanySize(String type) {
    final details = state.details;
    if (details == null) return;
    emit(state.copyWith(details: details.copyWith(companySize: type)));
  }

  void selectCity(String id) {
    final details = state.details;
    if (details == null) return;
    emit(state.copyWith(details: details.copyWith(cityId: id)));
  }

  Future<bool> saveDetails({
    required String contactPhone,
    required String companyEmail,
  }) async {
    final details = state.details;
    if (details?.companySize == null || details?.cityId == null) return false;
    emit(state.copyWith(isSavingStep: true));
    try {
      final result = await _repo.saveDetails(
        companySize: details!.companySize!,
        cityId: details.cityId!,
        contactPhone: contactPhone,
        companyEmail: companyEmail,
      );
      emit(state.copyWith(isSavingStep: false, details: result));
      return true;
    } catch (e) {
      emit(state.copyWith(isSavingStep: false));
      AppOverlay.showError(_errorMessage(e));
      return false;
    }
  }
}

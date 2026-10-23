import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/network_exceptions.dart';
import '../../../../core/utils/app_overlay.dart';
import '../../../profile_completion/data/models/appearance_model.dart';
import '../../../profile_completion/data/models/template_model.dart';
import '../../../profile_completion/data/profile_completion_repo.dart';
import '../../company_profile_completion/data/company_profile_completion_repo.dart';
import '../../company_profile_completion/data/models/company_profile_model.dart';

part 'brand_state.dart';

class BrandCubit extends Cubit<BrandState> {
  BrandCubit(this._repo, this._companyRepo) : super(const BrandInitial());

  final ProfileCompletionRepo _repo;
  final CompanyProfileCompletionRepo _companyRepo;
  BrandData? _data;

  Future<void> getBrand() async {
    emit(const BrandLoading());
    try {
      final results = await Future.wait([
        _repo.getAppearance(),
        _repo.getTemplates(),
        _companyRepo.getCompanyProfile(),
      ]);
      final data = BrandData(
        appearance: results[0] as AppearanceModel,
        templates: results[1] as TemplateSettings,
        company: results[2] as CompanyProfileModel,
      );
      _data = data;
      emit(BrandSuccess(data));
    } catch (e) {
      final msg = e is NetworkException ? e.message : e.toString();
      emit(BrandError(msg));
      AppOverlay.showError(msg);
    }
  }

  Future<void> save({
    required String primaryColor,
    required String templateId,
    required String tagline,
  }) async {
    final current = _data;
    if (current == null) return;
    emit(BrandSaving(current));
    try {
      var appearance = current.appearance;
      var templates = current.templates;
      var company = current.company;
      if (appearance.primaryColor.toLowerCase() != primaryColor.toLowerCase()) {
        final saved = await _repo.saveAppearance(
          appearance.copyWith(
            primaryColor: primaryColor,
            coverColor: primaryColor,
          ),
        );
        appearance = saved;
      }
      if (templateId.isNotEmpty && templateId != templates.selectedId) {
        templates = await _repo.saveTemplate(templateId);
      }
      if (tagline != company.about) {
        company = await _companyRepo.saveCompanyProfile(
          companyName: company.companyName,
          about: tagline,
          website: company.website,
          companyEmail: company.companyEmail,
          industryId: company.industryId,
        );
      }
      final data = BrandData(
        appearance: appearance,
        templates: templates,
        company: company,
      );
      _data = data;
      emit(BrandSaved(data));
    } catch (e) {
      final msg = e is NetworkException ? e.message : e.toString();
      emit(BrandSuccess(current));
      AppOverlay.showError(msg);
    }
  }
}

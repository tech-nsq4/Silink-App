part of 'company_profile_completion_cubit.dart';

class CompanyProfileCompletionState extends Equatable {
  final bool companyLoading;
  final CompanyProfileModel? company;
  final String? companyError;
  final File? companyLogoFile;

  final bool industryLoading;
  final CompanyIndustryModel? industry;
  final String? industryError;

  final bool subIndustryLoading;
  final CompanySubIndustryModel? subIndustry;
  final String? subIndustryError;

  final bool detailsLoading;
  final CompanyDetailsModel? details;
  final String? detailsError;

  final bool isSavingStep;

  const CompanyProfileCompletionState({
    this.companyLoading = false,
    this.company,
    this.companyError,
    this.companyLogoFile,
    this.industryLoading = false,
    this.industry,
    this.industryError,
    this.subIndustryLoading = false,
    this.subIndustry,
    this.subIndustryError,
    this.detailsLoading = false,
    this.details,
    this.detailsError,
    this.isSavingStep = false,
  });

  bool get companyLoaded => company != null || companyError != null;
  bool get industryLoaded => industry != null || industryError != null;
  bool get subIndustryLoaded =>
      subIndustry != null || subIndustryError != null;
  bool get detailsLoaded => details != null || detailsError != null;

  CompanyProfileCompletionState copyWith({
    bool? companyLoading,
    CompanyProfileModel? company,
    String? companyError,
    bool clearCompanyError = false,
    File? companyLogoFile,
    bool clearCompanyLogoFile = false,
    bool? industryLoading,
    CompanyIndustryModel? industry,
    String? industryError,
    bool clearIndustryError = false,
    bool? subIndustryLoading,
    CompanySubIndustryModel? subIndustry,
    String? subIndustryError,
    bool clearSubIndustryError = false,
    bool clearSubIndustry = false,
    bool? detailsLoading,
    CompanyDetailsModel? details,
    String? detailsError,
    bool clearDetailsError = false,
    bool? isSavingStep,
  }) {
    return CompanyProfileCompletionState(
      companyLoading: companyLoading ?? this.companyLoading,
      company: company ?? this.company,
      companyError:
          clearCompanyError ? null : (companyError ?? this.companyError),
      companyLogoFile: clearCompanyLogoFile
          ? null
          : (companyLogoFile ?? this.companyLogoFile),
      industryLoading: industryLoading ?? this.industryLoading,
      industry: industry ?? this.industry,
      industryError:
          clearIndustryError ? null : (industryError ?? this.industryError),
      subIndustryLoading: subIndustryLoading ?? this.subIndustryLoading,
      subIndustry:
          clearSubIndustry ? null : (subIndustry ?? this.subIndustry),
      subIndustryError: clearSubIndustryError
          ? null
          : (subIndustryError ?? this.subIndustryError),
      detailsLoading: detailsLoading ?? this.detailsLoading,
      details: details ?? this.details,
      detailsError:
          clearDetailsError ? null : (detailsError ?? this.detailsError),
      isSavingStep: isSavingStep ?? this.isSavingStep,
    );
  }

  @override
  List<Object?> get props => [
        companyLoading,
        company,
        companyError,
        companyLogoFile,
        industryLoading,
        industry,
        industryError,
        subIndustryLoading,
        subIndustry,
        subIndustryError,
        detailsLoading,
        details,
        detailsError,
        isSavingStep,
      ];
}

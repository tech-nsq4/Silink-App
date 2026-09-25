import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/network_exceptions.dart';
import '../../../../core/utils/app_overlay.dart';
import '../../company_profile_completion/data/company_profile_completion_repo.dart';
import '../data/models/company_dashboard_info.dart';

part 'company_dashboard_state.dart';

class CompanyDashboardCubit extends Cubit<CompanyDashboardState> {
  CompanyDashboardCubit(this._repo) : super(const CompanyDashboardInitial());

  final CompanyProfileCompletionRepo _repo;

  Future<void> getDashboardInfo() async {
    emit(const CompanyDashboardLoading());
    try {
      final profileRequest = _repo.getCompanyProfile();
      final industryRequest = _repo.getIndustries();
      final detailsRequest = _repo.getDetails();
      final profile = await profileRequest;
      final industries = await industryRequest;
      final details = await detailsRequest;

      final industry = industries.industries
          .where(
              (option) => option.id == industries.selectedId || option.selected)
          .map((option) => option.name)
          .firstOrNull;
      final city = details.cities
          .where((option) => option.id == details.cityId || option.selected)
          .map((option) => option.name)
          .firstOrNull;

      emit(CompanyDashboardSuccess(
        CompanyDashboardInfo(
          companyName: profile.companyName,
          industry: industry ?? '',
          city: city ?? '',
          logoUrl: profile.logoUrl,
        ),
      ));
    } catch (e) {
      final msg = e is NetworkException ? e.message : e.toString();
      AppOverlay.showError(msg);
      emit(CompanyDashboardError(msg));
    }
  }
}

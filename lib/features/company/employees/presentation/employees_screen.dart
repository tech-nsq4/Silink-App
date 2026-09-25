import 'package:Silink/app/router/navigation_services.dart';
import 'package:Silink/app/router/routes.dart';
import 'package:Silink/core/di/injection.dart';
import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/app_images.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_button.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:Silink/core/widgets/app_text_field.dart';
import 'package:Silink/core/widgets/screen_header_bar.dart';
import 'package:Silink/core/widgets/screen_state_layout.dart';
import 'package:Silink/features/company/employees/data/models/company_employee_model.dart';
import 'package:Silink/features/company/employees/logic/company_team_cubit.dart';
import 'package:Silink/features/company/employees/presentation/employee_details_screen.dart';
import 'package:Silink/features/company/employees/presentation/widgets/employee_card.dart';
import 'package:Silink/features/company/employees/presentation/widgets/employees_empty_view.dart';
import 'package:Silink/features/company/employees/presentation/widgets/employees_filter_chips.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmployeesScreen extends StatefulWidget {
  const EmployeesScreen({super.key});

  @override
  State<EmployeesScreen> createState() => _EmployeesScreenState();
}

class _EmployeesScreenState extends State<EmployeesScreen> {
  static const _filters = [
    ('all', LocaleKeys.company_filter_all),
    ('active', LocaleKeys.company_filter_active_short),
    ('pending', LocaleKeys.company_filter_pending),
    ('suspended', LocaleKeys.company_filter_suspended),
  ];

  late final CompanyTeamCubit _cubit = getIt<CompanyTeamCubit>()..getTeam();
  String _filter = 'all';
  String _query = '';

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  Future<void> _openEmployee(CompanyEmployeeModel employee) async {
    final result = await NavigationService.push(
      Routes.companyEmployeeDetails,
      arguments: {'employee': employee},
    );
    if (!mounted || result is! EmployeeDetailsResult) return;

    if (result.removed) {
      _cubit.removeMember(result.employeeId!);
      return;
    }
    final updatedEmployee = result.employee;
    if (updatedEmployee != null) _cubit.upsertMember(updatedEmployee);
  }

  Future<void> _openInvite() async {
    final result = await NavigationService.push(Routes.companyInvite);
    if (mounted && result == true) _cubit.getTeam();
  }

  List<CompanyEmployeeModel> _visible(List<CompanyEmployeeModel> members) {
    final q = _query.trim().toLowerCase();
    return members.where((e) {
      final matchesFilter = switch (_filter) {
        'active' => e.status == CompanyEmployeeStatus.active,
        'pending' => e.status == CompanyEmployeeStatus.pending,
        'suspended' => e.status == CompanyEmployeeStatus.suspended,
        _ => true,
      };
      if (!matchesFilter) return false;
      if (q.isEmpty) return true;
      return e.name.toLowerCase().contains(q) ||
          e.position.toLowerCase().contains(q) ||
          e.email.toLowerCase().contains(q);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor.themeColor,
      body: Column(
        children: [
          ScreenHeaderBar(
            title: LocaleKeys.company_employees_title.tr(),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 0),
            child: CustomTextField(
              hint: LocaleKeys.company_search_employees_hint.tr(),
              onChanged: (value) => setState(() => _query = value),
              prefixIcon: Padding(
                padding: EdgeInsets.all(14.w),
                child: Icon(Icons.search_rounded, size: 18.h),
              ),
              borderColor: AppColors.borderColor.themeColor,
            ),
          ),
          EmployeesFilterChips(
            filters: _filters,
            selected: _filter,
            onSelected: (id) => setState(() => _filter = id),
          ),
          Expanded(
            child: BlocBuilder<CompanyTeamCubit, CompanyTeamState>(
              bloc: _cubit,
              builder: (context, state) {
                final members = state is CompanyTeamSuccess
                    ? state.members
                    : const <CompanyEmployeeModel>[];
                final visible = _visible(members);
                return CustomScreenStateLayout(
                  isLoading: state is CompanyTeamLoading ||
                      state is CompanyTeamInitial,
                  error: state is CompanyTeamError
                      ? ErrorModel(
                          code: ErrorEnum.response,
                          errorMessage: state.message,
                        )
                      : null,
                  onRetry: _cubit.getTeam,
                  isEmpty: visible.isEmpty,
                  noDataBuilder: (_) => EmployeesEmptyView(
                    title: members.isEmpty
                        ? LocaleKeys.company_no_employees.tr()
                        : LocaleKeys.company_no_results.tr(),
                    description: members.isEmpty
                        ? LocaleKeys.company_no_employees_desc.tr()
                        : LocaleKeys.company_no_results_desc.tr(),
                  ),
                  onRefresh: _cubit.getTeam,
                  builder: (_) => ListView.separated(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 16.h),
                    itemCount: visible.length,
                    separatorBuilder: (_, __) => 10.height,
                    itemBuilder: (context, index) => EmployeeCard(
                      employee: visible[index],
                      onTap: () => _openEmployee(visible[index]),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: 19.paddingHorizontal + 12.paddingVert,
        child: CustomButton(
          onTap: _openInvite,
          height: 48,
          radius: 14,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AppImages.iconsContacts,
                width: 19.w,
                height: 19.h,
              ),
              8.width,
              AppText(
                LocaleKeys.company_invite_title.tr(),
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

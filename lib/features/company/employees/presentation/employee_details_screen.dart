import 'package:Silink/app/router/navigation_services.dart';
import 'package:Silink/app/router/routes.dart';
import 'package:Silink/core/di/injection.dart';
import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/app_overlay.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:Silink/core/widgets/screen_header_bar.dart';
import 'package:Silink/features/company/employees/data/models/company_employee_model.dart';
import 'package:Silink/features/company/employees/logic/company_team_member_cubit.dart';
import 'package:Silink/features/company/employees/presentation/widgets/employee_action_tile.dart';
import 'package:Silink/features/company/employees/presentation/widgets/employee_info_card.dart';
import 'package:Silink/features/company/employees/presentation/widgets/employee_invitation_sheet.dart';
import 'package:Silink/features/company/employees/presentation/widgets/employee_profile_card.dart';
import 'package:Silink/features/company/employees/presentation/widgets/employee_remove_sheet.dart';
import 'package:Silink/features/company/employees/presentation/widgets/employee_resend_invite_tile.dart';
import 'package:Silink/features/company/employees/presentation/widgets/employee_switch_tile.dart';
import 'package:Silink/features/company/employees/presentation/widgets/employee_stats_row.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmployeeDetailsResult {
  const EmployeeDetailsResult.updated(this.employee)
      : removed = false,
        employeeId = null;

  const EmployeeDetailsResult.removed({required this.employeeId})
      : employee = null,
        removed = true;

  final CompanyEmployeeModel? employee;
  final String? employeeId;
  final bool removed;
}

class EmployeeDetailsScreen extends StatefulWidget {
  const EmployeeDetailsScreen({
    super.key,
    required this.employee,
  });

  final CompanyEmployeeModel employee;

  @override
  State<EmployeeDetailsScreen> createState() => _EmployeeDetailsScreenState();
}

class _EmployeeDetailsScreenState extends State<EmployeeDetailsScreen> {
  late final CompanyTeamMemberCubit _cubit = getIt<CompanyTeamMemberCubit>();
  late CompanyEmployeeModel _employee = widget.employee;
  bool _resending = false;
  bool _inviteSent = false;
  bool _canPop = false;
  EmployeeDetailsResult? _popResult;

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  void _popDetails(EmployeeDetailsResult result) {
    if (_canPop) {
      Navigator.of(context).pop(result);
      return;
    }
    setState(() {
      _popResult = result;
      _canPop = true;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) Navigator.of(context).pop(_popResult);
    });
  }

  void _closeDetails() => _popDetails(EmployeeDetailsResult.updated(_employee));

  Future<void> _openEmployeeAction(String route) async {
    final result = await NavigationService.push(
      route,
      arguments: {'employee': _employee},
    );
    if (result is CompanyEmployeeModel && mounted) {
      setState(() => _employee = result);
    }
  }

  Future<void> _removeEmployee() async {
    if (_cubit.state is CompanyTeamMemberLoading) return;
    final shouldRemove = await EmployeeRemoveSheet.show(context);
    if (!shouldRemove || !mounted) return;
    _cubit.deleteMember(_employee.id);
  }

  void _resendInvitation() {
    if (_cubit.state is CompanyTeamMemberLoading) return;
    final invitation = _employee.invitation;
    if (_inviteSent && invitation != null) {
      EmployeeInvitationSheet.show(context, invitation);
      return;
    }
    setState(() => _resending = true);
    _cubit.resendInvitation(_employee);
  }

  void _toggleActive(bool active) =>
      _cubit.setSuspended(_employee, suspended: !active);

  void _onMemberState(BuildContext context, CompanyTeamMemberState state) {
    if (state is CompanyTeamMemberStatusChanged) {
      setState(() => _employee = state.member);
      return;
    }
    if (state is CompanyTeamMemberError && _resending) {
      setState(() => _resending = false);
      return;
    }
    if (state is CompanyTeamMemberInvitationResent) {
      setState(() {
        _employee = state.member;
        _resending = false;
        _inviteSent = true;
      });
      AppOverlay.showSuccess(LocaleKeys.company_employee_invite_resent.tr());
      final invitation = state.member.invitation;
      if (invitation != null) EmployeeInvitationSheet.show(context, invitation);
      return;
    }
    if (state is! CompanyTeamMemberDeleted) return;
    AppOverlay.showSuccess(LocaleKeys.company_employee_removed.tr());
    _popDetails(EmployeeDetailsResult.removed(employeeId: state.id));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CompanyTeamMemberCubit, CompanyTeamMemberState>(
      bloc: _cubit,
      listener: _onMemberState,
      child: PopScope<Object?>(
        canPop: _canPop,
        onPopInvokedWithResult: (didPop, result) {
          if (!didPop) _closeDetails();
        },
        child: Scaffold(
          backgroundColor: AppColors.backgroundColor.themeColor,
          body: Column(
            children: [
              ScreenHeaderBar(
                title: LocaleKeys.company_employee_details_title.tr(),
                onBack: _closeDetails,
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 24.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      EmployeeProfileCard(employee: _employee),
                      12.height,
                      EmployeeInfoCard(employee: _employee),
                      12.height,
                      EmployeeStatsRow(
                        visitsLabel: LocaleKeys.company_visits.tr(),
                        leadsLabel: LocaleKeys.company_leads.tr(),
                        visits: _employee.visits,
                        leads: _employee.leads,
                      ),
                      18.height,
                      AppText(
                        LocaleKeys.company_employee_actions.tr(),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textSecondaryColor.themeColor,
                      ),
                      8.height,
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.white.themeColor,
                          borderRadius: BorderRadius.circular(18.r),
                          border: Border.all(
                            color: AppColors.studioPanelBorder.themeColor,
                          ),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Column(
                          children: [
                            EmployeeActionTile(
                              icon: Icons.edit_outlined,
                              title: LocaleKeys.company_employee_edit_data.tr(),
                              onTap: () => _openEmployeeAction(
                                Routes.companyEmployeeEdit,
                              ),
                            ),
                            BlocBuilder<CompanyTeamMemberCubit,
                                CompanyTeamMemberState>(
                              bloc: _cubit,
                              builder: (context, state) => EmployeeSwitchTile(
                                icon: Icons.remove_rounded,
                                title:
                                    LocaleKeys.company_employee_activate.tr(),
                                value: _employee.status ==
                                    CompanyEmployeeStatus.active,
                                enabled: state is! CompanyTeamMemberLoading,
                                onChanged: _toggleActive,
                              ),
                            ),
                            EmployeeActionTile(
                              icon: Icons.description_outlined,
                              title: LocaleKeys.company_employee_digital_title
                                  .tr(),
                              onTap: () => _openEmployeeAction(
                                Routes.companyEmployeeDigital,
                              ),
                            ),
                            EmployeeActionTile(
                              icon: Icons.contactless_outlined,
                              title: LocaleKeys.company_employee_link_nfc.tr(),
                              onTap: () => _openEmployeeAction(
                                Routes.companyEmployeeNfcLink,
                              ),
                            ),
                            if (_employee.canResendInvitation)
                              EmployeeResendInviteTile(
                                sending: _resending,
                                sent: _inviteSent,
                                onTap: _resendInvitation,
                              ),
                            EmployeeActionTile(
                              icon: Icons.delete_outline_rounded,
                              title: LocaleKeys.company_employee_remove.tr(),
                              onTap: _removeEmployee,
                              destructive: true,
                              showDivider: false,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

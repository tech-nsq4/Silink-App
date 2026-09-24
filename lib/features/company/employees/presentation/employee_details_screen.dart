import 'package:Silink/app/router/navigation_services.dart';
import 'package:Silink/app/router/routes.dart';
import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/app_images.dart';
import 'package:Silink/core/utils/app_overlay.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_button.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:Silink/core/widgets/screen_header_bar.dart';
import 'package:Silink/features/company/data/models/company_employee.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/employee_action_tile.dart';
import '../widgets/employee_info_card.dart';
import '../widgets/employee_profile_card.dart';
import '../widgets/employee_stats_row.dart';

class EmployeeDetailsResult {
  const EmployeeDetailsResult.updated(this.employee)
      : removed = false,
        employeeId = null;

  const EmployeeDetailsResult.removed({required this.employeeId})
      : employee = null,
        removed = true;

  final CompanyEmployeeItem? employee;
  final String? employeeId;
  final bool removed;
}

class EmployeeDetailsScreen extends StatefulWidget {
  const EmployeeDetailsScreen({
    super.key,
    required this.employee,
  });

  final CompanyEmployeeItem employee;

  @override
  State<EmployeeDetailsScreen> createState() => _EmployeeDetailsScreenState();
}

class _EmployeeDetailsScreenState extends State<EmployeeDetailsScreen> {
  late CompanyEmployeeItem _employee = widget.employee;
  bool _canPop = false;
  EmployeeDetailsResult? _popResult;

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
    if (result is CompanyEmployeeItem && mounted) {
      setState(() => _employee = result);
    }
  }

  void _resendInvite() {
    AppOverlay.showSuccess(LocaleKeys.company_employee_invite_resent.tr());
  }

  void _toggleStatus() {
    setState(() {
      _employee = _employee.copyWith(
        status: _employee.status == CompanyEmployeeStatus.suspended
            ? CompanyEmployeeStatus.active
            : CompanyEmployeeStatus.suspended,
      );
    });
    AppOverlay.showSuccess(LocaleKeys.company_employee_updated.tr());
  }

  void _cancelInvite() {
    setState(() {
      _employee = _employee.copyWith(
        status: CompanyEmployeeStatus.suspended,
      );
    });
    AppOverlay.showSuccess(LocaleKeys.company_employee_updated.tr());
  }

  Future<void> _removeEmployee() async {
    final shouldRemove = await showModalBottomSheet<bool>(
      context: context,
      backgroundColor: AppColors.cardColor.themeColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (sheetContext) => Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppText(
              LocaleKeys.company_employee_remove_confirm_title.tr(),
              fontSize: 17.sp,
              fontWeight: FontWeight.w800,
            ),
            8.height,
            AppText(
              LocaleKeys.company_employee_remove_confirm_desc.tr(),
              fontSize: 13.sp,
              color: AppColors.textSecondaryColor.themeColor,
              textAlign: TextAlign.center,
            ),
            20.height,
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    onTap: () => Navigator.of(sheetContext).pop(false),
                    title: LocaleKeys.common_cancel.tr(),
                    isOutlined: true,
                    color: Colors.transparent,
                    borderColor: AppColors.borderColor.themeColor,
                    textColor: AppColors.textPrimaryColor.themeColor,
                    height: 44,
                    radius: 12,
                  ),
                ),
                10.width,
                Expanded(
                  child: CustomButton(
                    onTap: () => Navigator.of(sheetContext).pop(true),
                    title: LocaleKeys.common_delete.tr(),
                    color: AppColors.errorColor.themeColor,
                    borderColor: AppColors.errorColor.themeColor,
                    height: 44,
                    radius: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

    if (shouldRemove != true || !mounted) return;
    AppOverlay.showSuccess(LocaleKeys.company_employee_removed.tr());
    _popDetails(
      EmployeeDetailsResult.removed(employeeId: _employee.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isSuspended = _employee.status == CompanyEmployeeStatus.suspended;
    return PopScope<Object?>(
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
                        color: AppColors.cardColor.themeColor,
                        borderRadius: BorderRadius.circular(18.r),
                        border: Border.all(
                          color: AppColors.borderColor.themeColor,
                        ),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        children: [
                          EmployeeActionTile(
                            iconAsset: AppImages.iconsEdit,
                            title: LocaleKeys.company_employee_edit_data.tr(),
                            onTap: () => _openEmployeeAction(
                              Routes.companyEmployeeEdit,
                            ),
                          ),
                          if (_employee.status ==
                              CompanyEmployeeStatus.pending) ...[
                            EmployeeActionTile(
                              iconAsset: AppImages.iconsSend,
                              title: LocaleKeys.company_employee_resend_invite
                                  .tr(),
                              onTap: _resendInvite,
                            ),
                            EmployeeActionTile(
                              iconAsset: AppImages.iconsChanging,
                              title: LocaleKeys.company_employee_cancel_invite
                                  .tr(),
                              onTap: _cancelInvite,
                            ),
                          ],
                          if (_employee.status !=
                              CompanyEmployeeStatus.pending) ...[
                            EmployeeActionTile(
                              iconAsset: AppImages.iconsWork,
                              title: isSuspended
                                  ? LocaleKeys.company_employee_activate.tr()
                                  : LocaleKeys.company_employee_deactivate.tr(),
                              onTap: _toggleStatus,
                            ),
                          ],
                          EmployeeActionTile(
                            iconAsset: AppImages.iconsDoc,
                            title:
                                LocaleKeys.company_employee_digital_title.tr(),
                            onTap: () => _openEmployeeAction(
                              Routes.companyEmployeeDigital,
                            ),
                          ),
                          EmployeeActionTile(
                            iconAsset: AppImages.iconsWifi,
                            title: LocaleKeys.company_employee_link_nfc.tr(),
                            onTap: () => _openEmployeeAction(
                              Routes.companyEmployeeNfcLink,
                            ),
                          ),
                          EmployeeActionTile(
                            iconAsset: AppImages.iconsDelete,
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
    );
  }
}

import 'package:Silink/app/router/navigation_services.dart';
import 'package:Silink/app/router/routes.dart';
import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/app_images.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_button.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:Silink/core/widgets/app_text_field.dart';
import 'package:Silink/core/widgets/screen_header_bar.dart';
import 'package:Silink/features/company/data/models/company_employee.dart';
import 'package:Silink/features/company/employees/presentation/employee_details_screen.dart';
import 'package:Silink/features/company/employees/widgets/employee_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
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

  static const List<CompanyEmployeeItem> _demoEmployees = [
    CompanyEmployeeItem(
      id: 'sara',
      fullName: 'سارة المطيري',
      email: 'sara@alruyaa.com',
      phone: '+966501112233',
      jobTitle: 'مديرة تسويق',
      department: 'التسويق',
      status: CompanyEmployeeStatus.active,
      hasProfile: true,
      hasNfc: true,
      visits: 42,
      leads: 8,
    ),
    CompanyEmployeeItem(
      id: 'khaled',
      fullName: 'خالد الشمري',
      email: 'khaled@alruyaa.com',
      phone: '',
      jobTitle: 'مطور تطبيقات',
      department: 'التقنية',
      status: CompanyEmployeeStatus.pending,
    ),
    CompanyEmployeeItem(
      id: 'noura',
      fullName: 'نورة القحطاني',
      email: 'noura@alruyaa.com',
      phone: '',
      jobTitle: 'مصممة UX',
      department: 'التصميم',
      status: CompanyEmployeeStatus.pending,
    ),
  ];

  final List<CompanyEmployeeItem> _employees = [..._demoEmployees];
  String _filter = 'all';
  String _query = '';

  Future<void> _openEmployee(CompanyEmployeeItem employee) async {
    final result = await NavigationService.push(
      Routes.companyEmployeeDetails,
      arguments: {'employee': employee},
    );
    if (!mounted || result is! EmployeeDetailsResult) return;

    setState(() {
      if (result.removed) {
        _employees.removeWhere(
          (current) => current.id == result.employeeId,
        );
        return;
      }

      final updatedEmployee = result.employee;
      if (updatedEmployee == null) return;
      final index = _employees.indexWhere(
        (current) => current.id == updatedEmployee.id,
      );
      if (index != -1) _employees[index] = updatedEmployee;
    });
  }

  Widget _buildTile(CompanyEmployeeItem employee) {
    return EmployeeCard(
      employee: employee,
      onTap: () => _openEmployee(employee),
    );
  }

  List<CompanyEmployeeItem> get _visible {
    return _employees.where((e) {
      final matchesFilter = switch (_filter) {
        'active' => e.status == CompanyEmployeeStatus.active,
        'pending' => e.status == CompanyEmployeeStatus.pending,
        'suspended' => e.status == CompanyEmployeeStatus.suspended,
        _ => true,
      };
      if (!matchesFilter) return false;
      final q = _query.trim().toLowerCase();
      if (q.isEmpty) return true;
      return e.fullName.toLowerCase().contains(q) ||
          e.department.toLowerCase().contains(q);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final visible = _visible;
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
          SizedBox(
            height: 54.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 8.h),
              itemCount: _filters.length,
              separatorBuilder: (_, __) => 8.width,
              itemBuilder: (context, index) {
                final (id, labelKey) = _filters[index];
                final selected = _filter == id;
                return InkWell(
                  onTap: () => setState(() => _filter = id),
                  borderRadius: BorderRadius.circular(20.r),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 7.h,
                    ),
                    decoration: BoxDecoration(
                      color: selected
                          ? AppColors.mint.themeColor
                          : AppColors.cardColor.themeColor,
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(
                        color: selected
                            ? Colors.transparent
                            : AppColors.borderColor.themeColor,
                      ),
                    ),
                    child: AppText(
                      labelKey.tr(),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      color: selected
                          ? Colors.white
                          : AppColors.textSecondaryColor.themeColor,
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: visible.isEmpty
                ? _buildEmpty()
                : ListView.separated(
                    padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 16.h),
                    itemCount: visible.length,
                    separatorBuilder: (_, __) => 10.height,
                    itemBuilder: (context, index) => _buildTile(visible[index]),
                  ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: 19.paddingHorizontal + 12.paddingVert,
        child: CustomButton(
          onTap: () => NavigationService.push(Routes.companyInvite),
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

  Widget _buildEmpty() {
    final noData = _employees.isEmpty;
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 64.w,
              height: 64.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.surfaceColor.themeColor,
                borderRadius: BorderRadius.circular(18.r),
              ),
              child: SvgPicture.asset(
                AppImages.iconsWork,
                width: 28.w,
                height: 28.h,
                colorFilter: ColorFilter.mode(
                  AppColors.textSecondaryColor.themeColor
                      .withValues(alpha: 0.4),
                  BlendMode.srcIn,
                ),
              ),
            ),
            16.height,
            AppText(
              noData
                  ? LocaleKeys.company_no_employees.tr()
                  : LocaleKeys.company_no_results.tr(),
              fontSize: 15.sp,
              fontWeight: FontWeight.w700,
            ),
            6.height,
            AppText(
              noData
                  ? LocaleKeys.company_no_employees_desc.tr()
                  : LocaleKeys.company_no_results_desc.tr(),
              fontSize: 13.sp,
              color: AppColors.textSecondaryColor.themeColor,
              textAlign: TextAlign.center,
            ),
            
          ],
        ),
      ),
    );
  }
}

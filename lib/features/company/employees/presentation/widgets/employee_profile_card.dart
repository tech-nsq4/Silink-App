import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:Silink/features/company/employees/data/models/company_employee_model.dart';
import 'package:Silink/features/company/employees/presentation/widgets/employee_avatar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmployeeProfileCard extends StatelessWidget {
  const EmployeeProfileCard({super.key, required this.employee});

  final CompanyEmployeeModel employee;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.cardColor.themeColor,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: AppColors.borderColor.themeColor),
      ),
      child: Row(
        children: [
          EmployeeAvatar(
            employee: employee,
            size: 48,
            radius: 14,
            gradient: const LinearGradient(
              colors: [Color(0xFF22B8CF), Color(0xFF2563EB)],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
          10.width,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  employee.name,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w800,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                3.height,
                AppText(
                  employee.position,
                  fontSize: 11.sp,
                  color: AppColors.textSecondaryColor.themeColor,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                5.height,
                EmployeeStatusPill(status: employee.status),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class EmployeeStatusPill extends StatelessWidget {
  const EmployeeStatusPill({super.key, required this.status});

  final CompanyEmployeeStatus status;

  Color get _color => switch (status) {
        CompanyEmployeeStatus.active => AppColors.successColor.themeColor,
        CompanyEmployeeStatus.pending => const Color(0xFFEA580C),
        CompanyEmployeeStatus.suspended =>
          AppColors.textSecondaryColor.themeColor,
      };

  @override
  Widget build(BuildContext context) {
    final label = switch (status) {
      CompanyEmployeeStatus.active =>
        LocaleKeys.company_filter_active_short.tr(),
      CompanyEmployeeStatus.pending => LocaleKeys.company_filter_pending.tr(),
      CompanyEmployeeStatus.suspended =>
        LocaleKeys.company_filter_suspended.tr(),
    };
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: _color.withValues(alpha: 0.09),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: AppText(
        label,
        fontSize: 9.sp,
        fontWeight: FontWeight.w700,
        color: _color,
      ),
    );
  }
}

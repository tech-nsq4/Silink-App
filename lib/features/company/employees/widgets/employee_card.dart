import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:Silink/features/company/data/models/company_employee.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmployeeCard extends StatelessWidget {
  const EmployeeCard({
    super.key,
    required this.employee,
    required this.onTap,
  });

  final CompanyEmployeeItem employee;
  final VoidCallback onTap;

  String _statusLabel(CompanyEmployeeStatus status) => switch (status) {
        CompanyEmployeeStatus.active =>
          LocaleKeys.company_filter_active_short.tr(),
        CompanyEmployeeStatus.pending => LocaleKeys.company_filter_pending.tr(),
        CompanyEmployeeStatus.suspended =>
          LocaleKeys.company_filter_suspended.tr(),
      };

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.cardColor.themeColor,
      borderRadius: BorderRadius.circular(16.r),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(13.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: AppColors.borderColor.themeColor),
          ),
          child: Row(
            children: [
              Container(
                width: 44.w,
                height: 44.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  gradient: LinearGradient(
                    colors: [Color(0xff2C9092), Color(0xff2368E2)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                alignment: Alignment.center,
                child: AppText(
                  employee.initials,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.white.themeColor,
                ),
              ),
              12.width,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      employee.fullName,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    2.height,
                    AppText(
                      employee.department.trim().isEmpty
                          ? employee.jobTitle
                          : '${employee.jobTitle} · ${employee.department}',
                      fontSize: 12.sp,
                      color: AppColors.textSecondaryColor.themeColor,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    6.height,
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 2.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.fieldFill,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: AppText(
                            _statusLabel(employee.status),
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textSecondaryColor.themeColor,
                          ),
                        ),
                        8.width,
                        Flexible(
                          child: AppText(
                            [
                              if (employee.hasProfile)
                                LocaleKeys.company_linked_profile.tr()
                              else
                                LocaleKeys.company_no_profile.tr(),
                              if (employee.hasNfc) 'NFC',
                            ].join(' · '),
                            fontSize: 11.sp,
                            color: AppColors.textSecondaryColor.themeColor,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios_rounded,
                  size: 12.h, color: AppColors.textSecondaryColor.themeColor),
            ],
          ),
        ),
      ),
    );
  }
}

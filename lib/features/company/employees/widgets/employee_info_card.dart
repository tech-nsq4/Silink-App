import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:Silink/features/company/data/models/company_employee.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmployeeInfoCard extends StatelessWidget {
  const EmployeeInfoCard({super.key, required this.employee});

  final CompanyEmployeeItem employee;

  @override
  Widget build(BuildContext context) {
    final phone = employee.phone.trim();
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.cardColor.themeColor,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: AppColors.borderColor.themeColor),
      ),
      child: Column(
        children: [
          _InfoRow(
            label: LocaleKeys.company_email.tr(),
            value: employee.email.trim(),
          ),
          Divider(color: AppColors.dividerColor.themeColor, height: 20.h),
          _InfoRow(
            label: LocaleKeys.company_phone_number.tr(),
            value: phone.isEmpty
                ? LocaleKeys.company_employee_not_linked.tr()
                : phone,
          ),
          Divider(color: AppColors.dividerColor.themeColor, height: 20.h),
          _InfoRow(
            label: LocaleKeys.store_job_title.tr(),
            value: employee.jobTitle.trim(),
          ),
          Divider(color: AppColors.dividerColor.themeColor, height: 20.h),
          _InfoRow(
            label: LocaleKeys.company_employee_nfc_card.tr(),
            value: employee.hasNfc
                ? LocaleKeys.myCards_nfcEnabled.tr()
                : LocaleKeys.myCards_nfcDisabled.tr(),
            valueColor: employee.hasNfc
                ? AppColors.successColor.themeColor
                : AppColors.textPrimaryColor.themeColor,
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.label,
    required this.value,
    this.valueColor,
  });

  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText(
          label,
          fontSize: 11.sp,
          color: AppColors.textSecondaryColor.themeColor,
        ),
        Spacer(),
        Expanded(
          child: AppText(
            value,
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: valueColor,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/extensions/extensions.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/locale_keys.dart';
import '../../../core/widgets/app_text.dart';
import 'company_field.dart';
import 'company_validators.dart';

class CompanyStepFour extends StatelessWidget {
  const CompanyStepFour({
    super.key,
    required this.employeesRange,
    required this.onEmployeesRangeChanged,
    required this.phoneCtrl,
    required this.emailCtrl,
  });

  final String? employeesRange;
  final ValueChanged<String> onEmployeesRangeChanged;
  final TextEditingController phoneCtrl;
  final TextEditingController emailCtrl;

  static const _ranges = ['1-5', '5-11', '11-50', '50+'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CompanySectionCard(
          title: LocaleKeys.company_employees_count.tr(),
          child: Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: _ranges.map((range) {
              final selected = employeesRange == range;
              return ChoiceChip(
                label: AppText(range, fontSize: 13.sp),
                selected: selected,
                onSelected: (_) => onEmployeesRangeChanged(range),
                selectedColor: AppColors.mintSoft.themeColor,
                side: BorderSide(
                  color: selected ? AppColors.mint.themeColor : AppColors.borderColor.themeColor,
                ),
              );
            }).toList(),
          ),
        ),
        12.height,
        CompanyField(
          label: LocaleKeys.company_phone.tr(),
          hint: LocaleKeys.company_phone_hint.tr(),
          controller: phoneCtrl,
          keyboardType: TextInputType.phone,
          validator: (value) => CompanyValidators.requiredValidator(value)?.tr(),
        ),
        12.height,
        CompanyField(
          label: LocaleKeys.company_contact_email.tr(),
          hint: LocaleKeys.company_email_hint.tr(),
          controller: emailCtrl,
          keyboardType: TextInputType.emailAddress,
          validator: (value) => CompanyValidators.emailValidator(value)?.tr(),
        ),
      ],
    );
  }
}
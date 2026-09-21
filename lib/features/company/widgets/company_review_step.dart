import 'package:Silink/features/company/widgets/company_field.dart';
import 'package:Silink/features/company/widgets/company_step_header.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/locale_keys.dart';

class CompanyReviewStep extends StatelessWidget {
  const CompanyReviewStep({
    super.key,
    required this.name,
    required this.registrationNumber,
    required this.taxNumber,
    required this.businessTypeKey,
    required this.activityNature,
    required this.city,
    required this.district,
    required this.employeesRange,
    required this.email,
  });

  final String name;
  final String registrationNumber;
  final String taxNumber;
  final String businessTypeKey;
  final String? activityNature;
  final String city;
  final String district;
  final String? employeesRange;
  final String email;

  @override
  Widget build(BuildContext context) {
    return CompanySectionCard(
      title: LocaleKeys.company_review_title.tr(),
      child: Column(
        children: [
          CompanyInfoRow(label: LocaleKeys.company_name.tr(), value: name),
          CompanyInfoRow(
              label: LocaleKeys.company_registration.tr(),
              value: registrationNumber),
          if (taxNumber.isNotEmpty)
            CompanyInfoRow(
                label: LocaleKeys.company_tax.tr(), value: taxNumber),
          CompanyInfoRow(
              label: LocaleKeys.company_type.tr(), value: businessTypeKey.tr()),
          if (activityNature != null)
            CompanyInfoRow(
                label: LocaleKeys.company_activity_nature.tr(),
                value: activityNature!.tr()),
          CompanyInfoRow(
              label: LocaleKeys.company_city.tr(),
              value: '$city $district'.trim()),
          CompanyInfoRow(
              label: LocaleKeys.company_employees_count.tr(),
              value: employeesRange ?? ''),
          CompanyInfoRow(label: LocaleKeys.company_email.tr(), value: email),
        ],
      ),
    );
  }
}

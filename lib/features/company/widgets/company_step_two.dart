import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../data/models/company_business_type.dart';
import 'company_business_type_card.dart';

class CompanyStepTwo extends StatelessWidget {
  const CompanyStepTwo({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  final CompanyBusinessType? selected;
  final ValueChanged<CompanyBusinessType> onSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: CompanyBusinessType.values.map((type) {
        return Padding(
          padding: EdgeInsets.only(bottom: 10.h),
          child: CompanyBusinessTypeCard(
            title: type.key.tr(),
            selected: selected == type,
            onTap: () => onSelected(type),
          ),
        );
      }).toList(),
    );
  }
}

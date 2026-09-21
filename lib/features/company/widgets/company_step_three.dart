import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/extensions/extensions.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/locale_keys.dart';
import '../../../core/widgets/app_text.dart';
import 'company_field.dart';

class CompanyStepThree extends StatelessWidget {
  const CompanyStepThree({
    super.key,
    required this.activityNature,
    required this.onActivityNatureChanged,
    required this.hasOnlineStore,
    required this.onOnlineStoreChanged,
    required this.cityCtrl,
    required this.districtCtrl,
    required this.websiteCtrl,
  });

  final String? activityNature;
  final ValueChanged<String> onActivityNatureChanged;
  final bool hasOnlineStore;
  final ValueChanged<bool> onOnlineStoreChanged;
  final TextEditingController cityCtrl;
  final TextEditingController districtCtrl;
  final TextEditingController websiteCtrl;

  static const _natures = [
    'company.nature_food',
    'company.nature_retail',
    'company.nature_services',
    'company.nature_other',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CompanySectionCard(
          title: LocaleKeys.company_activity_nature.tr(),
          child: Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: _natures.map((key) {
              final selected = activityNature == key;
              return ChoiceChip(
                label: AppText(key.tr(), fontSize: 12.5.sp),
                selected: selected,
                onSelected: (_) => onActivityNatureChanged(key),
                selectedColor: AppColors.mintSoft.themeColor,
                side: BorderSide(
                  color: selected ? AppColors.mint.themeColor : AppColors.borderColor.themeColor,
                ),
              );
            }).toList(),
          ),
        ),
        12.height,
        CompanySectionCard(
          title: LocaleKeys.company_online_store.tr(),
          trailing: Switch(
            value: hasOnlineStore,
            onChanged: onOnlineStoreChanged,
          ),
          child: AppText(
            LocaleKeys.company_online_store_hint.tr(),
            fontSize: 12.sp,
            color: AppColors.textSecondaryColor.themeColor,
          ),
        ),
        12.height,
        CompanyField(
          label: LocaleKeys.company_city.tr(),
          hint: LocaleKeys.company_city_hint.tr(),
          controller: cityCtrl,
        ),
        12.height,
        CompanyField(
          label: LocaleKeys.company_district.tr(),
          hint: LocaleKeys.company_district_hint.tr(),
          controller: districtCtrl,
        ),
        12.height,
        CompanyField(
          label: LocaleKeys.company_website.tr(),
          hint: LocaleKeys.company_website_hint.tr(),
          controller: websiteCtrl,
          keyboardType: TextInputType.url,
        ),
      ],
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:Silink/core/widgets/field_label.dart';
import 'package:Silink/features/company/company_profile_completion/data/models/company_details_model.dart';
import 'package:Silink/features/company/shared/widgets/company_field.dart';
import 'company_picker_field.dart';
import 'company_validators.dart';

class CompanyStepFour extends StatelessWidget {
  const CompanyStepFour({
    super.key,
    required this.sizes,
    required this.selectedSize,
    required this.onSizeSelected,
    required this.cities,
    required this.selectedCityId,
    required this.onCitySelected,
    required this.phoneCtrl,
    required this.emailCtrl,
  });

  final List<CompanySizeOption> sizes;
  final String? selectedSize;
  final ValueChanged<String> onSizeSelected;
  final List<CompanyCityOption> cities;
  final String? selectedCityId;
  final ValueChanged<String> onCitySelected;
  final TextEditingController phoneCtrl;
  final TextEditingController emailCtrl;

  Widget _sizeChip(CompanySizeOption option) {
    final selected = selectedSize == option.type;
    return Expanded(
      child: InkWell(
        onTap: () => onSizeSelected(option.type),
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            color: selected
                ? AppColors.mintSoft.themeColor
                : AppColors.cardColor.themeColor,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: selected
                  ? AppColors.mint.themeColor
                  : AppColors.borderColor.themeColor,
              width: selected ? 1.5 : 1,
            ),
          ),
          child: AppText(
            option.label,
            fontSize: 13.sp,
            fontWeight: FontWeight.w700,
            color: selected
                ? AppColors.mint.themeColor
                : AppColors.textPrimaryColor.themeColor,
          ),
        ),
      ),
    );
  }

  String get _selectedCityName {
    for (final city in cities) {
      if (city.id == selectedCityId) return city.name;
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FieldLabel(text: LocaleKeys.company_size.tr(), required: true),
        10.height,
        for (int i = 0; i < sizes.length; i += 2) ...[
          Row(
            children: [
              _sizeChip(sizes[i]),
              if (i + 1 < sizes.length) ...[8.width, _sizeChip(sizes[i + 1])],
            ],
          ),
          if (i + 2 < sizes.length) 8.height,
        ],
        16.height,
        CompanyPickerField(
          label: LocaleKeys.company_city.tr(),
          hint: LocaleKeys.company_city_hint.tr(),
          value: _selectedCityName,
          required: true,
          onTap: () async {
            final id = await showCompanyCityPicker(
              context,
              sheetTitle: LocaleKeys.company_city.tr(),
              cities: cities,
              selectedId: selectedCityId,
            );
            if (id != null) onCitySelected(id);
          },
        ),
        12.height,
        CompanyField(
          label: LocaleKeys.company_phone.tr(),
          hint: LocaleKeys.company_phone_hint.tr(),
          controller: phoneCtrl,
          keyboardType: TextInputType.phone,
          required: true,
          validator: (value) =>
              CompanyValidators.requiredValidator(value)?.tr(),
        ),
        12.height,
        CompanyField(
          label: LocaleKeys.company_contact_email.tr(),
          hint: LocaleKeys.company_email_hint.tr(),
          controller: emailCtrl,
          keyboardType: TextInputType.emailAddress,
          required: true,
          validator: (value) => CompanyValidators.emailValidator(value)?.tr(),
        ),
      ],
    );
  }
}

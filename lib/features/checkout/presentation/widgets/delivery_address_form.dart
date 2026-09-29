import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/custom_text_field_phone/custom_text_field_phone_code.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_text.dart';
import '../../data/models/city_model.dart';
import 'checkout_section_card.dart';
import 'city_dropdown_field.dart';
import 'labeled_text_field.dart';

class DeliveryAddressForm extends StatelessWidget {
  const DeliveryAddressForm({
    super.key,
    required this.nameController,
    required this.phoneController,
    required this.cities,
    required this.selectedCity,
    required this.onCityChanged,
    required this.onRetryCities,
    required this.citiesLoading,
    required this.citiesError,
    required this.streetController,
    required this.notesController,
    required this.requiredValidator,
    required this.onPhoneChanged,
    required this.districtController,
  });

  final TextEditingController nameController;
  final TextEditingController phoneController;
  final List<CityModel> cities;
  final CityModel? selectedCity;
  final ValueChanged<CityModel?> onCityChanged;
  final VoidCallback onRetryCities;
  final bool citiesLoading;
  final bool citiesError;
  final TextEditingController streetController;
  final TextEditingController notesController;
  final String? Function(String?) requiredValidator;
  final ValueChanged<PhoneNumber> onPhoneChanged;
  final TextEditingController districtController;

  @override
  Widget build(BuildContext context) {
    return CheckoutSectionCard(
      title: LocaleKeys.store_shipping_address.tr(),
      icon: Icons.local_shipping_outlined,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          LabeledTextField(
            label: LocaleKeys.store_full_name.tr(),
            controller: nameController,
            validator: requiredValidator,
          ),
          14.height,
          AppText(
            LocaleKeys.store_phone_number.tr(),
            fontSize: 12.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.darkSlate.themeColor,
          ),
          8.height,
          CustomTextFieldPhoneCode(
            controller: phoneController,
            hint: LocaleKeys.store_phone_number.tr(),
            initialCountryCode: 'SA',
            fillColor: AppColors.fieldFill,
            borderColor:
                AppColors.borderColor.themeColor.withValues(alpha: 0.08),
            onChanged: onPhoneChanged,
          ),
          14.height,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: CityDropdownField(
                  cities: cities,
                  selected: selectedCity,
                  onChanged: onCityChanged,
                  onRetry: onRetryCities,
                  isLoading: citiesLoading,
                  hasError: citiesError,
                ),
              ),
              12.width,
              Expanded(
                child: LabeledTextField(
                  label: LocaleKeys.store_district.tr(),
                  controller: districtController,
                  validator: requiredValidator,
                ),
              ),
            ],
          ),
          14.height,
          LabeledTextField(
            label: LocaleKeys.store_street_details.tr(),
            controller: streetController,
            validator: requiredValidator,
          ),
          14.height,
          LabeledTextField(
            label: LocaleKeys.store_notes_optional.tr(),
            controller: notesController,
            maxLines: 3,
          ),
        ],
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/custom_loading_widget.dart';
import '../../data/models/city_model.dart';

class CityDropdownField extends StatelessWidget {
  const CityDropdownField({
    super.key,
    required this.cities,
    required this.selected,
    required this.onChanged,
    required this.onRetry,
    this.isLoading = false,
    this.hasError = false,
  });

  final List<CityModel> cities;
  final CityModel? selected;
  final ValueChanged<CityModel?> onChanged;
  final VoidCallback onRetry;
  final bool isLoading;
  final bool hasError;

  OutlineInputBorder _border(Color color) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(color: color),
      );

  @override
  Widget build(BuildContext context) {
    final borderColor =
        AppColors.borderColor.themeColor.withValues(alpha: 0.08);
    final hintStyle = TextStyle(
      fontFamily: AppFonts.familyFont,
      fontSize: 13.sp,
      color: AppColors.hintColor.themeColor,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          LocaleKeys.store_city.tr(),
          fontSize: 12.sp,
          fontWeight: FontWeight.w700,
          color: AppColors.darkSlate.themeColor,
        ),
        8.height,
        DropdownButtonFormField<CityModel>(
          initialValue: cities.contains(selected) ? selected : null,
          isExpanded: true,
          menuMaxHeight: 320.h,
          borderRadius: BorderRadius.circular(16.r),
          dropdownColor: AppColors.cardColor.themeColor,
          icon: isLoading
              ? SizedBox(
                  width: 18.w,
                  height: 18.w,
                  child: CustomLoadingWidget(
                    size: 18.w,
                    color: AppColors.successColor.themeColor,
                  ),
                )
              : Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: AppColors.textSecondaryColor.themeColor,
                ),
          hint: GestureDetector(
            onTap: hasError ? onRetry : null,
            behavior: HitTestBehavior.opaque,
            child: Text(
              hasError
                  ? LocaleKeys.store_cities_load_failed.tr()
                  : LocaleKeys.store_select_city.tr(),
              style: hasError
                  ? hintStyle.copyWith(color: AppColors.errorColor.themeColor)
                  : hintStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          validator: (value) =>
              value == null ? LocaleKeys.store_error_required.tr() : null,
          onChanged: isLoading || cities.isEmpty ? null : onChanged,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.fieldFill,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            border: _border(borderColor),
            enabledBorder: _border(borderColor),
            disabledBorder: _border(borderColor),
            focusedBorder: _border(AppColors.successColor.themeColor),
            errorBorder: _border(AppColors.errorColor.themeColor),
            focusedErrorBorder: _border(AppColors.errorColor.themeColor),
          ),
          items: [
            for (final city in cities)
              DropdownMenuItem<CityModel>(
                value: city,
                child: AppText(
                  city.name,
                  fontSize: 13.5.sp,
                  fontWeight: FontWeight.w600,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
          ],
        ),
      ],
    );
  }
}

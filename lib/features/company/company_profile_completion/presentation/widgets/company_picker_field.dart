import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:Silink/core/widgets/field_label.dart';
import 'package:Silink/features/company/company_profile_completion/data/models/company_details_model.dart';
import 'company_choice_row.dart';

class CompanyPickerField extends StatelessWidget {
  const CompanyPickerField({
    super.key,
    required this.label,
    required this.hint,
    required this.value,
    required this.onTap,
    this.required = false,
  });

  final String label;
  final String hint;
  final String value;
  final VoidCallback onTap;
  final bool required;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FieldLabel(text: label, required: required),
        8.height,
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12.r),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
            decoration: BoxDecoration(
              color: AppColors.cardColor.themeColor,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColors.borderColor.themeColor),
            ),
            child: Row(
              children: [
                Expanded(
                  child: AppText(
                    value.isEmpty ? hint : value,
                    fontSize: 13.sp,
                    fontWeight:
                        value.isEmpty ? FontWeight.w400 : FontWeight.w600,
                    color: value.isEmpty
                        ? AppColors.hintColor.themeColor
                        : AppColors.textPrimaryColor.themeColor,
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: AppColors.textSecondaryColor.themeColor,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

Future<String?> showCompanyCityPicker(
  BuildContext context, {
  required String sheetTitle,
  required List<CompanyCityOption> cities,
  required String? selectedId,
}) {
  return showModalBottomSheet<String>(
    context: context,
    backgroundColor: AppColors.cardColor.themeColor,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
    ),
    builder: (sheetContext) => SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(sheetTitle, fontSize: 15.sp, fontWeight: FontWeight.w700),
            12.height,
            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 420.h),
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: cities.length,
                separatorBuilder: (_, __) => 8.height,
                itemBuilder: (context, index) {
                  final city = cities[index];
                  return CompanyChoiceRow(
                    title: city.name,
                    selected: city.id == selectedId,
                    onTap: () => Navigator.of(sheetContext).pop(city.id),
                  );
                },
              ),
            ),
            8.height,
          ],
        ),
      ),
    ),
  );
}

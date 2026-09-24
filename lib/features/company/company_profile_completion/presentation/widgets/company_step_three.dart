import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:Silink/core/widgets/custom_loading_widget.dart';
import 'package:Silink/features/company/company_profile_completion/data/models/company_option_model.dart';

import 'company_option_card.dart';

class CompanyStepThree extends StatelessWidget {
  const CompanyStepThree({
    super.key,
    required this.loading,
    required this.options,
    required this.selectedId,
    required this.onSelected,
  });

  final bool loading;
  final List<CompanyOptionModel> options;
  final String? selectedId;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 40.h),
        child: CustomLoadingWidget(color: AppColors.mint.themeColor),
      );
    }
    if (options.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 40.h),
        child: Center(
          child: AppText(
            LocaleKeys.company_sub_industry_empty.tr(),
            fontSize: 13.sp,
            color: AppColors.textSecondaryColor.themeColor,
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
    return Column(
      children: [
        for (final option in options) ...[
          CompanyOptionCard(
            title: option.name,
            subtitle: option.description,
            selected: selectedId == option.id,
            onTap: () => onSelected(option.id),
          ),
          10.height,
        ],
      ],
    );
  }
}

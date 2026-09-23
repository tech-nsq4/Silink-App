import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/widgets/custom_loading_widget.dart';
import 'package:Silink/features/company/company_profile_completion/data/models/company_option_model.dart';

import 'company_option_card.dart';

class CompanyStepTwo extends StatelessWidget {
  const CompanyStepTwo({
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

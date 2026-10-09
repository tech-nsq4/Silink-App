import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/custom_text_field_phone/custom_text_field_phone_code.dart';
import '../../../../../../core/utils/locale_keys.dart';
import '../../../../../../core/widgets/flow_page_title.dart';
import '../../../data/models/company_details_model.dart';
import 'workspace_field.dart';
import 'workspace_field_label.dart';
import 'workspace_next_hint.dart';
import 'workspace_pair_grid.dart';
import 'workspace_section_title.dart';
import 'workspace_select_field.dart';
import 'workspace_size_card.dart';

class WorkspaceTeamStep extends StatelessWidget {
  const WorkspaceTeamStep({
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

  @override
  Widget build(BuildContext context) {
    final cityById = {for (final c in cities) c.id: c};
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FlowPageTitle(
          eyebrow: LocaleKeys.companyWorkspace_teamEyebrow.tr(),
          title: LocaleKeys.companyWorkspace_teamTitle.tr(),
          subtitle: LocaleKeys.companyWorkspace_teamSubtitle.tr(),
        ),
        WorkspaceSectionTitle(
          title: LocaleKeys.companyWorkspace_sizeTitle.tr(),
          subtitle: LocaleKeys.companyWorkspace_sizeSubtitle.tr(),
        ),
        WorkspacePairGrid(
          children: [
            for (final size in sizes)
              WorkspaceSizeCard(
                label: size.type,
                caption: LocaleKeys.companyWorkspace_sizeCaption.tr(),
                selected: size.type == selectedSize,
                onTap: () => onSizeSelected(size.type),
              ),
          ],
        ),
        SizedBox(height: 14.h),
        WorkspaceSelectField<String>(
          label: LocaleKeys.companyWorkspace_cityLabel.tr(),
          hint: LocaleKeys.companyWorkspace_cityHint.tr(),
          required: true,
          value: selectedCityId,
          options: [for (final c in cities) c.id],
          labelOf: (id) => cityById[id]?.name ?? '',
          onChanged: onCitySelected,
        ),
        WorkspaceFieldLabel(
          text: LocaleKeys.companyWorkspace_phoneLabel.tr(),
          required: true,
        ),
        CustomTextFieldPhoneCode(
          controller: phoneCtrl,
          hint: LocaleKeys.companyWorkspace_phoneHint.tr(),
          initialCountryCode: 'SA',
          isRequired: false,
          borderRadius: 14.r,
          fillColor: AppColors.white.themeColor,
          borderColor: AppColors.studioPanelBorder.themeColor,
          focusedBorderColor: AppColors.accentTeal.themeColor,
        ),
        SizedBox(height: 18.h),
        WorkspaceField(
          label: LocaleKeys.companyWorkspace_emailLabel.tr(),
          hint: 'team@company.com',
          controller: emailCtrl,
          required: true,
          keyboardType: TextInputType.emailAddress,
        ),
        WorkspaceNextHint(
          title: LocaleKeys.companyWorkspace_nextHintTitle.tr(),
          body: LocaleKeys.companyWorkspace_nextHintBody.tr(),
        ),
      ],
    );
  }
}

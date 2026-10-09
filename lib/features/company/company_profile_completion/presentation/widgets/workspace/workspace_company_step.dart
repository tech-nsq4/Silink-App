import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/locale_keys.dart';
import '../../../../../../core/widgets/app_text.dart';
import '../../../../../../core/widgets/custom_loading_widget.dart';
import '../../../../../../core/widgets/flow_page_title.dart';
import '../../../data/models/company_option_model.dart';
import 'workspace_choice_card.dart';
import 'workspace_field.dart';
import 'workspace_logo_card.dart';
import 'workspace_pair_grid.dart';
import 'workspace_section_title.dart';
import 'workspace_select_field.dart';

class WorkspaceCompanyStep extends StatelessWidget {
  const WorkspaceCompanyStep({
    super.key,
    required this.nameCtrl,
    required this.aboutCtrl,
    required this.websiteCtrl,
    required this.onNameChanged,
    required this.onPickLogo,
    required this.industries,
    required this.industryId,
    required this.onIndustrySelected,
    required this.subIndustries,
    required this.subIndustryId,
    required this.subIndustriesLoading,
    required this.onSubIndustrySelected,
    this.logoUrl,
    this.logoFile,
  });

  final TextEditingController nameCtrl;
  final TextEditingController aboutCtrl;
  final TextEditingController websiteCtrl;
  final VoidCallback onNameChanged;
  final VoidCallback onPickLogo;
  final String? logoUrl;
  final File? logoFile;
  final List<CompanyOptionModel> industries;
  final String? industryId;
  final ValueChanged<String> onIndustrySelected;
  final List<CompanyOptionModel> subIndustries;
  final String? subIndustryId;
  final bool subIndustriesLoading;
  final ValueChanged<String> onSubIndustrySelected;

  Widget _experience() {
    if (subIndustriesLoading) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        child: Center(
          child: CustomLoadingWidget(
            color: AppColors.accentTeal.themeColor,
            size: 26,
          ),
        ),
      );
    }
    if (subIndustries.isEmpty) {
      return AppText(
        LocaleKeys.companyWorkspace_experienceEmpty.tr(),
        fontSize: 10.sp,
        color: AppColors.textSecondaryColor.themeColor,
      );
    }
    return WorkspacePairGrid(
      children: [
        for (final option in subIndustries)
          WorkspaceChoiceCard(
            title: option.name,
            subtitle: option.description,
            selected: option.id == subIndustryId,
            onTap: () => onSubIndustrySelected(option.id),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final name = nameCtrl.text.trim();
    final industryById = {for (final i in industries) i.id: i};
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FlowPageTitle(
          eyebrow: LocaleKeys.companyWorkspace_companyEyebrow.tr(),
          title: LocaleKeys.companyWorkspace_companyTitle.tr(),
          subtitle: LocaleKeys.companyWorkspace_companySubtitle.tr(),
        ),
        WorkspaceLogoCard(
          title:
              name.isEmpty ? LocaleKeys.companyWorkspace_logoTitle.tr() : name,
          hint: logoFile == null && (logoUrl?.trim().isEmpty ?? true)
              ? LocaleKeys.companyWorkspace_logoPick.tr()
              : LocaleKeys.companyWorkspace_logoHint.tr(),
          logoUrl: logoUrl,
          logoFile: logoFile,
          onTap: onPickLogo,
        ),
        WorkspaceField(
          label: LocaleKeys.companyWorkspace_nameLabel.tr(),
          hint: LocaleKeys.companyWorkspace_nameHint.tr(),
          controller: nameCtrl,
          required: true,
          onChanged: (_) => onNameChanged(),
        ),
        WorkspaceField(
          label: LocaleKeys.companyWorkspace_aboutLabel.tr(),
          hint: LocaleKeys.companyWorkspace_aboutHint.tr(),
          controller: aboutCtrl,
          required: true,
          maxLines: 4,
        ),
        WorkspaceField(
          label: LocaleKeys.companyWorkspace_websiteLabel.tr(),
          hint: 'company.com',
          controller: websiteCtrl,
          keyboardType: TextInputType.url,
        ),
        WorkspaceSelectField<String>(
          label: LocaleKeys.companyWorkspace_industryLabel.tr(),
          hint: LocaleKeys.companyWorkspace_industryHint.tr(),
          required: true,
          value: industryId,
          options: [for (final i in industries) i.id],
          labelOf: (id) => industryById[id]?.name ?? '',
          onChanged: onIndustrySelected,
        ),
        WorkspaceSectionTitle(
          title: LocaleKeys.companyWorkspace_experienceTitle.tr(),
          subtitle: LocaleKeys.companyWorkspace_experienceSubtitle.tr(),
        ),
        _experience(),
      ],
    );
  }
}

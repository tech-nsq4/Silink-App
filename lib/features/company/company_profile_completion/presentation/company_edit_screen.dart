import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_overlay.dart';
import '../../../../core/utils/custom_text_field_phone/custom_text_field_phone_code.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/flow_top_bar.dart';
import '../../../../core/widgets/gradient_action_button.dart';
import '../../../../core/widgets/photo_source_sheet.dart';
import '../../../../core/widgets/screen_state_layout.dart';
import '../logic/company_profile_completion_cubit.dart';
import 'widgets/workspace/workspace_choice_card.dart';
import 'widgets/workspace/workspace_field.dart';
import 'widgets/workspace/workspace_field_label.dart';
import 'widgets/workspace/workspace_logo_row.dart';
import 'widgets/workspace/workspace_pair_grid.dart';
import 'widgets/workspace/workspace_section_title.dart';
import 'widgets/workspace/workspace_select_field.dart';
import 'widgets/workspace/workspace_size_card.dart';

class CompanyEditScreen extends StatefulWidget {
  const CompanyEditScreen({super.key});

  @override
  State<CompanyEditScreen> createState() => _CompanyEditScreenState();
}

class _CompanyEditScreenState extends State<CompanyEditScreen> {
  static final RegExp _emailPattern = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');

  late final CompanyProfileCompletionCubit _cubit =
      getIt<CompanyProfileCompletionCubit>();
  final _nameCtrl = TextEditingController();
  final _aboutCtrl = TextEditingController();
  final _websiteCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _aboutCtrl.dispose();
    _websiteCtrl.dispose();
    _phoneCtrl.dispose();
    _emailCtrl.dispose();
    _cubit.close();
    super.dispose();
  }

  Future<void> _load() async {
    await _cubit.loadWorkspace();
    if (!mounted) return;
    final company = _cubit.state.company;
    final details = _cubit.state.details;
    setState(() {
      _nameCtrl.text = company?.companyName ?? '';
      _aboutCtrl.text = company?.about ?? '';
      _websiteCtrl.text = company?.website ?? '';
      _phoneCtrl.text = details?.contactPhone ?? '';
      _emailCtrl.text = (details?.companyEmail.isNotEmpty ?? false)
          ? details!.companyEmail
          : company?.companyEmail ?? '';
    });
  }

  String get _website {
    final raw = _websiteCtrl.text.trim();
    if (raw.isEmpty || raw.contains('://')) return raw;
    return 'https://$raw';
  }

  bool _isValidWebsite(String url) {
    final uri = Uri.tryParse(url);
    return uri != null &&
        !url.contains('@') &&
        (uri.scheme == 'http' || uri.scheme == 'https') &&
        uri.host.contains('.');
  }

  String? _validate(CompanyProfileCompletionState state) {
    if (_nameCtrl.text.trim().isEmpty) {
      return LocaleKeys.companyWorkspace_errorName.tr();
    }
    if (_aboutCtrl.text.trim().isEmpty) {
      return LocaleKeys.companyWorkspace_errorAbout.tr();
    }
    final website = _website;
    if (website.isNotEmpty && !_isValidWebsite(website)) {
      return LocaleKeys.companyWorkspace_errorWebsite.tr();
    }
    if (state.industry?.selectedId == null) {
      return LocaleKeys.companyWorkspace_errorIndustry.tr();
    }
    if (state.details?.companySize == null) {
      return LocaleKeys.companyWorkspace_errorSize.tr();
    }
    if (state.details?.cityId == null) {
      return LocaleKeys.companyWorkspace_errorCity.tr();
    }
    if (_phoneCtrl.text.trim().isEmpty) {
      return LocaleKeys.companyWorkspace_errorPhone.tr();
    }
    if (!_emailPattern.hasMatch(_emailCtrl.text.trim())) {
      return LocaleKeys.companyWorkspace_errorEmail.tr();
    }
    return null;
  }

  Future<void> _save() async {
    if (_saving) return;
    FocusScope.of(context).unfocus();
    final error = _validate(_cubit.state);
    if (error != null) {
      AppOverlay.showError(error);
      return;
    }
    setState(() => _saving = true);
    final saved = await _cubit.saveAll(
      companyName: _nameCtrl.text.trim(),
      about: _aboutCtrl.text.trim(),
      website: _website,
      contactPhone: _phoneCtrl.text.trim(),
      companyEmail: _emailCtrl.text.trim(),
    );
    if (!mounted) return;
    setState(() => _saving = false);
    if (!saved) return;
    AppOverlay.showSuccess(LocaleKeys.companyHub_saved.tr());
    Navigator.of(context).pop(true);
  }

  Future<void> _pickLogo() async {
    final source = await PhotoSourceSheet.show(context);
    if (source == null || !mounted) return;
    try {
      final picked = await ImagePicker().pickImage(
        source: source,
        maxWidth: 1024,
        imageQuality: 85,
      );
      if (picked == null || !mounted) return;
      _cubit.pickCompanyLogo(File(picked.path));
    } catch (_) {
      AppOverlay.showError(
        LocaleKeys.profile_type_basic_info_photo_pick_error.tr(),
      );
    }
  }

  Widget _form(CompanyProfileCompletionState state) {
    final industries = state.industry?.industries ?? const [];
    final industryById = {for (final i in industries) i.id: i};
    final subIndustries = state.subIndustry?.industries ?? const [];
    final details = state.details;
    final cities = details?.cities ?? const [];
    final cityById = {for (final c in cities) c.id: c};
    return ListView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      padding: EdgeInsets.fromLTRB(22.w, 8.h, 22.w, 28.h),
      children: [
        WorkspaceLogoRow(
          name: _nameCtrl.text,
          logoUrl: state.company?.logoUrl,
          logoFile: state.companyLogoFile,
          onPick: _pickLogo,
        ),
        WorkspaceField(
          label: LocaleKeys.companyWorkspace_nameLabel.tr(),
          hint: LocaleKeys.companyWorkspace_nameHint.tr(),
          controller: _nameCtrl,
          required: true,
          onChanged: (_) => setState(() {}),
        ),
        WorkspaceField(
          label: LocaleKeys.companyWorkspace_aboutLabel.tr(),
          hint: LocaleKeys.companyWorkspace_aboutHint.tr(),
          controller: _aboutCtrl,
          required: true,
          maxLines: 3,
        ),
        WorkspaceField(
          label: LocaleKeys.companyWorkspace_websiteLabel.tr(),
          hint: 'https://example.com',
          controller: _websiteCtrl,
          keyboardType: TextInputType.url,
        ),
        WorkspaceSelectField<String>(
          label: LocaleKeys.companyHub_industry.tr(),
          hint: LocaleKeys.companyWorkspace_industryHint.tr(),
          required: true,
          value: state.industry?.selectedId,
          options: [for (final i in industries) i.id],
          labelOf: (id) => industryById[id]?.name ?? '',
          onChanged: _cubit.chooseIndustry,
        ),
        if (subIndustries.isNotEmpty) ...[
          WorkspaceSectionTitle(title: LocaleKeys.companyHub_activityType.tr()),
          WorkspacePairGrid(
            children: [
              for (final option in subIndustries)
                WorkspaceChoiceCard(
                  title: option.name,
                  subtitle: option.description,
                  selected: option.id == state.subIndustry?.selectedId,
                  onTap: () => _cubit.selectSubIndustry(option.id),
                ),
            ],
          ),
        ],
        WorkspaceSectionTitle(title: LocaleKeys.companyHub_size.tr()),
        WorkspacePairGrid(
          children: [
            for (final size in details?.sizes ?? const [])
              WorkspaceSizeCard(
                label: size.type,
                caption: LocaleKeys.companyWorkspace_sizeCaption.tr(),
                selected: size.type == details?.companySize,
                onTap: () => _cubit.selectCompanySize(size.type),
              ),
          ],
        ),
        SizedBox(height: 14.h),
        WorkspaceSelectField<String>(
          label: LocaleKeys.companyWorkspace_cityLabel.tr(),
          hint: LocaleKeys.companyWorkspace_cityHint.tr(),
          required: true,
          value: details?.cityId,
          options: [for (final c in cities) c.id],
          labelOf: (id) => cityById[id]?.name ?? '',
          onChanged: _cubit.selectCity,
        ),
        WorkspaceFieldLabel(
          text: LocaleKeys.companyHub_phone.tr(),
          required: true,
        ),
        CustomTextFieldPhoneCode(
          controller: _phoneCtrl,
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
          controller: _emailCtrl,
          required: true,
          keyboardType: TextInputType.emailAddress,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompanyProfileCompletionCubit,
        CompanyProfileCompletionState>(
      bloc: _cubit,
      builder: (context, state) {
        final ready =
            state.companyLoaded && state.industryLoaded && state.detailsLoaded;
        final loadError = state.company == null
            ? state.companyError
            : state.details == null
                ? state.detailsError
                : null;
        return Scaffold(
          backgroundColor: AppColors.backgroundColor.themeColor,
          body: Column(
            children: [
              SafeArea(
                bottom: false,
                child: FlowTopBar(title: LocaleKeys.companyHub_editTitle.tr()),
              ),
              Expanded(
                child: CustomScreenStateLayout(
                  isLoading: !ready,
                  error: ready && loadError != null
                      ? ErrorModel(
                          code: ErrorEnum.otherError,
                          errorMessage: loadError,
                        )
                      : null,
                  onRetry: _load,
                  builder: (context) => _form(state),
                ),
              ),
              if (ready && loadError == null)
                Container(
                  padding: EdgeInsets.fromLTRB(22.w, 12.h, 22.w, 12.h),
                  decoration: BoxDecoration(
                    color: AppColors.white.themeColor,
                    border: Border(
                      top: BorderSide(
                          color: AppColors.studioStepLine.themeColor),
                    ),
                  ),
                  child: SafeArea(
                    top: false,
                    child: GradientActionButton(
                      title: LocaleKeys.companyHub_save.tr(),
                      loadingTitle: LocaleKeys.companyWorkspace_saving.tr(),
                      loading: _saving,
                      centerTitle: true,
                      radius: 14,
                      minHeight: 50,
                      onTap: _save,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

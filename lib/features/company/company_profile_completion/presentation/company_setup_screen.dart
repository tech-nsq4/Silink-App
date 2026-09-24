import 'dart:io';

import 'package:Silink/app/router/navigation_services.dart';
import 'package:Silink/app/router/routes.dart';
import 'package:Silink/core/di/injection.dart';
import 'package:Silink/core/utils/app_overlay.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/photo_source_sheet.dart';
import 'package:Silink/features/company/company_profile_completion/data/models/company_details_model.dart';
import 'package:Silink/features/company/company_profile_completion/data/models/company_option_model.dart';
import 'package:Silink/features/company/company_profile_completion/logic/company_profile_completion_cubit.dart';
import 'package:Silink/features/company/company_profile_completion/presentation/widgets/company_action_bar.dart';
import 'package:Silink/features/company/company_profile_completion/presentation/widgets/company_step_four.dart';
import 'package:Silink/features/company/company_profile_completion/presentation/widgets/company_step_one.dart';
import 'package:Silink/features/company/company_profile_completion/presentation/widgets/company_step_three.dart';
import 'package:Silink/features/company/company_profile_completion/presentation/widgets/company_step_two.dart';
import 'package:Silink/core/widgets/step_header.dart';
import 'package:Silink/features/profile_completion/logic/profile_completion_cubit.dart';
import 'package:Silink/features/profile_completion/presentation/contact_channels_screen.dart';
import 'package:Silink/features/profile_completion/presentation/contact_links_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class CompanySetupScreen extends StatefulWidget {
  const CompanySetupScreen({super.key});

  @override
  State<CompanySetupScreen> createState() => _CompanySetupScreenState();
}

class _CompanySetupScreenState extends State<CompanySetupScreen> {
  static const int totalSteps = 6;

  int _step = 1;

  late final CompanyProfileCompletionCubit _cubit =
      getIt<CompanyProfileCompletionCubit>();
  late final ProfileCompletionCubit _profileCubit =
      getIt<ProfileCompletionCubit>();

  late final TextEditingController _nameCtrl;
  late final TextEditingController _bioCtrl;
  late final TextEditingController _websiteCtrl;
  late final TextEditingController _phoneCtrl;
  late final TextEditingController _emailCtrl;

  @override
  void initState() {
    super.initState();

    _nameCtrl = TextEditingController();
    _bioCtrl = TextEditingController();
    _websiteCtrl = TextEditingController();
    _phoneCtrl = TextEditingController();
    _emailCtrl = TextEditingController();

    _loadStep(1);
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _bioCtrl.dispose();
    _websiteCtrl.dispose();
    _phoneCtrl.dispose();
    _emailCtrl.dispose();
    _cubit.close();
    _profileCubit.close();

    super.dispose();
  }

  Future<void> _loadStep(int step) async {
    switch (step) {
      case 1:
        await _cubit.loadCompanyProfile();
        final company = _cubit.state.company;
        if (company != null && mounted) {
          _nameCtrl.text = company.companyName;
          _bioCtrl.text = company.about;
          _websiteCtrl.text = company.website;
        }
        break;
      case 2:
        await _cubit.loadIndustries();
        break;
      case 3:
        await _cubit.loadSubIndustries();
        break;
      case 4:
        await _cubit.loadDetails();
        final details = _cubit.state.details;
        if (details != null && mounted) {
          _phoneCtrl.text = details.contactPhone;
          _emailCtrl.text = details.companyEmail;
        }
        break;
    }
  }

  String _headerTitle(CompanyProfileCompletionState state) {
    switch (_step) {
      case 1:
        final title = state.company?.title ?? '';
        return title.isNotEmpty ? title : LocaleKeys.company_step1_title.tr();
      case 2:
        final title = state.industry?.title ?? '';
        return title.isNotEmpty ? title : LocaleKeys.company_step2_title.tr();
      case 3:
        final title = state.subIndustry?.title ?? '';
        return title.isNotEmpty ? title : LocaleKeys.company_step3_title.tr();
      case 4:
        final title = state.details?.title ?? '';
        return title.isNotEmpty ? title : LocaleKeys.company_step4_title.tr();
      case 5:
        return LocaleKeys.channels_title.tr();
      case 6:
        return LocaleKeys.links_title.tr();
      default:
        return '';
    }
  }

  bool _isStepValid(CompanyProfileCompletionState state) {
    switch (_step) {
      case 1:
        return _nameCtrl.text.trim().isNotEmpty;
      case 2:
        return state.industry?.selectedId != null;
      case 3:
        final sub = state.subIndustry;
        return sub == null || sub.industries.isEmpty || sub.selectedId != null;
      case 4:
        final details = state.details;
        return details?.companySize != null &&
            details?.cityId != null &&
            _phoneCtrl.text.trim().isNotEmpty &&
            _emailCtrl.text.trim().isNotEmpty;
      default:
        return true;
    }
  }

  Future<void> _continue() async {
    final state = _cubit.state;
    if (!_isStepValid(state)) {
      AppOverlay.showError(LocaleKeys.company_error_required.tr());
      return;
    }

    bool ok;
    switch (_step) {
      case 1:
        ok = await _cubit.saveCompanyProfile(
          companyName: _nameCtrl.text.trim(),
          about: _bioCtrl.text.trim(),
          website: _websiteCtrl.text.trim(),
        );
        break;
      case 2:
        ok = await _cubit.saveIndustry();
        break;
      case 3:
        ok = await _cubit.saveSubIndustry();
        break;
      case 4:
        ok = await _cubit.saveDetails(
          contactPhone: _phoneCtrl.text.trim(),
          companyEmail: _emailCtrl.text.trim(),
        );
        break;
      case 5:
        ok = await _profileCubit.saveChannels();
        break;
      case 6:
        ok = await _profileCubit.saveLinks();
        break;
      default:
        ok = true;
    }
    if (!ok || !mounted) return;

    if (_step < totalSteps) {
      final next = _step + 1;
      await _loadStep(next);
      if (!mounted) return;
      setState(() => _step = next);
    } else {
      NavigationService.push(
        Routes.companySuccess,
        arguments: {
          'companyName': _nameCtrl.text.trim(),
          'industry': _selectedOptionName(
            state.industry?.industries ?? const [],
            state.industry?.selectedId,
          ),
          'subIndustry': _selectedOptionName(
            state.subIndustry?.industries ?? const [],
            state.subIndustry?.selectedId,
          ),
          'size': _selectedSizeLabel(state.details),
          'city': _selectedCityName(state.details),
          'phone': _phoneCtrl.text.trim(),
          'email': _emailCtrl.text.trim(),
          'website': _websiteCtrl.text.trim(),
          'bio': _bioCtrl.text.trim(),
        },
      );
    }
  }

  void _back() {
    if (_step > 1) {
      setState(() => _step--);
    } else {
      Navigator.of(context).maybePop();
    }
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
      if (mounted) {
        AppOverlay.showError(
          LocaleKeys.profile_type_basic_info_photo_pick_error.tr(),
        );
      }
    }
  }

  String _selectedOptionName(List<CompanyOptionModel> options, String? id) {
    if (id == null) return '';
    for (final option in options) {
      if (option.id == id) return option.name;
    }
    return '';
  }

  String _selectedSizeLabel(CompanyDetailsModel? details) {
    if (details == null) return '';
    for (final size in details.sizes) {
      if (size.type == details.companySize) return size.label;
    }
    return '';
  }

  String _selectedCityName(CompanyDetailsModel? details) {
    if (details == null) return '';
    for (final city in details.cities) {
      if (city.id == details.cityId) return city.name;
    }
    return '';
  }

  Widget _buildStep(CompanyProfileCompletionState state) {
    switch (_step) {
      case 1:
        return CompanyStepOne(
          nameCtrl: _nameCtrl,
          bioCtrl: _bioCtrl,
          websiteCtrl: _websiteCtrl,
          logoUrl: state.company?.logoUrl,
          logoFile: state.companyLogoFile,
          onPickLogo: _pickLogo,
          onNameChanged: () => setState(() {}),
        );

      case 2:
        return CompanyStepTwo(
          loading: state.industryLoading && state.industry == null,
          options: state.industry?.industries ?? const [],
          selectedId: state.industry?.selectedId,
          onSelected: (id) => _cubit.selectIndustry(id),
        );

      case 3:
        return CompanyStepThree(
          loading: state.subIndustryLoading && state.subIndustry == null,
          options: state.subIndustry?.industries ?? const [],
          selectedId: state.subIndustry?.selectedId,
          onSelected: (id) => _cubit.selectSubIndustry(id),
        );

      case 4:
        return CompanyStepFour(
          sizes: state.details?.sizes ?? const [],
          selectedSize: state.details?.companySize,
          onSizeSelected: (type) => _cubit.selectCompanySize(type),
          cities: state.details?.cities ?? const [],
          selectedCityId: state.details?.cityId,
          onCitySelected: (id) => _cubit.selectCity(id),
          phoneCtrl: _phoneCtrl,
          emailCtrl: _emailCtrl,
        );

      case 5:
        return const ContactChannelsStep();

      case 6:
        return const ContactLinksStep();

      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isChannelsOrLinksStep = _step == 5 || _step == 6;

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _cubit),
        BlocProvider.value(value: _profileCubit),
      ],
      child: BlocBuilder<CompanyProfileCompletionCubit,
          CompanyProfileCompletionState>(
        builder: (context, state) {
          return Scaffold(
            appBar: StepHeader(
              title: _headerTitle(state),
              step: _step,
              totalSteps: totalSteps,
              onBack: _back,
              onClose: () => Navigator.of(context).maybePop(),
            ),
            body: SafeArea(
              child: isChannelsOrLinksStep
                  ? _buildStep(state)
                  : SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                        horizontal: 19.w,
                        vertical: 16.h,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildStep(state),
                        ],
                      ),
                    ),
            ),
            bottomNavigationBar:
                BlocBuilder<ProfileCompletionCubit, ProfileCompletionState>(
              bloc: _profileCubit,
              builder: (context, profileState) => CompanyActionBar(
                titleKey: _step == totalSteps
                    ? LocaleKeys.company_create_company
                    : LocaleKeys.company_continue,
                onTap: _continue,
                secondaryTitleKey:
                    _step > 1 ? LocaleKeys.company_back : null,
                onSecondaryTap: _step > 1 ? _back : null,
                loading: state.isSavingStep || profileState.isSavingStep,
              ),
            ),
          );
        },
      ),
    );
  }
}

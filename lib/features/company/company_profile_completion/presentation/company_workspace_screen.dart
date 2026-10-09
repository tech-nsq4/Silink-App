import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../app/router/routes.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/storage/local_storage.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/app_overlay.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/flow_footer.dart';
import '../../../../core/widgets/flow_stepper.dart';
import '../../../../core/widgets/flow_top_bar.dart';
import '../../../../core/widgets/photo_source_sheet.dart';
import '../../../../core/widgets/screen_state_layout.dart';
import '../logic/company_profile_completion_cubit.dart';
import 'widgets/workspace/workspace_company_step.dart';
import 'widgets/workspace/workspace_review_step.dart';
import 'widgets/workspace/workspace_team_step.dart';

class CompanyWorkspaceScreen extends StatefulWidget {
  const CompanyWorkspaceScreen({super.key});

  @override
  State<CompanyWorkspaceScreen> createState() => _CompanyWorkspaceScreenState();
}

class _CompanyWorkspaceScreenState extends State<CompanyWorkspaceScreen> {
  static const int companyStep = 0;
  static const int teamStep = 1;
  static const int reviewStep = 2;
  static final RegExp _emailPattern = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');

  late final CompanyProfileCompletionCubit _cubit =
      getIt<CompanyProfileCompletionCubit>();
  final _nameCtrl = TextEditingController();
  final _aboutCtrl = TextEditingController();
  final _websiteCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _scrollCtrl = ScrollController();

  int _step = companyStep;
  bool _submitting = false;
  String? _error;

  List<String> get _stepLabels => [
        LocaleKeys.companyWorkspace_stepCompany.tr(),
        LocaleKeys.companyWorkspace_stepTeam.tr(),
        LocaleKeys.companyWorkspace_stepReview.tr(),
      ];

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
    _scrollCtrl.dispose();
    _cubit.close();
    super.dispose();
  }

  Future<void> _load() async {
    await _cubit.loadWorkspace();
    if (!mounted) return;
    final company = _cubit.state.company;
    final details = _cubit.state.details;
    setState(() {
      if (company != null) {
        _nameCtrl.text = company.companyName;
        _aboutCtrl.text = company.about;
        _websiteCtrl.text = company.website;
      }
      if (details != null) _phoneCtrl.text = details.contactPhone;
      _emailCtrl.text = [
        details?.companyEmail ?? '',
        company?.companyEmail ?? '',
        kUserModel?.email ?? '',
      ].firstWhere((email) => email.trim().isNotEmpty, orElse: () => '');
    });
  }

  String? _validate(CompanyProfileCompletionState state) {
    switch (_step) {
      case companyStep:
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
      case teamStep:
        final details = state.details;
        if (details?.companySize == null) {
          return LocaleKeys.companyWorkspace_errorSize.tr();
        }
        if (details?.cityId == null) {
          return LocaleKeys.companyWorkspace_errorCity.tr();
        }
        if (_phoneCtrl.text.trim().isEmpty) {
          return LocaleKeys.companyWorkspace_errorPhone.tr();
        }
        if (!_emailPattern.hasMatch(_emailCtrl.text.trim())) {
          return LocaleKeys.companyWorkspace_errorEmail.tr();
        }
    }
    return null;
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

  Future<bool> _saveStep() async {
    switch (_step) {
      case companyStep:
        final saved = await _cubit.saveCompanyProfile(
          companyName: _nameCtrl.text.trim(),
          about: _aboutCtrl.text.trim(),
          website: _website,
          companyEmail: _emailCtrl.text.trim(),
          industryId: _cubit.state.industry?.selectedId,
        );
        if (!saved) return false;
        if (_cubit.state.subIndustry?.selectedId == null) return true;
        return _cubit.saveSubIndustry();
      case teamStep:
        return _cubit.saveDetails(
          contactPhone: _phoneCtrl.text.trim(),
          companyEmail: _emailCtrl.text.trim(),
        );
      default:
        return true;
    }
  }

  Future<void> _next() async {
    if (_submitting) return;
    FocusScope.of(context).unfocus();
    final error = _validate(_cubit.state);
    setState(() => _error = error);
    if (error != null) return;
    if (_step == reviewStep) {
      await _finish();
      return;
    }
    setState(() => _submitting = true);
    final saved = await _saveStep();
    if (!mounted) return;
    setState(() {
      _submitting = false;
      if (saved) _step++;
    });
    if (saved) _scrollToTop();
  }

  Future<void> _finish() async {
    await getIt<LocalStorage>().setCompanySetupPending(false);
    if (!mounted) return;
    Navigator.of(context)
        .pushNamedAndRemoveUntil(Routes.companyDashboard, (_) => false);
  }

  void _goTo(int step) {
    setState(() {
      _step = step;
      _error = null;
    });
    _scrollToTop();
  }

  void _back() {
    if (_step > companyStep) {
      _goTo(_step - 1);
      return;
    }
    _close();
  }

  void _close() {
    final navigator = Navigator.of(context);
    if (navigator.canPop()) {
      navigator.pop();
    } else {
      navigator.pushNamedAndRemoveUntil(kHomeRoute, (_) => false);
    }
  }

  void _scrollToTop() {
    if (_scrollCtrl.hasClients) _scrollCtrl.jumpTo(0);
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

  String _nextLabel() => switch (_step) {
        companyStep => LocaleKeys.companyWorkspace_nextTeam.tr(),
        teamStep => LocaleKeys.companyWorkspace_nextReview.tr(),
        _ => LocaleKeys.companyWorkspace_create.tr(),
      };

  Widget _stepView(CompanyProfileCompletionState state) {
    final details = state.details;
    switch (_step) {
      case companyStep:
        return WorkspaceCompanyStep(
          key: const ValueKey('company'),
          nameCtrl: _nameCtrl,
          aboutCtrl: _aboutCtrl,
          websiteCtrl: _websiteCtrl,
          onNameChanged: () => setState(() {}),
          onPickLogo: _pickLogo,
          logoUrl: state.company?.logoUrl,
          logoFile: state.companyLogoFile,
          industries: state.industry?.industries ?? const [],
          industryId: state.industry?.selectedId,
          onIndustrySelected: _cubit.chooseIndustry,
          subIndustries: state.subIndustry?.industries ?? const [],
          subIndustryId: state.subIndustry?.selectedId,
          subIndustriesLoading: state.subIndustryLoading,
          onSubIndustrySelected: _cubit.selectSubIndustry,
        );
      case teamStep:
        return WorkspaceTeamStep(
          key: const ValueKey('team'),
          sizes: details?.sizes ?? const [],
          selectedSize: details?.companySize,
          onSizeSelected: _cubit.selectCompanySize,
          cities: details?.cities ?? const [],
          selectedCityId: details?.cityId,
          onCitySelected: _cubit.selectCity,
          phoneCtrl: _phoneCtrl,
          emailCtrl: _emailCtrl,
        );
      default:
        final city = details?.cities
                .where((c) => c.id == details.cityId)
                .firstOrNull
                ?.name ??
            '';
        return WorkspaceReviewStep(
          key: const ValueKey('review'),
          name: _nameCtrl.text.trim(),
          about: _aboutCtrl.text.trim(),
          city: city,
          size: details?.companySize ?? '',
          phone: _phoneCtrl.text.trim(),
          email: _emailCtrl.text.trim(),
          logoUrl: state.company?.logoUrl,
          logoFile: state.companyLogoFile,
        );
    }
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
        return PopScope(
          canPop: _step == companyStep,
          onPopInvokedWithResult: (didPop, _) {
            if (!didPop) _back();
          },
          child: Scaffold(
            backgroundColor: AppColors.backgroundColor.themeColor,
            body: Column(
              children: [
                SafeArea(
                  bottom: false,
                  child: FlowTopBar(
                    eyebrow: LocaleKeys.companyWorkspace_headerStep
                        .tr(args: ['${_step + 1}', '${_stepLabels.length}']),
                    title: LocaleKeys.companyWorkspace_headerTitle.tr(),
                    onBack: _back,
                    action: GestureDetector(
                      onTap: _close,
                      behavior: HitTestBehavior.opaque,
                      child: AppText(
                        LocaleKeys.companyWorkspace_close.tr(),
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.accentTeal.themeColor,
                      ),
                    ),
                  ),
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
                    builder: (context) => ListView(
                      controller: _scrollCtrl,
                      padding: EdgeInsets.fromLTRB(22.w, 8.h, 22.w, 25.h),
                      children: [
                        FlowStepper(
                          labels: _stepLabels,
                          current: _step,
                          onTap: _goTo,
                        ),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 220),
                          child: _stepView(state),
                        ),
                      ],
                    ),
                  ),
                ),
                if (ready && loadError == null)
                  FlowFooter(
                    title: _nextLabel(),
                    loading: _submitting,
                    loadingTitle: LocaleKeys.companyWorkspace_saving.tr(),
                    error: _error,
                    onTap: _next,
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

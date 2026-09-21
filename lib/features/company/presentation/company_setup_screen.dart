import 'package:Silink/app/router/navigation_services.dart';
import 'package:Silink/app/router/routes.dart';
import 'package:Silink/core/utils/app_overlay.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/features/company/logic/company_cubit.dart';
import 'package:Silink/features/company/logic/company_state.dart';
import 'package:Silink/features/company/widgets/company_action_bar.dart';
import 'package:Silink/features/company/widgets/company_review_step.dart';
import 'package:Silink/features/company/widgets/company_step_four.dart';
import 'package:Silink/features/company/widgets/company_step_one.dart';
import 'package:Silink/features/company/widgets/company_step_three.dart';
import 'package:Silink/features/company/widgets/company_step_two.dart';
import 'package:Silink/core/widgets/step_header.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CompanySetupScreen extends StatefulWidget {
  const CompanySetupScreen({super.key});

  @override
  State<CompanySetupScreen> createState() => _CompanySetupScreenState();
}

class _CompanySetupScreenState extends State<CompanySetupScreen> {
  int _step = 1;

  late final TextEditingController _nameCtrl;
  late final TextEditingController _regCtrl;
  late final TextEditingController _taxCtrl;
  late final TextEditingController _descCtrl;
  late final TextEditingController _emailCtrl;
  late final TextEditingController _phoneCtrl;
  late final TextEditingController _websiteCtrl;
  late final TextEditingController _cityCtrl;
  late final TextEditingController _districtCtrl;

  String? _activityNature;
  String? _employeesRange;

  @override
  void initState() {
    super.initState();
    final company = context.read<CompanyCubit>().state.company;
    _nameCtrl = TextEditingController(text: company.name);
    _regCtrl = TextEditingController(text: company.registrationNumber);
    _taxCtrl = TextEditingController(text: company.taxNumber);
    _descCtrl = TextEditingController(text: company.activityDescription);
    _emailCtrl = TextEditingController(text: company.email);
    _phoneCtrl = TextEditingController(text: company.phone);
    _websiteCtrl = TextEditingController(text: company.website);
    _cityCtrl = TextEditingController(text: company.city);
    _districtCtrl = TextEditingController(text: company.district);
    _activityNature = company.activityNature.isEmpty ? null : company.activityNature;
    _employeesRange = company.employeesRange.isEmpty ? null : company.employeesRange;
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _regCtrl.dispose();
    _taxCtrl.dispose();
    _descCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _websiteCtrl.dispose();
    _cityCtrl.dispose();
    _districtCtrl.dispose();
    super.dispose();
  }

  CompanyCubit get _cubit => context.read<CompanyCubit>();

  String get _headerTitle {
    switch (_step) {
      case 1:
        return LocaleKeys.company_step1_title.tr();
      case 2:
        return LocaleKeys.company_step2_title.tr();
      case 3:
        return LocaleKeys.company_step3_title.tr();
      case 4:
        return LocaleKeys.company_step4_title.tr();
      default:
        return LocaleKeys.company_step5_title.tr();
    }
  }

  void _saveStep() {
    _cubit.setField(
      name: _nameCtrl.text.trim(),
      registrationNumber: _regCtrl.text.trim(),
      taxNumber: _taxCtrl.text.trim(),
      activityDescription: _descCtrl.text.trim(),
      email: _emailCtrl.text.trim(),
      phone: _phoneCtrl.text.trim(),
      website: _websiteCtrl.text.trim(),
      city: _cityCtrl.text.trim(),
      district: _districtCtrl.text.trim(),
      activityNature: _activityNature ?? '',
      employeesRange: _employeesRange ?? '',
    );
  }

  bool get _currentStepValid {
    switch (_step) {
      case 1:
        return _nameCtrl.text.trim().isNotEmpty && _regCtrl.text.trim().isNotEmpty;
      case 4:
        return _employeesRange != null &&
            _phoneCtrl.text.trim().isNotEmpty &&
            _emailCtrl.text.trim().isNotEmpty;
      default:
        return true;
    }
  }

  void _continue() {
    if (!_currentStepValid) {
      AppOverlay.showError(LocaleKeys.company_error_required.tr());
      return;
    }
    _saveStep();
    if (_step < 5) {
      setState(() => _step++);
    } else {
      _submit();
    }
  }

  Future<void> _submit() async {
    try {
      await _cubit.submitCompany();
      if (!mounted) return;
      NavigationService.push(Routes.companySuccess);
    } catch (_) {
      if (!mounted) return;
      AppOverlay.showError(LocaleKeys.company_error_required.tr());
    }
  }

  void _back() {
    if (_step > 1) {
      _saveStep();
      setState(() => _step--);
    } else {
      Navigator.of(context).maybePop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompanyCubit, CompanyState>(
      builder: (context, state) => Scaffold(
        appBar: StepHeader(
          title: _headerTitle,
          step: _step,
          totalSteps: 5,
          onBack: _back,
          onClose: () => Navigator.of(context).maybePop(),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 19.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildStep(state),
              ],
            ),
          ),
        ),
        bottomNavigationBar: CompanyActionBar(
          titleKey: _step == 5
              ? LocaleKeys.company_create_company
              : LocaleKeys.company_continue,
          onTap: _continue,
          secondaryTitleKey: _step > 1 ? LocaleKeys.company_back : null,
          onSecondaryTap: _step > 1 ? _back : null,
          loading: state.isLoading,
        ),
      ),
    );
  }

  Widget _buildStep(CompanyState state) {
    switch (_step) {
      case 1:
        return CompanyStepOne(
          nameCtrl: _nameCtrl,
          regCtrl: _regCtrl,
          taxCtrl: _taxCtrl,
          descCtrl: _descCtrl,
          emailCtrl: _emailCtrl,
          onNameChanged: () => setState(() {}),
        );
      case 2:
        return CompanyStepTwo(
          selected: state.company.businessType,
          onSelected: (type) => _cubit.setField(businessType: type),
        );
      case 3:
        return CompanyStepThree(
          activityNature: _activityNature,
          onActivityNatureChanged: (key) => setState(() => _activityNature = key),
          hasOnlineStore: state.company.hasOnlineStore,
          onOnlineStoreChanged: (value) => _cubit.setField(hasOnlineStore: value),
          cityCtrl: _cityCtrl,
          districtCtrl: _districtCtrl,
          websiteCtrl: _websiteCtrl,
        );
      case 4:
        return CompanyStepFour(
          employeesRange: _employeesRange,
          onEmployeesRangeChanged: (range) => setState(() => _employeesRange = range),
          phoneCtrl: _phoneCtrl,
          emailCtrl: _emailCtrl,
        );
      default:
        final company = state.company;
        return CompanyReviewStep(
          name: company.name,
          registrationNumber: company.registrationNumber,
          taxNumber: company.taxNumber,
          businessTypeKey: company.businessType.key,
          activityNature: _activityNature,
          city: company.city,
          district: company.district,
          employeesRange: _employeesRange,
          email: company.email,
        );
    }
  }
}
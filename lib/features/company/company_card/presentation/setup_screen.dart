import 'package:Silink/app/router/navigation_services.dart';
import 'package:Silink/app/router/routes.dart';
import 'package:Silink/core/utils/app_overlay.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/step_header.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../company_profile_completion/presentation/widgets/company_action_bar.dart';
import '../../company_profile_completion/presentation/widgets/company_step_one.dart';
import '../../company_profile_completion/presentation/widgets/company_step_three.dart';
import '../../company_profile_completion/presentation/widgets/company_step_two.dart';
import '../../data/models/company_business_type.dart';

class SetupScreen extends StatefulWidget {
  const SetupScreen({super.key});

  @override
  State<SetupScreen> createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
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

  CompanyBusinessType? _businessType;
  String? _activityNature;
  String? _employeesRange;
  bool _hasOnlineStore = false;

  @override
  void initState() {
    super.initState();

    _nameCtrl = TextEditingController();
    _regCtrl = TextEditingController();
    _taxCtrl = TextEditingController();
    _descCtrl = TextEditingController();
    _emailCtrl = TextEditingController();
    _phoneCtrl = TextEditingController();
    _websiteCtrl = TextEditingController();
    _cityCtrl = TextEditingController();
    _districtCtrl = TextEditingController();
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

  bool get _currentStepValid {
    switch (_step) {
      case 1:
        return _nameCtrl.text.trim().isNotEmpty &&
            _regCtrl.text.trim().isNotEmpty;

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
      AppOverlay.showError(
        LocaleKeys.company_error_required.tr(),
      );
      return;
    }

    if (_step < 5) {
      setState(() {
        _step++;
      });
    } else {
      NavigationService.push(Routes.companySuccess);
    }
  }

  void _back() {
    if (_step > 1) {
      setState(() {
        _step--;
      });
    } else {
      Navigator.of(context).maybePop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StepHeader(
        title: _headerTitle,
        step: _step,
        totalSteps: 5,
        onBack: _back,
        onClose: () => Navigator.of(context).maybePop(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: 19.w,
            vertical: 16.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildStep(),
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
        loading: false,
      ),
    );
  }

  Widget _buildStep() {
    // switch (_step) {
    //   case 1:
        return CompanyStepOne(
          nameCtrl: _nameCtrl,
          // regCtrl: _regCtrl,
          // taxCtrl: _taxCtrl,
          // descCtrl: _descCtrl,
          // emailCtrl: _emailCtrl,
          onNameChanged: () => setState(() {}), bioCtrl: _regCtrl, websiteCtrl: _regCtrl, logoUrl: '', logoFile: null, onPickLogo: () {  },
        );

      // case 2:
      //   return CompanyStepTwo(
      //     selected: _businessType,
      //     onSelected: (CompanyBusinessType type) {
      //       setState(() {
      //         _businessType = type;
      //       });
      //     },
      //   );
      //
      // case 3:
      //   return CompanyStepThree(
      //     activityNature: _activityNature,
      //     onActivityNatureChanged: (key) {
      //       setState(() {
      //         _activityNature = key;
      //       });
      //     },
      //     hasOnlineStore: _hasOnlineStore,
      //     onOnlineStoreChanged: (value) {
      //       setState(() {
      //         _hasOnlineStore = value;
      //       });
      //     },
      //     cityCtrl: _cityCtrl,
      //     districtCtrl: _districtCtrl,
      //     websiteCtrl: _websiteCtrl, loading: null, options: [], selectedId: '', onSelected: (String value) {  },
      //   );
      //
      // case 4:
      //   return CompanyStepFour(
      //     employeesRange: _employeesRange,
      //     onEmployeesRangeChanged: (range) {
      //       setState(() {
      //         _employeesRange = range;
      //       });
      //     },
      //     phoneCtrl: _phoneCtrl,
      //     emailCtrl: _emailCtrl,
      //   );
      //
      // default:
      //   return CompanyReviewStep(
      //     name: _nameCtrl.text,
      //     registrationNumber: _regCtrl.text,
      //     taxNumber: _taxCtrl.text,
      //     businessTypeKey: _businessType?.key ?? '',
      //     activityNature: _activityNature,
      //     city: _cityCtrl.text,
      //     district: _districtCtrl.text,
      //     employeesRange: _employeesRange,
      //     email: _emailCtrl.text,
      //   );
    // }
  }
}

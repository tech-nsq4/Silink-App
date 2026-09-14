import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/app_overlay.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_button.dart';
import 'package:Silink/features/role/models/onboarding_data.dart';
import 'package:Silink/features/role/presentation/basic_info_screen.dart';
import 'package:Silink/features/role/presentation/profile_type_screen.dart';
import 'package:Silink/features/role/presentation/widgets/step_header.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class OnboardingFlowScreen extends StatefulWidget {
  const OnboardingFlowScreen({super.key});

  @override
  State<OnboardingFlowScreen> createState() => _OnboardingFlowScreenState();
}

class _OnboardingFlowScreenState extends State<OnboardingFlowScreen> {
  static const int totalSteps = 9;
  static const int implementedSteps = 2;

  final OnboardingData _data = OnboardingData();
  int _currentStep = 1;

  bool _step1Valid = false;
  bool _step2Valid = false;

  String get _headerTitle {
    switch (_currentStep) {
      case 1:
        return LocaleKeys.profile_type_title.tr();
      case 2:
        return LocaleKeys.profile_type_app_bar_title_basic_info.tr();
      default:
        return '';
    }
  }

  bool get _currentStepValid => _currentStep == 1 ? _step1Valid : _step2Valid;

  void _handleNext() {
    if (!_currentStepValid) return;
    if (_currentStep < implementedSteps) {
      setState(() => _currentStep++);
    } else {
      AppOverlay.showSuccess(
        LocaleKeys.profile_type_basic_info_saved_snackbar.tr(),
      );
    }
  }

  void _handleBack() {
    if (_currentStep > 1) {
      setState(() => _currentStep--);
    } else {
      Navigator.of(context).maybePop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StepHeader(
        title: _headerTitle,
        step: _currentStep,
        totalSteps: totalSteps,
        onBack: _handleBack,
        onClose: () => Navigator.of(context).maybePop(),
      ),
      body: IndexedStack(
        index: _currentStep - 1,
        children: [
          ProfileTypeStep(
            selected: _data.profileType,
            onSelected: (type) {
              setState(() {
                _data.profileType = type;
                _step1Valid = true;
              });
            },
          ),
          BasicInfoStep(
            data: _data,
            onValidityChanged: (valid) {
              if (_step2Valid != valid) {
                setState(() => _step2Valid = valid);
              }
            },
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: AppColors.white.themeColor,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
          child: CustomButton(
            onTap: _handleNext,
            title: LocaleKeys.onboarding_next.tr(),
            height: 54,
            radius: 14,
          ),
        ),
      ),
    );
  }
}

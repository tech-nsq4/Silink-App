import 'package:Silink/app/router/navigation_services.dart';
import 'package:Silink/app/router/routes.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/app_overlay.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_button.dart';
import 'package:Silink/features/auth/logic/auth_cubit.dart';
import 'package:Silink/features/profile_completion/models/profile_completion_data.dart';
import 'package:Silink/features/profile_completion/presentation/basic_info_screen.dart';
import 'package:Silink/features/profile_completion/presentation/profile_type_screen.dart';
import 'package:Silink/features/profile_completion/presentation/widgets/step_header.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonalRegisterScreen extends StatefulWidget {
  const PersonalRegisterScreen({super.key, required this.usageIntent});

  final String usageIntent;

  @override
  State<PersonalRegisterScreen> createState() =>
      _PersonalRegisterScreenState();
}

class _PersonalRegisterScreenState extends State<PersonalRegisterScreen> {
  static const int totalSteps = 2;

  final ProfileCompletionData _data = ProfileCompletionData();
  int _currentStep = 1;
  bool _step2Valid = false;

  String get _headerTitle {
    return _currentStep == 1
        ? LocaleKeys.profile_type_title.tr()
        : LocaleKeys.profile_type_app_bar_title_basic_info.tr();
  }

  String get _nextButtonLabel {
    return _currentStep == 1
        ? LocaleKeys.onboarding_next.tr()
        : LocaleKeys.auth_createAccountButton.tr();
  }

  void _handleBack() {
    if (_currentStep > 1) {
      setState(() => _currentStep = 1);
    } else {
      Navigator.of(context).maybePop();
    }
  }

  void _handleNext() {
    if (_currentStep == 1) {
      if (_data.profileType == null) {
        AppOverlay.showError(LocaleKeys.profile_type_subTitle.tr());
        return;
      }
      setState(() => _currentStep = 2);
      return;
    }

    if (!_step2Valid) {
      AppOverlay.showError(
        LocaleKeys.profile_type_basic_info_required_error.tr(),
      );
      return;
    }

    context.read<AuthCubit>().registerPersonal(
          usageIntent: widget.usageIntent,
          profileType: _data.profileType!.apiValue,
          fullName: _data.fullName,
          jobTitle: _data.jobTitle,
          company: _data.company,
          bio: _data.bio,
          address: _data.location,
          lat: _data.lat,
          lng: _data.lng,
          phone: _data.phone,
          password: _data.password,
          photo: _data.photo,
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listenWhen: (previous, current) => current is AuthRegistrationPending,
      listener: (context, state) {
        if (state is AuthRegistrationPending) {
          NavigationService.push(Routes.otpScreen, arguments: {
            'destination': state.phone,
            'registrationId': state.registrationId,
            'expiresAt': state.expiresAt,
          });
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;

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
                onSelected: (type) => setState(() => _data.profileType = type),
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
                title: _nextButtonLabel,
                // height: 54,
                // radius: 14,
                loading: isLoading,
              ),
            ),
          ),
        );
      },
    );
  }
}

import 'package:Silink/app/router/routes.dart';
import 'package:Silink/core/di/injection.dart';
import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_button.dart';
import 'package:Silink/features/profile_completion/logic/profile_completion_cubit.dart';
import 'package:Silink/features/profile_completion/data/models/profile_completion_data.dart';
import 'package:Silink/features/profile_completion/presentation/appearance_screen.dart';
import 'package:Silink/features/profile_completion/presentation/contact_channels_screen.dart';
import 'package:Silink/features/profile_completion/presentation/contact_links_screen.dart';
import 'package:Silink/features/profile_completion/presentation/content_ranking_screen.dart';
import 'package:Silink/features/profile_completion/presentation/products_screen.dart';
import 'package:Silink/features/profile_completion/presentation/template_selection_screen.dart';
import 'package:Silink/features/profile_card/presentation/profile_card_screen.dart';
import 'package:Silink/core/widgets/step_header.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCompletionScreen extends StatefulWidget {
  const ProfileCompletionScreen({super.key});

  @override
  State<ProfileCompletionScreen> createState() =>
      _ProfileCompletionScreenState();
}

class _ProfileCompletionScreenState extends State<ProfileCompletionScreen> {
  static const int totalSteps = 6;

  final ProfileCompletionData _data = ProfileCompletionData();
  late final ProfileCompletionCubit _cubit = getIt<ProfileCompletionCubit>();
  int _currentStep = 1;
  late final Set<int> _visitedSteps = {0};
  late final List<Widget> _stepWidgets = [
    const ContactChannelsStep(),
    const ContactLinksStep(),
    const ProductsStep(),
    const ContentRankingStep(),
    const TemplateSelectionStep(),
    AppearanceStep(data: _data),
  ];

  String get _headerTitle {
    switch (_currentStep) {
      case 1:
        return LocaleKeys.channels_title.tr();
      case 2:
        return LocaleKeys.links_title.tr();
      case 3:
        return LocaleKeys.products_title.tr();
      case 4:
        return LocaleKeys.ranking_title.tr();
      case 5:
        return LocaleKeys.template_title.tr();
      case 6:
        return LocaleKeys.appearance_title.tr();
      default:
        return '';
    }
  }

  String get _nextButtonLabel {
    if (_currentStep == totalSteps) {
      return LocaleKeys.appearance_previewProfile.tr();
    }
    return LocaleKeys.onboarding_next.tr();
  }

  Future<void> _handleNext() async {
    final ok = await _cubit.saveStep(_currentStep);
    if (!ok || !mounted) return;
    if (_currentStep < totalSteps) {
      setState(() {
        _currentStep++;
        _visitedSteps.add(_currentStep - 1);
      });
      return;
    }
    await _openProfileCard();
  }

  Future<void> _openProfileCard() async {
    final result = await context.pushNamed(Routes.profileCardScreen);
    if (!mounted || result != ProfileCardScreen.viewAllProductsResult) return;
    setState(() {
      _currentStep = 3;
      _visitedSteps.add(_currentStep - 1);
    });
  }

  void _handleBack() {
    if (_currentStep > 1) {
      setState(() => _currentStep--);
    } else {
      Navigator.of(context).maybePop();
    }
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  PreferredSizeWidget get _appBar {
    return StepHeader(
      title: _headerTitle,
      step: _currentStep,
      totalSteps: totalSteps,
      onBack: _handleBack,
      onClose: () => Navigator.of(context).maybePop(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        appBar: _appBar,
        body: IndexedStack(
          index: _currentStep - 1,
          children: [
            for (int i = 0; i < totalSteps; i++)
              _visitedSteps.contains(i)
                  ? _stepWidgets[i]
                  : const SizedBox.shrink(),
          ],
        ),
        bottomNavigationBar: Container(
          color: AppColors.white.themeColor,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
            child: BlocBuilder<ProfileCompletionCubit, ProfileCompletionState>(
              builder: (context, state) => CustomButton(
                onTap: _handleNext,
                title: state.isSavingStep ? null : _nextButtonLabel,
                loading: state.isSavingStep,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

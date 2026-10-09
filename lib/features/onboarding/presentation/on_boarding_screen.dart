import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/router/routes.dart';
import '../../../core/di/injection.dart';
import '../../../core/storage/local_storage.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/locale_keys.dart';
import '../../../core/widgets/gradient_action_button.dart';
import '../data/models/onboarding_slide.dart';
import 'widgets/onboarding_art.dart';
import 'widgets/onboarding_dots.dart';
import 'widgets/onboarding_slide_copy.dart';
import 'widgets/onboarding_top_bar.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  static const List<OnboardingSlide> _slides = OnboardingSlide.slides;

  int _step = 0;

  bool get _isLast => _step == _slides.length - 1;

  void _goTo(int step) {
    if (step < 0 || step >= _slides.length || step == _step) return;
    setState(() => _step = step);
  }

  void _next() => _isLast ? _chooseExperience() : _goTo(_step + 1);

  void _chooseExperience() {
    getIt<LocalStorage>().setOnboardingSeen();
    Navigator.pushNamed(context, Routes.usageTypeScreen);
  }

  void _skip() => _chooseExperience();

  void _onSwipe(DragEndDetails details) {
    final velocity = details.primaryVelocity ?? 0;
    if (velocity.abs() < 200) return;
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    final forward = isRtl ? velocity > 0 : velocity < 0;
    _goTo(forward ? _step + 1 : _step - 1);
  }

  @override
  Widget build(BuildContext context) {
    final slide = _slides[_step];
    return Scaffold(
      backgroundColor: AppColors.backgroundColor.themeColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            OnboardingTopBar(onSkip: _skip),
            Expanded(
              child: GestureDetector(
                onHorizontalDragEnd: _onSwipe,
                behavior: HitTestBehavior.opaque,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      OnboardingArt(stage: _step),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        transitionBuilder: (child, animation) =>
                            FadeTransition(
                          opacity: animation,
                          child: SlideTransition(
                            position: Tween(
                              begin: const Offset(0, 0.06),
                              end: Offset.zero,
                            ).animate(animation),
                            child: child,
                          ),
                        ),
                        child: OnboardingSlideCopy(
                          key: ValueKey(_step),
                          slide: slide,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  OnboardingDots(
                    count: _slides.length,
                    current: _step,
                    onSelect: _goTo,
                  ),
                  SizedBox(height: 18.h),
                  GradientActionButton(
                    title: _isLast
                        ? LocaleKeys.onboarding_chooseExperience.tr()
                        : LocaleKeys.onboarding_next.tr(),
                    onTap: _next,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

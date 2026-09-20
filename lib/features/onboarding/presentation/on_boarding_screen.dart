import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/features/onboarding/widget/custom_slider_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../app/router/routes.dart';
import '../../../core/di/injection.dart';
import '../../../core/storage/local_storage.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_constants.dart';
import '../../../core/utils/app_images.dart';
import '../../../core/utils/locale_keys.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final _pageController = PageController();
  int _currentPage = 0;

  late final List<OnboardingSlide> _slides = [
    OnboardingSlide(
      imageUrl: AppImages.onboarding1,
      title: LocaleKeys.onboarding_slide1_title.tr(),
      subtitle: LocaleKeys.onboarding_slide1_subtitle.tr(),
      desc: LocaleKeys.onboarding_slide1_desc.tr(),
    ),
    OnboardingSlide(
      imageUrl: AppImages.onboarding2,
      title: LocaleKeys.onboarding_slide2_title.tr(),
      subtitle: LocaleKeys.onboarding_slide2_subtitle.tr(),
      desc: LocaleKeys.onboarding_slide2_desc.tr(),
    ),
    OnboardingSlide(
      imageUrl: AppImages.onboarding3,
      title: LocaleKeys.onboarding_slide3_title.tr(),
      subtitle: LocaleKeys.onboarding_slide3_subtitle.tr(),
      desc: LocaleKeys.onboarding_slide3_desc.tr(),
    ),
  ];

  bool get _isLast => _currentPage == _slides.length - 1;

  void _nextPage() {
    if (_isLast) {
      _finish();
    } else {
      _pageController.nextPage(
        duration: AppConstants.defaultAnimationDuration,
        curve: Curves.easeInOut,
      );
    }
  }

  void _finish() {
    getIt<LocalStorage>().setOnboardingSeen();
    Navigator.pushNamed(
        context, Routes.usageTypeScreen,);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = AppColors.primaryColor.themeColor;
    final currentSlide = _slides[_currentPage];

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomSliderWidget(
              pageController: _pageController,
              currentPage: _currentPage,
              slides: _slides,
              onPageChanged: (i) => setState(() => _currentPage = i),
              onSkip: _finish,
            ),

            Expanded(
              flex: 3,
              child: Container(
                color: const Color(0xFFF0FDFA),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: List.generate(
                          _slides.length,
                          (j) => AnimatedContainer(
                            duration: AppConstants.shortAnimationDuration,
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: _currentPage == j ? 24 : 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: _currentPage == j
                                  ? AppColors.mint.themeColor
                                  : primaryColor.withValues(alpha: 0.35),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),
                      16.height,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            currentSlide.title,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 20.sp,
                            textAlign: TextAlign.start,
                            maxLines: 2,
                          ),
                          SizedBox(height: 8.h),
                          AppText(
                            currentSlide.subtitle,
                            color: Colors.black.withValues(alpha: 0.9),
                            fontSize: 14.sp,
                            maxLines: 2,
                            fontWeight: FontWeight.normal,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      const Spacer(),
                      CustomButton(
                        onTap: _nextPage,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _isLast
                                ? SvgPicture.asset(AppImages.aiIcon)
                                : const SizedBox(),
                            8.width,
                            AppText(
                              _isLast
                                  ? LocaleKeys.onboarding_getStarted.tr()
                                  : LocaleKeys.onboarding_next.tr(),
                              color: AppColors.white.themeColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ],
                        ),
                      ),
                      if (_isLast) ...[
                        12.height,
                        CustomButton(
                          title: LocaleKeys.onboarding_authHaveAccount.tr(),
                          onTap: (){
                            getIt<LocalStorage>().setOnboardingSeen();
                            Navigator.pushNamed(
                              context, Routes.loginScreen,);
                          },
                          color: AppColors.white.themeColor,
                          borderColor:
                              AppColors.black.themeColor.withValues(alpha: 0.14),
                          textColor: AppColors.black.themeColor,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
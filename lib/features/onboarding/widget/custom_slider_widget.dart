import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:Silink/core/widgets/image/custom_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingSlide {
  const OnboardingSlide({
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.desc,
  });

  final String imageUrl;
  final String title;
  final String subtitle;
  final String desc;
}

class CustomSliderWidget extends StatelessWidget {
  final PageController pageController;
  final int currentPage;
  final List<OnboardingSlide> slides;
  final ValueChanged<int> onPageChanged;
  final VoidCallback onSkip;

  const CustomSliderWidget({
    super.key,
    required this.pageController,
    required this.currentPage,
    required this.slides,
    required this.onPageChanged,
    required this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    final currentSlide = slides[currentPage];
    return Expanded(
      flex: 2,
      child: Stack(
        children: [
          PageView.builder(
            controller: pageController,
            itemCount: slides.length,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: onPageChanged,
            itemBuilder: (_, i) => slides[i].imageUrl.isNotEmpty
                ? Stack(
                    fit: StackFit.expand,
                    children: [
                      CustomImage(
                        image: slides[i].imageUrl,
                        fit: BoxFit.fill,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                      FractionallySizedBox(
                        heightFactor: 1.5,
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.center,
                              colors: [
                                Color(0xFFF0FDF8),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
          ),
          Positioned(
            top: 20,
            left: 16,
            child: InkWell(
              onTap: onSkip,
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: AppText(
                  LocaleKeys.onboarding_skip.tr(),
                  color: AppColors.white.themeColor,
                  textAlign: TextAlign.center,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 16,
            child: Container(
              height: 25.h,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              decoration: BoxDecoration(
                color: AppColors.mint.themeColor,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: AppText(
                currentSlide.desc,
                color: AppColors.white.themeColor,
                textAlign: TextAlign.center,
                fontSize: 11.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
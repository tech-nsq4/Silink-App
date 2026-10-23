import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/silink_card_scene.dart';
import 'onboarding_lead_badge.dart';
import 'onboarding_shared_badge.dart';

class OnboardingArt extends StatelessWidget {
  const OnboardingArt({
    super.key,
    required this.stage,
    required this.isLast,
    this.imageUrl,
  });

  final int stage;
  final bool isLast;
  final String? imageUrl;

  static const Duration _duration = Duration(milliseconds: 350);

  @override
  Widget build(BuildContext context) {
    final scale = ScreenUtil().scaleWidth;
    final glow = stage.isOdd
        ? AppColors.onboardGlowBlue.themeColor
        : AppColors.onboardGlowTeal.themeColor;
    final image = imageUrl?.trim() ?? '';
    final scene = Transform.scale(
      scale: scale,
      child: SilinkCardScene(
        showPill: true,
        faceAngle: isLast ? 6 : -9,
        gradient: isLast
            ? [
                AppColors.accentTeal.themeColor,
                AppColors.accentBlue.themeColor,
              ]
            : null,
      ),
    );

    return AnimatedContainer(
      duration: _duration,
      height: 285.h,
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: const Alignment(0, 0.1),
          radius: 0.65,
          colors: [glow, glow.withValues(alpha: 0)],
        ),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          if (image.isEmpty)
            scene
          else
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
              child: AnimatedSwitcher(
                duration: _duration,
                child: Image.network(
                  image,
                  key: ValueKey(image),
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => scene,
                ),
              ),
            ),
          if (image.isEmpty)
            Positioned(
              bottom: 42.h,
              right: 15.w,
              child: _fade(
                visible: stage == 1,
                child: Transform.scale(
                  scale: scale,
                  alignment: Alignment.bottomRight,
                  child: const OnboardingSharedBadge(),
                ),
              ),
            ),
          if (image.isEmpty)
            Positioned(
              bottom: 30.h,
              left: 17.w,
              child: _fade(
                visible: isLast,
                child: Transform.scale(
                  scale: scale,
                  alignment: Alignment.bottomLeft,
                  child: const OnboardingLeadBadge(),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _fade({required bool visible, required Widget child}) {
    return IgnorePointer(
      child: AnimatedOpacity(
        duration: _duration,
        opacity: visible ? 1 : 0,
        child: AnimatedSlide(
          duration: _duration,
          curve: Curves.easeOutCubic,
          offset: visible ? Offset.zero : const Offset(0, 0.25),
          child: child,
        ),
      ),
    );
  }
}

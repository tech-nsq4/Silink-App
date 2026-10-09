import 'dart:math' as math;

import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/locale_keys.dart';
import 'app_text.dart';
import 'silink_brand.dart';

class SilinkCardScene extends StatelessWidget {
  const SilinkCardScene({
    super.key,
    this.gradient,
    this.faceAngle = -9,
    this.showPill = false,
  });

  static const double width = 242;
  static const double height = 174;

  final List<Color>? gradient;
  final double faceAngle;
  final bool showPill;

  @override
  Widget build(BuildContext context) {
    final white = AppColors.white.light;
    final faceGradient = gradient ??
        [AppColors.deepNavy.themeColor, AppColors.deepNavyLight.themeColor];

    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: 8,
            right: 4,
            child: Transform.rotate(
              angle: 12 * math.pi / 180,
              child: Container(
                width: 220,
                height: 140,
                decoration: BoxDecoration(
                  color: AppColors.cardRear.themeColor,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
          Positioned.fill(
            top: 12,
            child: TweenAnimationBuilder<double>(
              tween: Tween(end: faceAngle),
              duration: const Duration(milliseconds: 450),
              curve: Curves.easeOutCubic,
              builder: (context, angle, child) => Transform.rotate(
                angle: angle * math.pi / 180,
                child: child,
              ),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 450),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: faceGradient,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(17),
                  border: Border.all(color: white.withValues(alpha: 0.145)),
                  boxShadow: [
                    BoxShadow(
                      color:
                          AppColors.deepNavy.themeColor.withValues(alpha: 0.14),
                      blurRadius: 28,
                      offset: const Offset(0, 24),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Positioned(
                      left: -90,
                      top: -60,
                      child: Container(
                        width: 170,
                        height: 170,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border:
                              Border.all(color: white.withValues(alpha: 0.07)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SilinkBrand(fontSize: 17, color: white),
                                Icon(
                                  Icons.contactless_outlined,
                                  size: 18,
                                  color: AppColors.cardIcon.themeColor,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 14),
                          Container(
                            width: 29,
                            height: 29,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppColors.accentTeal.themeColor,
                              borderRadius: BorderRadius.circular(9),
                            ),
                            child: Icon(
                              Icons.work_outline_rounded,
                              size: 18,
                              color: white,
                            ),
                          ),
                          const SizedBox(height: 9),
                          AppText(
                            LocaleKeys.brand_cardTitle.tr(),
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            height: 1.5,
                            color: white,
                          ),
                          AppText(
                            LocaleKeys.brand_cardSubtitle.tr(),
                            fontSize: 8,
                            color: AppColors.cardSubtle.themeColor,
                          ),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppText(
                                LocaleKeys.brand_tagline.tr(),
                                fontSize: 5,
                                color: AppColors.cardFooter.themeColor,
                              ),
                              Icon(
                                Icons.qr_code_2_rounded,
                                size: 20,
                                color: AppColors.cardIcon.themeColor,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (showPill)
            Positioned(
              bottom: -15,
              left: -7,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.floatShadow.themeColor
                          .withValues(alpha: 0.07),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.check_rounded,
                      size: 12,
                      color: AppColors.scenePillText.themeColor,
                    ),
                    const SizedBox(width: 4),
                    AppText(
                      LocaleKeys.brand_readyPill.tr(),
                      fontSize: 8,
                      color: AppColors.scenePillText.themeColor,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

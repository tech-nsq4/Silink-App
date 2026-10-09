import 'dart:math' as math;

import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_text.dart';

class NewCardArt extends StatelessWidget {
  const NewCardArt({super.key});

  static const double _width = 260;
  static const double _height = 177;

  @override
  Widget build(BuildContext context) {
    final white = AppColors.white.light;
    return Padding(
      padding: EdgeInsets.only(top: 4.h, bottom: 29.h),
      child: Center(
        child: Transform.scale(
          scale: ScreenUtil().scaleWidth,
          child: SizedBox(
            width: _width,
            height: _height,
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: 14,
                  right: -12,
                  child: Transform.rotate(
                    angle: 8 * math.pi / 180,
                    child: Container(
                      width: 211,
                      height: 126,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.artBack.themeColor,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(
                        Icons.share_outlined,
                        size: 32,
                        color: AppColors.artBackIcon.themeColor,
                      ),
                    ),
                  ),
                ),
                Transform.rotate(
                  angle: -8 * math.pi / 180,
                  child: Container(
                    width: 232,
                    height: 143,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 19, vertical: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(
                        colors: [
                          AppColors.accentTeal.themeColor,
                          AppColors.accentBlue.themeColor,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.floatShadow.themeColor
                              .withValues(alpha: 0.15),
                          blurRadius: 25,
                          offset: const Offset(0, 18),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppText(
                                'Silink',
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: white,
                              ),
                              Icon(Icons.contactless_outlined,
                                  size: 18, color: white),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            color: white.withValues(alpha: 0.125),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: white.withValues(alpha: 0.27)),
                          ),
                        ),
                        const SizedBox(height: 8),
                        AppText(
                          LocaleKeys.newCard_artTitle.tr(),
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: white,
                        ),
                        _line(white, 75),
                        _line(white, 45),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 1,
                  right: 9,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: AppColors.artBadgeBorder.themeColor),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.artBadgeText.themeColor
                              .withValues(alpha: 0.06),
                          blurRadius: 15,
                          offset: const Offset(0, 7),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.auto_awesome_outlined,
                          size: 12,
                          color: AppColors.artBadgeText.themeColor,
                        ),
                        const SizedBox(width: 5),
                        AppText(
                          LocaleKeys.newCard_artBadge.tr(),
                          fontSize: 9,
                          color: AppColors.artBadgeText.themeColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _line(Color white, double width) => Container(
        width: width,
        height: 3,
        margin: const EdgeInsets.only(top: 8),
        decoration: BoxDecoration(
          color: white.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(10),
        ),
      );
}

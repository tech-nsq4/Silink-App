import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/silink_card_scene.dart';

class AuthEditorialCard extends StatelessWidget {
  const AuthEditorialCard({
    super.key,
    required this.eyebrow,
    required this.title,
    required this.body,
  });

  final String eyebrow;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final textWidth = 180.w;
    return Container(
      constraints: BoxConstraints(minHeight: 178.h),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.deepNavy.themeColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Stack(
        children: [
          Positioned(
            left: -70.w,
            top: 35.h,
            child: Opacity(
              opacity: 0.6,
              child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..rotateZ(-16 * math.pi / 180)
                  ..scaleByDouble(0.67.w, 0.67.w, 1, 1),
                child: SilinkCardScene(
                  gradient: [
                    AppColors.accentTeal.themeColor,
                    AppColors.accentBlue.themeColor,
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 20.h),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              layoutBuilder: (current, previous) => Stack(
                alignment: AlignmentDirectional.topStart,
                children: [...previous, if (current != null) current],
              ),
              child: Column(
                key: ValueKey(title),
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    eyebrow,
                    fontSize: 9.sp,
                    color: AppColors.editorialAccent.themeColor,
                  ),
                  SizedBox(height: 13.h),
                  SizedBox(
                    width: textWidth,
                    child: AppText(
                      title,
                      fontSize: 27.sp,
                      fontWeight: FontWeight.w800,
                      height: 1.3,
                      color: AppColors.white.light,
                    ),
                  ),
                  SizedBox(height: 13.h),
                  SizedBox(
                    width: textWidth,
                    child: AppText(
                      body,
                      fontSize: 9.sp,
                      height: 1.8,
                      color: AppColors.editorialMuted.themeColor,
                    ),
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

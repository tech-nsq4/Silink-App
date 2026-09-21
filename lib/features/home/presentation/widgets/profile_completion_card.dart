import 'package:Silink/app/router/routes.dart';
import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/widgets/custom_tap_effect.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_text.dart';

/// "اكتمال الملف" card: percentage, gradient progress bar, badge + hint.
/// The number and the bar fill animate together whenever [percent] changes.
class ProfileCompletionCard extends StatelessWidget {
  final double percent; // 0.0 - 1.0

  const ProfileCompletionCard({super.key, required this.percent});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white.themeColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.borderColor.themeColor),
      ),
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0, end: percent.clamp(0.0, 1.0)),
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOutCubic,
        builder: (context, animatedPercent, _) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText(
                    LocaleKeys.home_completion_title.tr(),
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                  AppText(
                    '${(animatedPercent * 100).round()}%',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.mint.themeColor,
                  ),
                ],
              ),
              12.height,
              ClipRRect(
                borderRadius: BorderRadius.circular(6.r),
                child: Container(
                  height: 8.h,
                  color: AppColors.fieldFill,
                  child: Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: FractionallySizedBox(
                      widthFactor: animatedPercent,
                      child: Container(
                        height: 8.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          gradient: LinearGradient(
                            colors: [Color(0xFF2F6FED), Color(0xFF17B78F)],
                            begin: Alignment.centerRight,
                            end: Alignment.centerLeft,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              12.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: AppText(
                      LocaleKeys.home_complete_profile_hint.tr(),
                      fontSize: 12.sp,
                      color: AppColors.textSecondaryColor.themeColor,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  CustomTapEffect(
                    onTap: () {
                      context.pushNamed(Routes.usageTypeScreen);
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFFdcfce7),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: AppText(
                        LocaleKeys.home_complete_profile_badge.tr(),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF008236),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

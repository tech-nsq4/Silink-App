import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/app_text.dart';
import '../../data/models/studio_platform.dart';

class StudioPlatformBadge extends StatelessWidget {
  const StudioPlatformBadge({
    super.key,
    required this.platform,
    required this.active,
  });

  final StudioPlatform platform;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: active ? 1 : 0.92,
      duration: const Duration(milliseconds: 320),
      curve: Curves.easeOutBack,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 260),
        curve: Curves.easeOut,
        width: 40.w,
        height: 40.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: active
              ? platform.color
              : AppColors.studioToggleOff.themeColor,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: active
              ? [
                  BoxShadow(
                    color: platform.color.withValues(alpha: 0.35),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : const [],
        ),
        child: AppText(
          platform.badge,
          fontSize: 13.sp,
          fontWeight: FontWeight.w800,
          color: active
              ? platform.badgeColor
              : AppColors.studioFieldHint.themeColor,
        ),
      ),
    );
  }
}

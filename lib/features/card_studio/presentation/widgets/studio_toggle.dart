import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';

class StudioToggle extends StatelessWidget {
  const StudioToggle({super.key, required this.value, required this.onChanged});

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: 32.w,
        height: 19.w,
        padding: EdgeInsets.all(3.w),
        alignment: value
            ? AlignmentDirectional.centerEnd
            : AlignmentDirectional.centerStart,
        decoration: BoxDecoration(
          color: value
              ? AppColors.accentTeal.themeColor
              : AppColors.studioToggleOff.themeColor,
          borderRadius: BorderRadius.circular(30.r),
        ),
        child: Container(
          width: 13.w,
          height: 13.w,
          decoration: BoxDecoration(
            color: AppColors.white.light,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.black.light.withValues(alpha: 0.07),
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

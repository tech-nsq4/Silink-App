import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/custom_tap_effect.dart';

class SettingsLanguageOption extends StatelessWidget {
  const SettingsLanguageOption({
    super.key,
    required this.code,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String code;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final primary = AppColors.primaryColor.themeColor;
    return CustomTapEffect(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: isSelected
              ? primary.withValues(alpha: 0.06)
              : AppColors.fieldFill,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: isSelected ? primary : AppColors.borderColor.themeColor,
            width: isSelected ? 1.6 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 36.w,
              height: 36.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.white.themeColor,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.borderColor.themeColor),
              ),
              child: AppText(
                code.toUpperCase(),
                fontSize: 11.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            12.width,
            Expanded(
              child: AppText(
                label,
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            Icon(
              isSelected
                  ? Icons.radio_button_checked_rounded
                  : Icons.radio_button_off_rounded,
              size: 20.sp,
              color: isSelected ? primary : AppColors.hintColor.themeColor,
            ),
          ],
        ),
      ),
    );
  }
}

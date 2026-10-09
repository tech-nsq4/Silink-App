import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/custom_tap_effect.dart';

class CatalogHubOptionChips extends StatelessWidget {
  const CatalogHubOptionChips({
    super.key,
    required this.options,
    required this.labelOf,
    required this.selected,
    required this.onSelected,
  });

  final List<String> options;
  final String Function(String option) labelOf;
  final String? selected;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    final accent = AppColors.accentTeal.themeColor;
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: [
        for (final option in options)
          CustomTapEffect(
            onTap: () => onSelected(option),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: option == selected
                    ? accent.withValues(alpha: 0.08)
                    : AppColors.white.themeColor,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: option == selected
                      ? accent
                      : AppColors.studioPanelBorder.themeColor,
                ),
              ),
              child: AppText(
                labelOf(option),
                fontSize: 9.sp,
                fontWeight: FontWeight.w800,
                color: option == selected
                    ? accent
                    : AppColors.textSecondaryColor.themeColor,
              ),
            ),
          ),
      ],
    );
  }
}

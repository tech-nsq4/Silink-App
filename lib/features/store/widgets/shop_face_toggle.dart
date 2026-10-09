import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/custom_tap_effect.dart';

class ShopFaceToggle extends StatelessWidget {
  const ShopFaceToggle({
    super.key,
    required this.labels,
    required this.selected,
    required this.onSelected,
  });

  final List<String> labels;
  final int selected;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    final accent = AppColors.accentTeal.themeColor;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (final (index, label) in labels.indexed) ...[
          if (index > 0) SizedBox(width: 10.w),
          CustomTapEffect(
            onTap: () => onSelected(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 9.h),
              decoration: BoxDecoration(
                color: index == selected ? accent : AppColors.white.themeColor,
                borderRadius: BorderRadius.circular(30.r),
                border: Border.all(
                  color: index == selected
                      ? accent
                      : AppColors.studioPanelBorder.themeColor,
                ),
              ),
              child: AppText(
                label,
                fontSize: 9.5.sp,
                fontWeight: FontWeight.w800,
                color: index == selected
                    ? AppColors.white.light
                    : AppColors.textSecondaryColor.themeColor,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

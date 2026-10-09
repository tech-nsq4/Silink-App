import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';
import 'app_text.dart';
import 'custom_tap_effect.dart';

class FilterChipsBar<T> extends StatelessWidget {
  const FilterChipsBar({
    super.key,
    required this.allLabel,
    required this.options,
    required this.labelOf,
    required this.selected,
    required this.onSelected,
  });

  final String allLabel;
  final List<T> options;
  final String Function(T option) labelOf;
  final T? selected;
  final ValueChanged<T?> onSelected;

  Widget _chip(String label, bool active, VoidCallback onTap) {
    final accent = AppColors.accentTeal.themeColor;
    return CustomTapEffect(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: active ? accent : AppColors.white.themeColor,
          borderRadius: BorderRadius.circular(30.r),
          border: Border.all(
            color: active ? accent : AppColors.studioPanelBorder.themeColor,
          ),
        ),
        child: AppText(
          label,
          fontSize: 9.5.sp,
          fontWeight: active ? FontWeight.w800 : FontWeight.w500,
          color: active
              ? AppColors.white.light
              : AppColors.textSecondaryColor.themeColor,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _chip(allLabel, selected == null, () => onSelected(null)),
          for (final option in options) ...[
            SizedBox(width: 8.w),
            _chip(
                labelOf(option), selected == option, () => onSelected(option)),
          ],
        ],
      ),
    );
  }
}

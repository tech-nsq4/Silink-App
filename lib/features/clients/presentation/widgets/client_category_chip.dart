import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/app_text.dart';

class ClientCategoryChip extends StatelessWidget {
  const ClientCategoryChip({
    super.key,
    required this.label,
    this.selected = false,
    this.onTap,
    this.compact = false,
  });

  final String label;
  final bool selected;
  final VoidCallback? onTap;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final accent = AppColors.accentTeal.themeColor;
    final chip = AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 10.w : 14.w,
        vertical: compact ? 3.h : 7.h,
      ),
      decoration: BoxDecoration(
        color: selected
            ? accent.withValues(alpha: 0.1)
            : AppColors.white.themeColor,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: selected ? accent : AppColors.studioPanelBorder.themeColor,
        ),
      ),
      child: AppText(
        label,
        fontSize: compact ? 7.5.sp : 9.5.sp,
        fontWeight: FontWeight.w700,
        color: selected ? accent : AppColors.textPrimaryColor.themeColor,
      ),
    );
    if (onTap == null) return chip;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: chip,
    );
  }
}

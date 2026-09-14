import 'package:Silink/core/extensions/extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_text.dart';

enum StatsPeriod { last30Days, last7Days, today }

class PeriodFilterTabs extends StatelessWidget {
  final StatsPeriod selected;
  final ValueChanged<StatsPeriod> onChanged;

  const PeriodFilterTabs({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _PeriodChip(
            label: LocaleKeys.stats_period_today.tr(),
            selected: selected == StatsPeriod.today,
            onTap: () => onChanged(StatsPeriod.today),
          ),
        ),
        8.width,
        Expanded(
          child: _PeriodChip(
            label: LocaleKeys.stats_period_7d.tr(),
            selected: selected == StatsPeriod.last7Days,
            onTap: () => onChanged(StatsPeriod.last7Days),
          ),
        ),
        8.width,
        Expanded(
          child: _PeriodChip(
            label: LocaleKeys.stats_period_30d.tr(),
            selected: selected == StatsPeriod.last30Days,
            onTap: () => onChanged(StatsPeriod.last30Days),
          ),
        ),
      ],
    );
  }
}

class _PeriodChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _PeriodChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24.r),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: EdgeInsets.symmetric(vertical: 6.h),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected
              ? AppColors.statsTabSelected.themeColor
              : AppColors.white.themeColor,
          borderRadius: BorderRadius.circular(24.r),
          border: selected
              ? null
              : Border.all(color: AppColors.borderColor.themeColor),
        ),
        child: AppText(
          label,
          fontSize: 12.sp,
          fontWeight: FontWeight.w700,
          color:
              selected ? Colors.white : AppColors.textSecondaryColor.themeColor,
        ),
      ),
    );
  }
}

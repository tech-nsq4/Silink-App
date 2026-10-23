import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_text.dart';

class PortfolioStatusSwitch extends StatelessWidget {
  const PortfolioStatusSwitch({
    super.key,
    required this.isActive,
    required this.onChanged,
    this.busy = false,
    this.bordered = true,
  });

  final bool isActive;
  final ValueChanged<bool> onChanged;
  final bool busy;
  final bool bordered;

  @override
  Widget build(BuildContext context) {
    final teal = AppColors.accentTeal.themeColor;
    final secondary = AppColors.textSecondaryColor.themeColor;
    final color = isActive ? teal : secondary;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: bordered
          ? BoxDecoration(
              color: AppColors.white.themeColor,
              borderRadius: BorderRadius.circular(18.r),
              border: Border.all(color: AppColors.studioPanelBorder.themeColor),
            )
          : null,
      child: Row(
        children: [
          Container(
            width: 34.w,
            height: 34.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(
              isActive
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              size: 17.sp,
              color: color,
            ),
          ),
          12.width,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  LocaleKeys.portfolios_statusTitle.tr(),
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w800,
                ),
                SizedBox(height: 3.h),
                AppText(
                  isActive
                      ? LocaleKeys.portfolios_statusOn.tr()
                      : LocaleKeys.portfolios_statusOff.tr(),
                  fontSize: 8.5.sp,
                  color: color,
                ),
              ],
            ),
          ),
          Switch.adaptive(
            value: isActive,
            activeTrackColor: teal,
            onChanged: busy ? null : onChanged,
          ),
        ],
      ),
    );
  }
}

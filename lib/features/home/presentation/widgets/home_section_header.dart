import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/app_text.dart';

class HomeSectionHeader extends StatelessWidget {
  const HomeSectionHeader({
    super.key,
    required this.title,
    this.trailing,
    this.actionLabel,
    this.onAction,
    this.large = false,
  });

  final String title;
  final Widget? trailing;
  final String? actionLabel;
  final VoidCallback? onAction;
  final bool large;

  @override
  Widget build(BuildContext context) {
    final accent = AppColors.accentTeal.themeColor;
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        children: [
          Expanded(
            child: AppText(
              title,
              fontSize: large ? 15.sp : 11.sp,
              fontWeight: FontWeight.w800,
            ),
          ),
          if (trailing != null) trailing!,
          if (actionLabel != null)
            GestureDetector(
              onTap: onAction,
              behavior: HitTestBehavior.opaque,
              child: Row(
                children: [
                  AppText(
                    actionLabel!,
                    fontSize: 9.sp,
                    fontWeight: FontWeight.w700,
                    color: accent,
                  ),
                  Icon(Icons.chevron_right_rounded, size: 14.sp, color: accent),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

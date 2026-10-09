import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/custom_tap_effect.dart';

class CatalogHubGroupHeader extends StatelessWidget {
  const CatalogHubGroupHeader({
    super.key,
    required this.title,
    this.actionLabel,
    this.onAction,
    this.highlighted = true,
  });

  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    final accent = AppColors.accentTeal.themeColor;
    final color =
        highlighted ? accent : AppColors.textSecondaryColor.themeColor;
    return Padding(
      padding: EdgeInsets.only(top: 6.h, bottom: 10.h),
      child: Row(
        children: [
          Expanded(
            child: AppText(title, fontSize: 12.sp, fontWeight: FontWeight.w800),
          ),
          if (actionLabel != null)
            CustomTapEffect(
              onTap: onAction,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.add_rounded, size: 14.sp, color: color),
                    4.width,
                    AppText(
                      actionLabel!,
                      fontSize: 9.sp,
                      fontWeight: FontWeight.w800,
                      color: color,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

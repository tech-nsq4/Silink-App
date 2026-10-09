import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/custom_tap_effect.dart';

class CatalogHubKindTabs extends StatelessWidget {
  const CatalogHubKindTabs({
    super.key,
    required this.labels,
    required this.selected,
    required this.onSelected,
    this.enabled = true,
  });

  final List<String> labels;
  final int selected;
  final ValueChanged<int> onSelected;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final accent = AppColors.accentTeal.themeColor;
    return Padding(
      padding: EdgeInsets.only(bottom: 18.h),
      child: Row(
        children: [
          for (final (index, label) in labels.indexed) ...[
            if (index > 0) 10.width,
            Expanded(
              child: CustomTapEffect(
                isClickable: enabled,
                onTap: enabled ? () => onSelected(index) : null,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: index == selected
                        ? accent.withValues(alpha: 0.08)
                        : AppColors.white.themeColor,
                    borderRadius: BorderRadius.circular(14.r),
                    border: Border.all(
                      color: index == selected
                          ? accent
                          : AppColors.studioPanelBorder.themeColor,
                    ),
                  ),
                  child: AppText(
                    label,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w800,
                    color: index == selected
                        ? accent
                        : AppColors.textSecondaryColor.themeColor,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/app_text.dart';
import '../../data/models/studio_section.dart';
import 'studio_move_arrows.dart';

class StudioSectionOrder extends StatelessWidget {
  const StudioSectionOrder({
    super.key,
    required this.sections,
    required this.labelOf,
    required this.onToggle,
    required this.onReorder,
  });

  final List<StudioSection> sections;
  final String Function(String type) labelOf;
  final void Function(int index, bool visible) onToggle;
  final void Function(int oldIndex, int newIndex) onReorder;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.white.themeColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.studioOrderBorder.themeColor),
      ),
      child: Column(
        children: [
          for (final (index, section) in sections.indexed)
            Container(
              key: ValueKey(section.type),
              padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 4.h),
              decoration: BoxDecoration(
                border: index == 0
                    ? null
                    : Border(
                        top: BorderSide(
                            color: AppColors.studioLinkDivider.themeColor)),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 22.w,
                    height: 22.w,
                    child: Checkbox(
                      value: section.visible,
                      activeColor: AppColors.accentTeal.themeColor,
                      side: BorderSide(
                          color: AppColors.studioFieldBorder.themeColor),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity: VisualDensity.compact,
                      onChanged: (value) => onToggle(index, value ?? false),
                    ),
                  ),
                  SizedBox(width: 11.w),
                  Expanded(
                    child: AppText(
                      labelOf(section.type),
                      fontSize: 10.sp,
                      color: AppColors.studioOrderText.themeColor,
                    ),
                  ),
                  StudioMoveArrows(
                    color: AppColors.studioOrderHandle.themeColor,
                    size: 18.sp,
                    onUp: index == 0 ? null : () => onReorder(index, index - 1),
                    onDown: index == sections.length - 1
                        ? null
                        : () => onReorder(index, index + 1),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

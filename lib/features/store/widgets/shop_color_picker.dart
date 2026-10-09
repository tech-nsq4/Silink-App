import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/custom_tap_effect.dart';

class ShopColorPicker extends StatelessWidget {
  const ShopColorPicker({
    super.key,
    required this.colors,
    required this.selected,
    required this.onSelected,
    this.size,
    this.spacing,
  });

  final List<Color> colors;
  final int selected;
  final ValueChanged<int> onSelected;
  final double? size;
  final double? spacing;

  @override
  Widget build(BuildContext context) {
    final accent = AppColors.accentTeal.themeColor;
    final dot = size ?? 28.w;
    return Wrap(
      spacing: spacing ?? 8.w,
      runSpacing: 8.h,
      children: [
        for (final (index, color) in colors.indexed)
          CustomTapEffect(
            onTap: () => onSelected(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: dot + 8.w,
              height: dot + 8.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: index == selected ? accent : Colors.transparent,
                  width: 2,
                ),
              ),
              child: Container(
                width: dot,
                height: dot,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  border:
                      Border.all(color: AppColors.studioPanelBorder.themeColor),
                ),
                child: index == selected
                    ? Icon(
                        Icons.check_rounded,
                        size: dot * 0.5,
                        color: color.computeLuminance() > 0.6
                            ? AppColors.textPrimaryColor.themeColor
                            : AppColors.white.light,
                      )
                    : null,
              ),
            ),
          ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/convert_helper.dart';

class StudioPalette extends StatelessWidget {
  const StudioPalette({
    super.key,
    required this.colors,
    required this.selected,
    required this.onSelected,
  });

  final List<String> colors;
  final String selected;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 9.w,
      runSpacing: 9.w,
      children: [
        for (final hex in colors)
          GestureDetector(
            onTap: () => onSelected(hex),
            child: Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: hex.toLowerCase() == selected.toLowerCase()
                      ? AppColors.studioPaletteRing.themeColor
                      : Colors.transparent,
                  width: 2,
                ),
              ),
              child: Container(
                width: 34.w,
                height: 34.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: ConvertHelper.hexToColor(hex),
                  shape: BoxShape.circle,
                ),
                child: hex.toLowerCase() == selected.toLowerCase()
                    ? Icon(Icons.check_rounded,
                        size: 16.sp, color: AppColors.white.light)
                    : null,
              ),
            ),
          ),
      ],
    );
  }
}

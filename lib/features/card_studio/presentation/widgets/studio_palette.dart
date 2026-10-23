import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/convert_helper.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_color_picker_dialog.dart';

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

  bool get _isCustom =>
      !colors.any((hex) => hex.toLowerCase() == selected.toLowerCase());

  Future<void> _pickCustom(BuildContext context) async {
    final color = await AppColorPickerDialog.show(
      context,
      initial: ConvertHelper.hexToColor(selected),
    );
    if (color != null) onSelected(ConvertHelper.colorToHex(color));
  }

  @override
  Widget build(BuildContext context) {
    final custom = _isCustom;
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
        GestureDetector(
          onTap: () => _pickCustom(context),
          child: Tooltip(
            message: LocaleKeys.cardStudio_customColor.tr(),
            child: Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: custom
                      ? AppColors.studioPaletteRing.themeColor
                      : Colors.transparent,
                  width: 2,
                ),
              ),
              child: Container(
                width: 34.w,
                height: 34.w,
                padding: EdgeInsets.all(custom ? 4.w : 0),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: SweepGradient(
                    colors: AppColorPickerDialog.hueStops,
                  ),
                ),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: custom
                        ? ConvertHelper.hexToColor(selected)
                        : Colors.transparent,
                  ),
                  child: Icon(
                    custom ? Icons.check_rounded : Icons.add_rounded,
                    size: 16.sp,
                    color: AppColors.white.light,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/app_options_sheet.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/custom_tap_effect.dart';


class StudioSelectField<T> extends StatelessWidget {
  const StudioSelectField({
    super.key,
    required this.label,
    required this.value,
    required this.options,
    required this.labelOf,
    required this.onChanged,
    this.labelColor,
  });

  final String label;
  final T value;
  final List<T> options;
  final String Function(T option) labelOf;
  final ValueChanged<T> onChanged;
  final Color? labelColor;

  T get _current => options.contains(value) ? value : options.first;

  Future<void> _open(BuildContext context) async {
    final selected = await AppOptionsSheet.show<T>(
      context,
      title: label,
      value: _current,
      options: options,
      labelOf: labelOf,
    );
    if (selected != null && selected != value) onChanged(selected);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppText(
          label,
          fontSize: 10.sp,
          color: labelColor ?? AppColors.studioDetailsLabel.themeColor,
        ),
        SizedBox(height: 8.h),
        CustomTapEffect(
          onTap: options.isEmpty ? null : () => _open(context),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: AppColors.studioSelectFill.themeColor,
              borderRadius: BorderRadius.circular(9.r),
              border:
                  Border.all(color: AppColors.assistantBackBorder.themeColor),
            ),
            child: Row(
              children: [
                Expanded(
                  child: AppText(
                    options.isEmpty ? '' : labelOf(_current),
                    fontSize: 11.sp,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Icon(Icons.keyboard_arrow_down_rounded,
                    size: 18.sp,
                    color: AppColors.studioDetailsLabel.themeColor),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

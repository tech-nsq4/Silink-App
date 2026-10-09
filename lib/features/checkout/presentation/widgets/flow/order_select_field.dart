import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/widgets/app_options_sheet.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../core/widgets/custom_tap_effect.dart';

class OrderSelectField<T> extends StatelessWidget {
  const OrderSelectField({
    super.key,
    required this.label,
    required this.hint,
    required this.value,
    required this.options,
    required this.labelOf,
    required this.onChanged,
    this.loading = false,
    this.onRetry,
  });

  final String label;
  final String hint;
  final T? value;
  final List<T> options;
  final String Function(T option) labelOf;
  final ValueChanged<T> onChanged;
  final bool loading;
  final VoidCallback? onRetry;

  Future<void> _open(BuildContext context) async {
    if (options.isEmpty) {
      onRetry?.call();
      return;
    }
    final selected = await AppOptionsSheet.show<T>(
      context,
      title: label,
      value: value ?? options.first,
      options: options,
      labelOf: labelOf,
    );
    if (selected != null) onChanged(selected);
  }

  @override
  Widget build(BuildContext context) {
    final current = value;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppText('$label *', fontSize: 10.5.sp, fontWeight: FontWeight.w700),
        SizedBox(height: 8.h),
        CustomTapEffect(
          onTap: loading ? null : () => _open(context),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 15.h),
            decoration: BoxDecoration(
              color: AppColors.white.themeColor,
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(color: AppColors.studioPanelBorder.themeColor),
            ),
            child: Row(
              children: [
                Expanded(
                  child: AppText(
                    current == null ? hint : labelOf(current),
                    fontSize: 11.sp,
                    color:
                        current == null ? AppColors.fieldHint.themeColor : null,
                  ),
                ),
                Icon(
                  loading
                      ? Icons.more_horiz_rounded
                      : Icons.keyboard_arrow_down_rounded,
                  size: 20.sp,
                  color: AppColors.textSecondaryColor.themeColor,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

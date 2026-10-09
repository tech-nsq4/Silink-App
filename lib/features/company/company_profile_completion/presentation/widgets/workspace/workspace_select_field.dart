import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/widgets/app_options_sheet.dart';
import '../../../../../../core/widgets/app_text.dart';
import '../../../../../../core/widgets/custom_tap_effect.dart';
import 'workspace_field_label.dart';

class WorkspaceSelectField<T> extends StatelessWidget {
  const WorkspaceSelectField({
    super.key,
    required this.label,
    required this.hint,
    required this.value,
    required this.options,
    required this.labelOf,
    required this.onChanged,
    this.required = false,
    this.loading = false,
  });

  final String label;
  final String hint;
  final T? value;
  final List<T> options;
  final String Function(T option) labelOf;
  final ValueChanged<T> onChanged;
  final bool required;
  final bool loading;

  Future<void> _open(BuildContext context) async {
    final selected = await AppOptionsSheet.show<T>(
      context,
      title: label,
      value: value ?? options.first,
      options: options,
      labelOf: labelOf,
    );
    if (selected != null && selected != value) onChanged(selected);
  }

  @override
  Widget build(BuildContext context) {
    final current = value;
    final hasValue = current != null && options.contains(current);
    return Padding(
      padding: EdgeInsets.only(bottom: 18.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          WorkspaceFieldLabel(text: label, required: required),
          CustomTapEffect(
            onTap: options.isEmpty || loading ? null : () => _open(context),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 15.h),
              decoration: BoxDecoration(
                color: AppColors.white.themeColor,
                borderRadius: BorderRadius.circular(14.r),
                border:
                    Border.all(color: AppColors.studioPanelBorder.themeColor),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: AppText(
                      hasValue ? labelOf(current) : hint,
                      fontSize: 12.sp,
                      fontWeight: hasValue ? FontWeight.w700 : FontWeight.w500,
                      color: hasValue ? null : AppColors.fieldHint.themeColor,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
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
      ),
    );
  }
}

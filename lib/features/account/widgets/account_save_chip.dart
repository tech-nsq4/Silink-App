import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/extensions/extensions.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/custom_loading_widget.dart';

class AccountSaveChip extends StatelessWidget {
  const AccountSaveChip({
    super.key,
    required this.label,
    required this.loading,
    required this.onTap,
  });

  final String label;
  final bool loading;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = AppColors.successColor.themeColor;
    return InkWell(
      onTap: loading ? null : onTap,
      borderRadius: BorderRadius.circular(22.r),
      child: Container(
        padding: 16.paddingHorizontal + 4.paddingVert,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(22.r),
        ),
        child: loading
            ? SizedBox(
                width: 20.w,
                height: 20.w,
                child: CustomLoadingWidget(color: color, size: 18),
              )
            : AppText(
                label,
                color: color,
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
              ),
      ),
    );
  }
}

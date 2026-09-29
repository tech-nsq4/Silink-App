import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/locale_keys.dart';
import '../../../core/widgets/app_text.dart';

class ViewAllProductsButton extends StatelessWidget {
  const ViewAllProductsButton({
    super.key,
    required this.count,
    required this.onTap,
  });

  final int count;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      options: RoundedRectDottedBorderOptions(
        dashPattern: const [8, 5],
        strokeWidth: 1.4,
        radius: Radius.circular(16.r),
        color: AppColors.borderColor.themeColor.withValues(alpha: 0.3),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: SizedBox(
          height: 48.h,
          width: double.infinity,
          child: Center(
            child: AppText(
              LocaleKeys.store_view_all_count
                  .tr(namedArgs: {'count': '$count'}),
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimaryColor.themeColor,
            ),
          ),
        ),
      ),
    );
  }
}

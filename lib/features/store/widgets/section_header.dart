import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/locale_keys.dart';
import '../../../core/widgets/app_text.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key, required this.title, this.onViewAll});

  final String title;
  final VoidCallback? onViewAll;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText(
          title,
          fontSize: 14.sp,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimaryColor.themeColor,
        ),
        if (onViewAll != null)
          InkWell(
            onTap: onViewAll,
            child: AppText(
              LocaleKeys.store_view_all.tr(),
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.mint.themeColor,
            ),
          ),
      ],
    );
  }
}

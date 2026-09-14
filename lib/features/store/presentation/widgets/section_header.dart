import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/app_text.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onViewAll;

  const SectionHeader({super.key, required this.title, this.onViewAll});

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
        InkWell(
          onTap: onViewAll ?? () {},
          child: AppText(
            'عرض الكل',
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.mint.themeColor,
          ),
        ),
      ],
    );
  }
}

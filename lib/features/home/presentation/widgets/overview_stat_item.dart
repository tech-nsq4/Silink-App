import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/app_text.dart';

class OverviewStatItem extends StatelessWidget {
  final String value;
  final String labelKey;

  const OverviewStatItem({
    super.key,
    required this.value,
    required this.labelKey,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppText(
          value,
          fontSize: 18.sp,
          fontWeight: FontWeight.w700,
        ),
        4.height,
        AppText(
          labelKey.tr(),
          fontSize: 11.2.sp,
          color: AppColors.textSecondaryColor.themeColor,
        ),
      ],
    );
  }
}

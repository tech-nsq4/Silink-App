import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';

class OverviewStatDivider extends StatelessWidget {
  const OverviewStatDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: VerticalDivider(
        width: 1.5.w,
        color: AppColors.borderColor.themeColor,
      ),
    );
  }
}

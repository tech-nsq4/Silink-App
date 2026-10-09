import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/extensions/extensions.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/widgets/app_text.dart';

class WorkspaceBenefits extends StatelessWidget {
  const WorkspaceBenefits({super.key, required this.items});

  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 22.h),
      child: Column(
        children: [
          for (final item in items)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: Row(
                children: [
                  Icon(Icons.check_rounded,
                      size: 15.sp, color: AppColors.accentTeal.themeColor),
                  10.width,
                  Expanded(
                    child: AppText(
                      item,
                      fontSize: 10.sp,
                      color: AppColors.textSecondaryColor.themeColor,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

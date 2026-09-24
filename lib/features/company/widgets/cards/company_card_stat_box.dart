import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/widgets/app_text.dart';

class CompanyCardStatBox extends StatelessWidget {
  const CompanyCardStatBox({
    super.key,
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final int value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 4.w),
        decoration: BoxDecoration(
          color: AppColors.cardColor.themeColor,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.borderColor.themeColor),
        ),
        child: Column(
          children: [
            AppText(
              '$value',
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: color,
            ),
            2.height,
            AppText(
              label,
              fontSize: 9.5.sp,
              color: AppColors.textSecondaryColor.themeColor,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/widgets/app_text.dart';

class WorkspaceReviewEmpty extends StatelessWidget {
  const WorkspaceReviewEmpty({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 12.w),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.studioFieldFill.themeColor,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: AppText(
        text,
        fontSize: 10.sp,
        color: AppColors.studioFieldHint.themeColor,
        textAlign: TextAlign.center,
      ),
    );
  }
}

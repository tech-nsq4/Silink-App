import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../extensions/extensions.dart';
import '../utils/app_colors.dart';
import 'app_text.dart';

class CreationToolbar extends StatelessWidget {
  const CreationToolbar({
    super.key,
    required this.hint,
    required this.actionLabel,
    required this.onAction,
  });

  final String hint;
  final String actionLabel;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) {
    final textColor = AppColors.assistantToolbarText.themeColor;
    final buttonColor = AppColors.assistantToolbarButtonText.themeColor;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 11.h),
      decoration: BoxDecoration(
        color: AppColors.assistantToolbar.themeColor,
        border: Border(
          bottom:
              BorderSide(color: AppColors.assistantToolbarBorder.themeColor),
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.check_rounded, size: 13.sp, color: textColor),
          5.width,
          Expanded(child: AppText(hint, fontSize: 8.sp, color: textColor)),
          GestureDetector(
            onTap: onAction,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: AppColors.white.themeColor,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                    color: AppColors.assistantToolbarButtonBorder.themeColor),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.edit_outlined, size: 13.sp, color: buttonColor),
                  5.width,
                  AppText(actionLabel, fontSize: 8.sp, color: buttonColor),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';
import 'app_text.dart';
import 'gradient_action_button.dart';

class CreationFooter extends StatelessWidget {
  const CreationFooter({
    super.key,
    required this.title,
    required this.note,
    required this.onTap,
    this.icon = Icons.arrow_forward_rounded,
    this.enabled = true,
  });

  final String title;
  final String note;
  final VoidCallback onTap;
  final IconData icon;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        22.w,
        14.h,
        22.w,
        18.h + MediaQuery.paddingOf(context).bottom,
      ),
      decoration: BoxDecoration(
        color: AppColors.white.themeColor,
        border: Border(
          top: BorderSide(color: AppColors.assistantLine.themeColor),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GradientActionButton(
            title: title,
            icon: icon,
            onTap: onTap,
            enabled: enabled,
            minHeight: 46,
          ),
          SizedBox(height: 9.h),
          AppText(
            note,
            fontSize: 8.sp,
            height: 1.7,
            textAlign: TextAlign.center,
            color: AppColors.assistantFooterNote.themeColor,
          ),
        ],
      ),
    );
  }
}

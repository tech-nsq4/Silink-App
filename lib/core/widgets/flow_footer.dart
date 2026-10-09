import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';
import 'app_text.dart';
import 'gradient_action_button.dart';

class FlowFooter extends StatelessWidget {
  const FlowFooter({
    super.key,
    required this.title,
    required this.onTap,
    this.note,
    this.loading = false,
    this.loadingTitle,
    this.error,
  });

  final String title;
  final VoidCallback onTap;
  final String? note;
  final bool loading;
  final String? loadingTitle;
  final String? error;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        22.w,
        15.h,
        22.w,
        19.h + MediaQuery.paddingOf(context).bottom,
      ),
      decoration: BoxDecoration(
        color: AppColors.white.themeColor,
        border: Border(
          top: BorderSide(color: AppColors.footerBorder.themeColor),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GradientActionButton(
            title: title,
            onTap: onTap,
            loading: loading,
            loadingTitle: loadingTitle,
            radius: 13,
            fontSize: 13,
            minHeight: 49,
            elevated: true,
          ),
          if (error != null) ...[
            SizedBox(height: 8.h),
            AppText(
              error!,
              fontSize: 10.sp,
              color: AppColors.studioError.themeColor,
            ),
          ],
          if (note != null) ...[
            SizedBox(height: 8.h),
            AppText(
              note!,
              fontSize: 9.sp,
              textAlign: TextAlign.center,
              color: AppColors.footerNote.themeColor,
            ),
          ],
        ],
      ),
    );
  }
}

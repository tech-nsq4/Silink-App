import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../extensions/extensions.dart';
import '../utils/app_colors.dart';
import 'app_text.dart';

class CreationHeader extends StatelessWidget {
  const CreationHeader({
    super.key,
    required this.eyebrow,
    required this.title,
    this.badge,
    required this.compact,
    this.onBack,
  });

  final String eyebrow;
  final String title;
  final String? badge;
  final bool compact;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        compact ? 19.w : 22.w,
        MediaQuery.paddingOf(context).top + (compact ? 13.h : 19.h),
        compact ? 19.w : 22.w,
        compact ? 13.h : 19.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.white.themeColor,
        border: Border(
          bottom: BorderSide(color: AppColors.assistantLine.themeColor),
        ),
      ),
      child: Row(
        children: [
          Opacity(
            opacity: onBack == null ? 0.4 : 1,
            child: InkWell(
              onTap: onBack,
              customBorder: const CircleBorder(),
              child: Container(
                width: 33.w,
                height: 33.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.white.themeColor,
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: AppColors.assistantBackBorder.themeColor),
                ),
                child: Icon(
                  Icons.arrow_back_rounded,
                  size: 18.sp,
                  color: AppColors.assistantBackIcon.themeColor,
                ),
              ),
            ),
          ),
          12.width,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                AppText(
                  eyebrow,
                  fontSize: 8.sp,
                  color: AppColors.assistantHeaderSmall.themeColor,
                ),
                SizedBox(height: 5.h),
                AppText(title, fontSize: 13.sp, fontWeight: FontWeight.w800),
              ],
            ),
          ),
          if (badge != null)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
              decoration: BoxDecoration(
                color: AppColors.assistantPill.themeColor,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: AppText(
                badge!,
                fontSize: 8.sp,
                color: AppColors.assistantPillText.themeColor,
              ),
            ),
        ],
      ),
    );
  }
}

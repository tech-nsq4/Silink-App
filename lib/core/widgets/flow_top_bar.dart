import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';
import 'app_text.dart';

class FlowTopBar extends StatelessWidget {
  const FlowTopBar({
    super.key,
    required this.title,
    this.eyebrow,
    this.onBack,
    this.action,
    this.showBack = true,
  });

  final String title;
  final String? eyebrow;
  final VoidCallback? onBack;
  final Widget? action;
  final bool showBack;

  @override
  Widget build(BuildContext context) {
    final sideSize = 35.w;
    return Container(
      color: AppColors.backgroundColor.themeColor,
      padding: EdgeInsets.fromLTRB(22.w, 8.h, 22.w, 12.h),
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: 45.h),
        child: Row(
          children: [
            if (!showBack)
              SizedBox(width: sideSize)
            else
              InkWell(
                onTap: onBack ?? () => Navigator.of(context).maybePop(),
                customBorder: const CircleBorder(),
                child: Container(
                  width: sideSize,
                  height: sideSize,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.white.themeColor,
                    shape: BoxShape.circle,
                    border:
                        Border.all(color: AppColors.topIconBorder.themeColor),
                  ),
                  child: Icon(
                    Icons.arrow_back_rounded,
                    size: 19.sp,
                    color: AppColors.topIconColor.themeColor,
                  ),
                ),
              ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (eyebrow != null) ...[
                    AppText(
                      eyebrow!,
                      fontSize: 9.sp,
                      color: AppColors.topEyebrow.themeColor,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 3.h),
                  ],
                  AppText(
                    title,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w800,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            SizedBox(width: 12.w),
            action ?? SizedBox(width: sideSize),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';
import 'app_text.dart';

class ScreenHeaderBar extends StatelessWidget {
  const ScreenHeaderBar({
    super.key,
    required this.title,
    this.onBack,
    this.trailing,
    this.showBack = true,
  });

  final String title;
  final VoidCallback? onBack;
  final Widget? trailing;
  final bool showBack;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        height: 50.h,
        padding: EdgeInsetsDirectional.only(
          start: 19.w,
          end: 19.w,
          bottom: 12.h,

        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppColors.borderColor.themeColor,
            ),
          ),
        ),
        child: NavigationToolbar(
          centerMiddle: true,
          middleSpacing: 12.w,
          leading: showBack
              ? InkWell(
                  onTap: onBack ?? () => Navigator.of(context).maybePop(),
                  borderRadius: BorderRadius.circular(20.r),
                  child: Icon(
                    Icons.chevron_left,
                    size: 24.sp,
                    color: AppColors.textPrimaryColor.themeColor,
                  ),
                )
              : null,
          middle: AppText(
            title,
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: trailing,
        ),
      ),
    );
  }
}

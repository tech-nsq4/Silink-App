import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../extensions/extensions.dart';
import '../utils/app_colors.dart';
import 'app_text.dart';

class ScreenHeaderBar extends StatelessWidget {
  const ScreenHeaderBar({
    super.key,
    required this.title,
    this.onBack,
    this.trailing,
  });

  final String title;
  final VoidCallback? onBack;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      padding: 19.paddingHorizontal,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.borderColor.themeColor,
          ),
        ),
      ),
      child: Stack(
        children: [
          if (trailing != null)
            PositionedDirectional(
              end: 0,
              top: 0,
              bottom: 0,
              child: Transform.translate(
                offset: Offset(0, 6.h),
                child: trailing!,
              ),
            ),
          Positioned.fill(
            child: Transform.translate(
              offset: Offset(0, 6.h),
              child: Center(
                child: AppText(
                  title,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          PositionedDirectional(
            start: 0,
            top: 0,
            bottom: 0,
            child: Transform.translate(
              offset: Offset(0, 6.h),
              child: Center(
                child: InkWell(
                  onTap: onBack ?? () => Navigator.of(context).maybePop(),
                  borderRadius: BorderRadius.circular(20.r),
                  child: Icon(
                    Icons.chevron_left,
                    size: 24.sp,
                    color: AppColors.textPrimaryColor.themeColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

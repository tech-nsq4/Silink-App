import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileCardSectionTitle extends StatelessWidget {
  const ProfileCardSectionTitle({
    super.key,
    required this.title,
    required this.fontFamily,
    this.actionLabel,
    this.actionColor,
    this.onAction,
  });

  final String title;
  final String? fontFamily;
  final String? actionLabel;
  final Color? actionColor;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AppText(
            title,
            fontSize: 16.sp,
            fontWeight: FontWeight.w800,
            fontFamily: fontFamily,
          ),
        ),
        if (actionLabel != null && onAction != null)
          InkWell(
            onTap: onAction,
            borderRadius: BorderRadius.circular(8.r),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
              child: AppText(
                actionLabel!,
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
                color: actionColor ?? AppColors.mint.themeColor,
                fontFamily: fontFamily,
              ),
            ),
          ),
      ],
    );
  }
}

import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileCardExitPreviewButton extends StatelessWidget {
  const ProfileCardExitPreviewButton({super.key, required this.onExit});

  final VoidCallback onExit;

  @override
  Widget build(BuildContext context) {
    final white = AppColors.white.themeColor;

    return InkWell(
      onTap: onExit,
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
        decoration: BoxDecoration(
          color: AppColors.black.themeColor.withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.close_rounded, size: 15.sp, color: white),
            6.width,
            AppText(
              LocaleKeys.publish_exitPreview.tr(),
              fontSize: 12.sp,
              fontWeight: FontWeight.w700,
              color: white,
            ),
          ],
        ),
      ),
    );
  }
}

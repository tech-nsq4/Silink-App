import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_overlay.dart';
import '../../../core/utils/locale_keys.dart';
import '../../../core/widgets/app_text.dart';

class LinkCopyPill extends StatelessWidget {
  final String fullLink;

  const LinkCopyPill({super.key, required this.fullLink});

  void _copy(BuildContext context) {
    Clipboard.setData(ClipboardData(text: fullLink));
    AppOverlay.showSuccess(LocaleKeys.publish_linkCopied.tr());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: AppColors.white.themeColor,
        borderRadius: BorderRadius.circular(32.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: AppText(
              fullLink,
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.mint.themeColor,
            ),
          ),
          InkWell(
            onTap: () => _copy(context),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: AppColors.mint.themeColor,
                borderRadius: BorderRadius.circular(32.r),
              ),
              child: AppText(
                LocaleKeys.publish_copy.tr(),
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.white.themeColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

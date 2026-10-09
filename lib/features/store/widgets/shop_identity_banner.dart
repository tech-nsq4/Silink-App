import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/extensions/extensions.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/locale_keys.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/custom_tap_effect.dart';

class ShopIdentityBanner extends StatelessWidget {
  const ShopIdentityBanner({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final accent = AppColors.accentTeal.themeColor;
    return CustomTapEffect(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
        decoration: BoxDecoration(
          color: accent.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: accent.withValues(alpha: 0.2)),
        ),
        child: Row(
          children: [
            Icon(Icons.contactless_outlined, size: 22.sp, color: accent),
            12.width,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    LocaleKeys.shop_identityTitle.tr(),
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w800,
                    color: accent,
                  ),
                  SizedBox(height: 5.h),
                  AppText(
                    LocaleKeys.shop_identitySubtitle.tr(),
                    fontSize: 8.5.sp,
                    color: AppColors.textSecondaryColor.themeColor,
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_left_rounded,
                size: 20.sp, color: AppColors.textPrimaryColor.themeColor),
          ],
        ),
      ),
    );
  }
}

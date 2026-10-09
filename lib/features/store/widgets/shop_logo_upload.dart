import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/extensions/extensions.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/locale_keys.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/custom_tap_effect.dart';

class ShopLogoUpload extends StatelessWidget {
  const ShopLogoUpload({
    super.key,
    required this.logo,
    required this.onPick,
    required this.onRemove,
  });

  final File? logo;
  final VoidCallback onPick;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final success = AppColors.successColor.themeColor;
    final secondary = AppColors.textSecondaryColor.themeColor;
    final file = logo;
    if (file != null) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: success.withValues(alpha: 0.07),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: success.withValues(alpha: 0.35)),
        ),
        child: Row(
          children: [
            Container(
              width: 34.w,
              height: 34.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: success.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(Icons.check_rounded, size: 17.sp, color: success),
            ),
            12.width,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    LocaleKeys.shop_logoDone.tr(),
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w800,
                    color: success,
                  ),
                  SizedBox(height: 3.h),
                  AppText(
                    file.path.split('/').last,
                    fontSize: 8.sp,
                    color: success,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: onRemove,
              icon: Icon(Icons.close_rounded, size: 18.sp, color: secondary),
            ),
          ],
        ),
      );
    }
    return CustomTapEffect(
      onTap: onPick,
      child: DottedBorder(
        options: RoundedRectDottedBorderOptions(
          radius: Radius.circular(14.r),
          color: AppColors.accentTeal.themeColor.withValues(alpha: 0.5),
          dashPattern: const [6, 4],
          strokeWidth: 1.2,
        ),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 22.h),
          child: Column(
            children: [
              Icon(Icons.photo_camera_outlined, size: 20.sp, color: secondary),
              SizedBox(height: 8.h),
              AppText(
                LocaleKeys.shop_logoUpload.tr(),
                fontSize: 9.5.sp,
                fontWeight: FontWeight.w700,
                color: secondary,
              ),
              SizedBox(height: 4.h),
              AppText(LocaleKeys.shop_logoHint.tr(),
                  fontSize: 7.5.sp, color: secondary),
            ],
          ),
        ),
      ),
    );
  }
}

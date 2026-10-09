import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/image/custom_image.dart';

class StudioIdentityHead extends StatelessWidget {
  const StudioIdentityHead({
    super.key,
    required this.name,
    required this.onTap,
    this.photoFile,
    this.photoUrl,
  });

  final String name;
  final File? photoFile;
  final String? photoUrl;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final accent = AppColors.accentTeal.themeColor;
    final letter = name.trim().isEmpty ? '' : name.trim().substring(0, 1);
    final url = photoUrl?.trim() ?? '';
    final hasPhoto = photoFile != null || url.isNotEmpty;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        margin: EdgeInsets.only(bottom: 20.h),
        padding: EdgeInsets.all(15.w),
        decoration: BoxDecoration(
          color: AppColors.white.themeColor,
          borderRadius: BorderRadius.circular(13.r),
          border: Border.all(color: AppColors.studioIdentityBorder.themeColor),
        ),
        child: Row(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 48.w,
                  height: 48.w,
                  alignment: Alignment.center,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: AppColors.studioIdentityAvatar.themeColor,
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: photoFile != null
                      ? Image.file(photoFile!,
                          width: 48.w, height: 48.w, fit: BoxFit.cover)
                      : url.isNotEmpty
                          ? CustomImage(
                              image: url,
                              width: 48.w,
                              height: 48.w,
                              fit: BoxFit.cover,
                            )
                          : letter.isEmpty
                              ? Icon(Icons.group_outlined,
                                  size: 24.sp, color: accent)
                              : AppText(
                                  letter,
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.w800,
                                  color: accent,
                                ),
                ),
                PositionedDirectional(
                  bottom: -4.h,
                  end: -4.w,
                  child: Container(
                    width: 20.w,
                    height: 20.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: accent,
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: AppColors.white.themeColor, width: 1.5),
                    ),
                    child: Icon(Icons.photo_camera_outlined,
                        size: 11.sp, color: AppColors.white.light),
                  ),
                ),
              ],
            ),
            14.width,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    LocaleKeys.cardStudio_photoTitle.tr(),
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w700,
                  ),
                  SizedBox(height: 5.h),
                  AppText(
                    hasPhoto
                        ? LocaleKeys.cardStudio_photoChange.tr()
                        : LocaleKeys.cardStudio_photoHint.tr(),
                    fontSize: 9.sp,
                    color: AppColors.studioIdentityHint.themeColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

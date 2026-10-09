import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/widgets/app_text.dart';
import '../../../../../../core/widgets/custom_tap_effect.dart';
import '../../../../../../core/widgets/image/custom_image.dart';

class WorkspaceLogoCard extends StatelessWidget {
  const WorkspaceLogoCard({
    super.key,
    required this.title,
    required this.hint,
    required this.onTap,
    this.logoUrl,
    this.logoFile,
  });

  final String title;
  final String hint;
  final VoidCallback onTap;
  final String? logoUrl;
  final File? logoFile;

  @override
  Widget build(BuildContext context) {
    final accent = AppColors.accentTeal.themeColor;
    final url = logoUrl?.trim() ?? '';
    final size = 52.w;
    return CustomTapEffect(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 26.h),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        decoration: BoxDecoration(
          color: AppColors.white.themeColor,
          borderRadius: BorderRadius.circular(22.r),
          border: Border.all(color: AppColors.studioPanelBorder.themeColor),
        ),
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: size,
                  height: size,
                  alignment: Alignment.center,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: logoFile != null
                      ? Image.file(logoFile!,
                          width: size, height: size, fit: BoxFit.cover)
                      : url.isNotEmpty
                          ? CustomImage(
                              image: url,
                              width: size,
                              height: size,
                              fit: BoxFit.cover,
                            )
                          : Icon(Icons.apartment_rounded,
                              size: 24.sp, color: accent),
                ),
                PositionedDirectional(
                  end: -6.w,
                  bottom: -6.w,
                  child: Container(
                    width: 20.w,
                    height: 20.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: accent,
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: AppColors.white.themeColor, width: 2),
                    ),
                    child: Icon(Icons.camera_alt_rounded,
                        size: 10.sp, color: AppColors.white.light),
                  ),
                ),
              ],
            ),
            SizedBox(height: 14.h),
            AppText(
              title,
              fontSize: 15.sp,
              fontWeight: FontWeight.w800,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 6.h),
            AppText(
              hint,
              fontSize: 9.sp,
              textAlign: TextAlign.center,
              color: AppColors.textSecondaryColor.themeColor,
            ),
          ],
        ),
      ),
    );
  }
}

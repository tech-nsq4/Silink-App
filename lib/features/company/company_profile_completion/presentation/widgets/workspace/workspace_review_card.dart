import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/extensions/extensions.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/widgets/app_text.dart';
import '../../../../../../core/widgets/image/custom_image.dart';

class WorkspaceReviewCard extends StatelessWidget {
  const WorkspaceReviewCard({
    super.key,
    required this.eyebrow,
    required this.name,
    required this.about,
    required this.meta,
    this.logoUrl,
    this.logoFile,
  });

  final String eyebrow;
  final String name;
  final String about;
  final String meta;
  final String? logoUrl;
  final File? logoFile;

  @override
  Widget build(BuildContext context) {
    final white = AppColors.white.light;
    final soft = white.withValues(alpha: 0.6);
    final url = logoUrl?.trim() ?? '';
    final size = 52.w;
    return Container(
      padding: EdgeInsets.fromLTRB(22.w, 26.h, 22.w, 20.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.studioCardStart.themeColor,
            AppColors.studioCardEnd.themeColor,
          ],
        ),
      ),
      child: Column(
        children: [
          Container(
            width: size,
            height: size,
            alignment: Alignment.center,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: white.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: white.withValues(alpha: 0.14)),
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
                        size: 24.sp, color: AppColors.mint.themeColor),
          ),
          SizedBox(height: 16.h),
          AppText(eyebrow, fontSize: 8.5.sp, color: soft),
          SizedBox(height: 10.h),
          AppText(
            name,
            fontSize: 22.sp,
            fontWeight: FontWeight.w800,
            color: white,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          if (about.trim().isNotEmpty) ...[
            SizedBox(height: 8.h),
            AppText(
              about,
              fontSize: 9.5.sp,
              height: 1.6,
              color: white.withValues(alpha: 0.75),
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
          SizedBox(height: 18.h),
          Container(
            padding: EdgeInsets.only(top: 14.h),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: white.withValues(alpha: 0.1)),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.location_on_outlined, size: 12.sp, color: soft),
                5.width,
                Flexible(
                  child: AppText(
                    meta,
                    fontSize: 8.5.sp,
                    color: soft,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

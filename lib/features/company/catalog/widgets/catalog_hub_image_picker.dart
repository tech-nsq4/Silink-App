import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/custom_tap_effect.dart';
import '../../../../core/widgets/image/custom_image.dart';

class CatalogHubImagePicker extends StatelessWidget {
  const CatalogHubImagePicker({
    super.key,
    required this.label,
    required this.onTap,
    this.file,
    this.url,
  });

  final String label;
  final VoidCallback onTap;
  final File? file;
  final String? url;

  @override
  Widget build(BuildContext context) {
    final secondary = AppColors.textSecondaryColor.themeColor;
    final remote = url?.trim() ?? '';
    final hasImage = file != null || remote.isNotEmpty;
    return CustomTapEffect(
      onTap: onTap,
      child: DottedBorder(
        options: RoundedRectDottedBorderOptions(
          radius: Radius.circular(14.r),
          color: AppColors.studioStepLine.themeColor,
          dashPattern: const [5, 4],
        ),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: hasImage ? 10.h : 14.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (hasImage) ...[
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: file != null
                      ? Image.file(file!,
                          width: 40.w, height: 40.w, fit: BoxFit.cover)
                      : CustomImage(
                          image: remote,
                          width: 40.w,
                          height: 40.w,
                          fit: BoxFit.cover,
                        ),
                ),
                10.width,
              ] else ...[
                Icon(Icons.photo_camera_outlined,
                    size: 16.sp, color: secondary),
                6.width,
              ],
              AppText(label, fontSize: 9.5.sp, color: secondary),
            ],
          ),
        ),
      ),
    );
  }
}

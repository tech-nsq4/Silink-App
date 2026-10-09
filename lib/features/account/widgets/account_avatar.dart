import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/image/custom_image.dart';

class AccountAvatar extends StatelessWidget {
  const AccountAvatar({
    super.key,
    this.imageUrl,
    this.imageFile,
    this.initial = '',
    this.foregroundColor,
    this.onEditTap,
  });

  final String? imageUrl;
  final File? imageFile;
  final String initial;
  final Color? foregroundColor;
  final VoidCallback? onEditTap;

  @override
  Widget build(BuildContext context) {
    final url = imageUrl?.trim() ?? '';
    final label = initial.trim();
    final foreground = foregroundColor ?? AppColors.white.themeColor;
    final file = imageFile;

    final Widget content;
    if (file != null) {
      content = Image.file(file, width: 80.w, height: 80.w, fit: BoxFit.cover);
    } else if (url.isNotEmpty) {
      content = CustomImage(
        image: url,
        width: 80.w,
        height: 80.w,
        fit: BoxFit.cover,
      );
    } else if (label.isNotEmpty) {
      content = AppText(
        label,
        fontSize: 20.sp,
        fontWeight: FontWeight.w700,
        color: foreground,
      );
    } else {
      content = Icon(Icons.person_rounded, color: foreground);
    }

    return GestureDetector(
      onTap: onEditTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 80.w,
            height: 80.w,
            alignment: Alignment.center,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              gradient: LinearGradient(
                colors: [
                  AppColors.brandTeal.themeColor,
                  AppColors.blue.themeColor,
                ],
                begin: Alignment.topLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: content,
          ),
          if (onEditTap != null)
            PositionedDirectional(
              end: -6,
              bottom: -8,
              child: Container(
                width: 30.w,
                height: 30.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.mint.themeColor,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.white.themeColor,
                    width: 2,
                  ),
                ),
                child: Icon(
                  Icons.camera_alt_outlined,
                  size: 15.sp,
                  color: AppColors.white.themeColor,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

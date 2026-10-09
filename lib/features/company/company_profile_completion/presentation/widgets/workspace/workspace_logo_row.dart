import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/extensions/extensions.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/locale_keys.dart';
import '../../../../../../core/widgets/app_text.dart';
import '../../../../../../core/widgets/custom_tap_effect.dart';
import '../../../../../../core/widgets/image/custom_image.dart';

class WorkspaceLogoRow extends StatelessWidget {
  const WorkspaceLogoRow({
    super.key,
    required this.name,
    required this.onPick,
    this.logoUrl,
    this.logoFile,
  });

  final String name;
  final VoidCallback onPick;
  final String? logoUrl;
  final File? logoFile;

  String get _initials {
    final words = name.trim().split(RegExp(r'\s+')).where((w) => w.isNotEmpty);
    return words.take(2).map((w) => w.characters.first).join();
  }

  @override
  Widget build(BuildContext context) {
    final secondary = AppColors.textSecondaryColor.themeColor;
    final url = logoUrl?.trim() ?? '';
    final size = 60.w;
    return Padding(
      padding: EdgeInsets.only(bottom: 22.h),
      child: Row(
        children: [
          Container(
            width: size,
            height: size,
            alignment: Alignment.center,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: AppColors.accentTeal.themeColor,
              borderRadius: BorderRadius.circular(18.r),
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
                    : AppText(
                        _initials,
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w800,
                        color: AppColors.white.light,
                      ),
          ),
          14.width,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(LocaleKeys.companyHub_logoTitle.tr(),
                    fontSize: 11.sp, fontWeight: FontWeight.w800),
                SizedBox(height: 4.h),
                AppText(LocaleKeys.companyHub_logoHint.tr(),
                    fontSize: 8.5.sp, color: secondary),
                SizedBox(height: 10.h),
                CustomTapEffect(
                  onTap: onPick,
                  child: DottedBorder(
                    options: RoundedRectDottedBorderOptions(
                      radius: Radius.circular(12.r),
                      color: AppColors.studioStepLine.themeColor,
                      dashPattern: const [5, 4],
                    ),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.photo_camera_outlined,
                              size: 14.sp, color: secondary),
                          6.width,
                          AppText(LocaleKeys.companyHub_logoUpload.tr(),
                              fontSize: 9.sp, color: secondary),
                        ],
                      ),
                    ),
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

import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_text.dart';
import 'my_file_thumb.dart';

class MyFileImageField extends StatelessWidget {
  const MyFileImageField({
    super.key,
    required this.initials,
    required this.onPick,
    this.localFile,
    this.imageUrl,
  });

  final String initials;
  final VoidCallback onPick;
  final File? localFile;
  final String? imageUrl;

  bool get _hasImage =>
      localFile != null || (imageUrl?.trim().isNotEmpty ?? false);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (_hasImage) ...[
          MyFileThumb(
            initials: initials,
            localFile: localFile,
            imageUrl: imageUrl,
            width: 48.h,
            height: 48.h,
            radius: 12.r,
          ),
          10.width,
        ],
        Expanded(
          child: InkWell(
            onTap: onPick,
            borderRadius: BorderRadius.circular(999),
            child: Container(
              height: 48.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.fieldFill,
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: AppColors.dividerColor.themeColor),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.camera_alt_outlined,
                    size: 17.sp,
                    color: AppColors.textPrimaryColor.themeColor,
                  ),
                  8.width,
                  AppText(
                    _hasImage
                        ? LocaleKeys.myFiles_changeImage.tr()
                        : LocaleKeys.myFiles_addImage.tr(),
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

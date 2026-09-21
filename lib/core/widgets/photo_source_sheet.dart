import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class PhotoSourceSheet extends StatelessWidget {
  const PhotoSourceSheet({super.key});

  static Future<ImageSource?> show(BuildContext context) {
    return showModalBottomSheet<ImageSource>(
      context: context,
      backgroundColor: AppColors.cardColor.themeColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (_) => const PhotoSourceSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              onTap: () => Navigator.of(context).pop(ImageSource.camera),
              leading: Icon(
                Icons.camera_alt_outlined,
                color: AppColors.successColor.themeColor,
              ),
              title: AppText(
                LocaleKeys.profile_type_basic_info_photo_camera.tr(),
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            ListTile(
              onTap: () => Navigator.of(context).pop(ImageSource.gallery),
              leading: Icon(
                Icons.photo_library_outlined,
                color: AppColors.successColor.themeColor,
              ),
              title: AppText(
                LocaleKeys.profile_type_basic_info_photo_gallery.tr(),
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/app_images.dart';
import 'package:Silink/core/utils/app_overlay.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_button.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class CompanyImagePicker extends StatefulWidget {
  const CompanyImagePicker({
    super.key,
    required this.image,
    required this.onChanged,
    required this.companyName,
    required this.industry,
  });

  final File? image;
  final ValueChanged<File?> onChanged;
  final String companyName;
  final String industry;

  @override
  State<CompanyImagePicker> createState() => _CompanyImagePickerState();
}

class _CompanyImagePickerState extends State<CompanyImagePicker> {
  bool _picking = false;

  Future<ImageSource?> _showSourceSheet() {
    return showModalBottomSheet<ImageSource>(
      context: context,
      backgroundColor: AppColors.cardColor.themeColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (sheetContext) => Padding(
        padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 20.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppText(
              LocaleKeys.profile_type_basic_info_choose_photo.tr(),
              fontSize: 15.sp,
              fontWeight: FontWeight.w700,
            ),
            10.height,
            CustomButton(
              onTap: () => Navigator.of(sheetContext).pop(ImageSource.camera),
              title: LocaleKeys.profile_type_basic_info_photo_camera.tr(),
              color: AppColors.blue.themeColor,
              height: 44,
              radius: 12,
            ),
            8.height,
            CustomButton(
              onTap: () => Navigator.of(sheetContext).pop(ImageSource.gallery),
              title: LocaleKeys.profile_type_basic_info_photo_gallery.tr(),
              isOutlined: true,
              borderColor: AppColors.borderColor.themeColor,
              textColor: AppColors.textPrimaryColor.themeColor,
              height: 44,
              radius: 12,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    if (_picking) return;
    final source = await _showSourceSheet();
    if (source == null || !mounted) return;

    setState(() => _picking = true);
    try {
      final picked = await ImagePicker().pickImage(
        source: source,
        maxWidth: 1600,
        imageQuality: 85,
      );
      if (picked == null || !mounted) return;
      widget.onChanged(File(picked.path));
    } catch (_) {
      if (mounted) {
        AppOverlay.showError(
          LocaleKeys.profile_type_basic_info_photo_pick_error.tr(),
        );
      }
    } finally {
      if (mounted) setState(() => _picking = false);
    }
  }

  String get _initials {
    final words = widget.companyName
        .trim()
        .split(' ')
        .where((word) => word.trim().isNotEmpty)
        .take(2)
        .toList();
    if (words.isEmpty) return '';
    return words.map((word) => word.trim()[0]).join();
  }

  @override
  Widget build(BuildContext context) {
    final hasImage = widget.image != null;
    final name = widget.companyName.trim().isEmpty
        ? LocaleKeys.company_name_label.tr()
        : widget.companyName.trim();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 64.w,
              height: 64.w,
              clipBehavior: Clip.antiAlias,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.blue.themeColor,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: hasImage
                  ? Image.file(
                      widget.image!,
                      width: 64.w,
                      height: 64.w,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Center(
                        child: AppText(
                          _initials,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    )
                  : Center(
                      child: AppText(
                        _initials,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
            ),
            12.width,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    name,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                  ),
                  2.height,
                  AppText(
                    widget.industry,
                    fontSize: 12.sp,
                    color: AppColors.textSecondaryColor.themeColor,
                  ),
                  6.height,
                  _AttachmentArea(
                    onTap: _pickImage,
                  ),
                ],
              ),
            ),
            12.width,
          ],
        ),
        14.height,
        if (hasImage) ...[
          8.height,
          CustomButton(
            onTap: () => widget.onChanged(null),
            title: LocaleKeys.products_removeImage.tr(),
            isOutlined: true,
            borderColor: AppColors.borderColor.themeColor,
            textColor: AppColors.textPrimaryColor.themeColor,
            height: 42,
            radius: 12,
            fontSize: 12,
          ),
        ],
      ],
    );
  }
}

class _AttachmentArea extends StatelessWidget {
  const _AttachmentArea({ required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      options: RoundedRectDottedBorderOptions(
        radius: Radius.circular(14.r),
        color: AppColors.borderColor.themeColor,
        strokeWidth: 1.4,
        dashPattern: const [7, 5],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14.r),
          child: Container(
            height: 35.h,
            clipBehavior: Clip.antiAlias,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            decoration: BoxDecoration(
              color: AppColors.fieldFill,
              borderRadius: BorderRadius.circular(14.r),
            ),
            child:Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        AppImages.iconsMedia,
                        width: 18.w,
                        height: 18.h,
                        colorFilter: ColorFilter.mode(
                          AppColors.textSecondaryColor.themeColor,
                          BlendMode.srcIn,
                        ),
                      ),
                      8.width,
                      AppText(
                        LocaleKeys.company_image_label.tr(),
                        fontSize: 12.sp,
                        color: AppColors.textSecondaryColor.themeColor,
                      ),
                    ],
                  )
               
          ),
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/app_overlay.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/features/profile_completion/models/profile_completion_data.dart';
import 'package:Silink/features/profile_completion/presentation/widgets/photo_source_sheet.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/image/custom_image.dart';

class AccountAvatar extends StatefulWidget {
  const AccountAvatar({
    super.key,
    this.imageUrl,
    this.initial = '',
    this.foregroundColor,
    this.badge = false,
    // required this.data,
  });

  final String? imageUrl;
  final String initial;
  final Color? foregroundColor;
  final bool badge;
  //  final ProfileCompletionData data;

  @override
  State<AccountAvatar> createState() => _AccountAvatarState();
}

class _AccountAvatarState extends State<AccountAvatar> {
  late ProfileCompletionData data;
  @override
  Widget build(BuildContext context) {
    final url = widget.imageUrl?.trim() ?? '';
    final label = widget.initial.trim();
    final foreground = widget.foregroundColor ?? Colors.white;

    return InkWell(
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
                colors: [Color(0xff2C9092), Color(0xff2368E2)],
                begin: Alignment.topLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: url.isNotEmpty
                ? CustomImage(
                    image: url,
                    width: 28.w,
                    height: 28.h,
                    fit: BoxFit.cover,
                  )
                : label.isNotEmpty
                    ? AppText(
                        label,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                        color: foreground,
                      )
                    : Icon(
                        Icons.person_rounded,
                        color: foreground,
                      ),
          ),
          if (widget.badge)
            PositionedDirectional(
              end: -6,
              bottom: -8,
              child: InkWell(
                onTap: _pickPhoto,
                child: Container(
                  width: 30.w,
                  height: 30.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.mint.themeColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.camera_alt_outlined,
                    size: 15.sp,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _pickPhoto() async {
    final source = await PhotoSourceSheet.show(context);
    if (source == null || !mounted) return;

    try {
      final picked = await ImagePicker().pickImage(
        source: source,
        maxWidth: 1024,
        imageQuality: 85,
      );
      if (picked == null || !mounted) return;
      setState(() => data.photo = File(picked.path));
    } catch (_) {
      if (!mounted) return;
      AppOverlay.showError(
        LocaleKeys.profile_type_basic_info_photo_pick_error.tr(),
      );
    }
  }
}

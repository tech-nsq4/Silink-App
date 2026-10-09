import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../extensions/extensions.dart';
import '../../utils/app_colors.dart';
import '../../utils/locale_keys.dart';
import '../app_text.dart';
import 'public_profile_data.dart';

class PublicProfileStickyBar extends StatelessWidget {
  const PublicProfileStickyBar({
    super.key,
    required this.data,
    required this.onMainContact,
    required this.onSaveContact,
  });

  final PublicProfileData data;
  final VoidCallback onMainContact;
  final VoidCallback onSaveContact;

  @override
  Widget build(BuildContext context) {
    final white = AppColors.white.light;
    final hasWhatsapp = data.whatsapp != null;
    final hasDirect =
        data.phone.trim().isNotEmpty || data.email.trim().isNotEmpty;
    final label = hasWhatsapp
        ? LocaleKeys.publicProfile_contactWhatsapp.tr()
        : hasDirect
            ? LocaleKeys.publicProfile_contactMe.tr()
            : LocaleKeys.publicProfile_shareData.tr();
    return Container(
      padding: EdgeInsets.fromLTRB(22.w, 13.h, 22.w, 17.h),
      decoration: BoxDecoration(
        color: AppColors.white.themeColor,
        border: Border(
          top: BorderSide(color: AppColors.profileStickyBorder.themeColor),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: onMainContact,
              child: Container(
                constraints: BoxConstraints(minHeight: 47.h),
                padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 14.h),
                decoration: BoxDecoration(
                  color: data.accent,
                  borderRadius: BorderRadius.circular(data.buttonRadius.r),
                ),
                child: Row(
                  children: [
                    Icon(
                      hasWhatsapp
                          ? Icons.chat_bubble_outline_rounded
                          : Icons.phone_outlined,
                      size: 17.sp,
                      color: white,
                    ),
                    10.width,
                    Expanded(
                      child: AppText(
                        label,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w800,
                        color: white,
                      ),
                    ),
                    Icon(Icons.north_west_rounded, size: 16.sp, color: white),
                  ],
                ),
              ),
            ),
          ),
          10.width,
          GestureDetector(
            onTap: onSaveContact,
            child: Container(
              width: 47.w,
              height: 47.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.profileSave.themeColor,
                borderRadius: BorderRadius.circular(
                    data.buttonShape == 'pill' ? 24.r : data.buttonRadius.r),
                border:
                    Border.all(color: AppColors.assistantBackBorder.themeColor),
              ),
              child: Icon(Icons.download_outlined,
                  size: 20.sp, color: AppColors.profileSaveIcon.themeColor),
            ),
          ),
        ],
      ),
    );
  }
}

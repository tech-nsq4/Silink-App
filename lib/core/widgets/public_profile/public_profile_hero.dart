import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../extensions/extensions.dart';
import '../../utils/app_colors.dart';
import '../../utils/locale_keys.dart';
import '../app_text.dart';
import '../image/custom_image.dart';
import '../silink_brand.dart';
import 'public_profile_data.dart';

class PublicProfileHero extends StatelessWidget {
  const PublicProfileHero({
    super.key,
    required this.data,
    required this.onShare,
    this.onClose,
  });

  final PublicProfileData data;
  final VoidCallback onShare;
  final VoidCallback? onClose;

  Widget _circleButton(IconData icon, VoidCallback onTap) {
    final white = AppColors.white.light;
    final isPro = data.isPro;
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Container(
        width: 31.w,
        height: 31.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isPro
              ? white.withValues(alpha: 0.03)
              : AppColors.white.themeColor,
          border: Border.all(
            color: isPro
                ? white.withValues(alpha: 0.13)
                : AppColors.profileLine.themeColor,
          ),
        ),
        child: Icon(
          icon,
          size: 17.sp,
          color: isPro ? AppColors.profileHeroIcon.themeColor : data.accent,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final white = AppColors.white.light;
    final isPro = data.isPro;
    final isPersonal = data.isPersonal;
    final photo = data.photoUrl?.trim() ?? '';
    final kind = data.isFreelance
        ? LocaleKeys.publicProfile_kindFreelance.tr()
        : data.company;
    final ink = isPro ? white : AppColors.textPrimaryColor.themeColor;
    final muted = isPro
        ? AppColors.profileTitle.themeColor
        : AppColors.textSecondaryColor.themeColor;
    final soft = isPro
        ? AppColors.profileBaseline.themeColor
        : AppColors.studioRowIcon.themeColor;
    final line = isPro
        ? white.withValues(alpha: 0.08)
        : AppColors.profileLine.themeColor;
    final background = isPro
        ? AppColors.profileHero.themeColor
        : isPersonal
            ? Color.alphaBlend(data.accent.withValues(alpha: 0.09), white)
            : AppColors.white.themeColor;
    final align =
        isPersonal ? CrossAxisAlignment.center : CrossAxisAlignment.start;
    final textAlign = isPersonal ? TextAlign.center : TextAlign.start;
    final avatarSize = 65.w;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      constraints: BoxConstraints(minHeight: 322.h),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: background,
        border: isPro ? null : Border(bottom: BorderSide(color: line)),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: const Alignment(-1, -0.3),
                  radius: 1.1,
                  colors: [
                    data.accent.withValues(alpha: isPro ? 0.27 : 0.1),
                    data.accent.withValues(alpha: 0),
                  ],
                  stops: const [0, 0.75],
                ),
              ),
            ),
          ),
          Positioned(
            left: -135.w,
            top: 20.h,
            child: Container(
              width: 260.w,
              height: 260.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isPro
                      ? white.withValues(alpha: 0.086)
                      : data.accent.withValues(alpha: 0.12),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(25.w, 25.h, 25.w, 0),
            child: Column(
              crossAxisAlignment: align,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SilinkBrand(fontSize: 21.sp, color: ink),
                    Row(
                      children: [
                        if (onClose != null) ...[
                          _circleButton(Icons.close_rounded, onClose!),
                          SizedBox(width: 8.w),
                        ],
                        _circleButton(Icons.share_outlined, onShare),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 29.h),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  width: avatarSize,
                  height: avatarSize,
                  alignment: Alignment.center,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: data.accent,
                    borderRadius: BorderRadius.circular(
                        isPersonal ? avatarSize / 2 : 20.r),
                    border: Border.all(
                      color: isPro
                          ? white.withValues(alpha: 0.145)
                          : AppColors.white.themeColor,
                      width: isPro ? 1 : 3,
                    ),
                  ),
                  child: data.photoFile != null
                      ? Image.file(
                          data.photoFile!,
                          width: avatarSize,
                          height: avatarSize,
                          fit: BoxFit.cover,
                        )
                      : photo.isNotEmpty
                          ? CustomImage(
                              image: photo,
                              width: avatarSize,
                              height: avatarSize,
                              fit: BoxFit.cover,
                            )
                          : AppText(
                              data.initials.isEmpty
                                  ? LocaleKeys.publicProfile_you.tr()
                                  : data.initials,
                              fontSize: 23.sp,
                              fontWeight: FontWeight.w800,
                              color: white,
                            ),
                ),
                SizedBox(height: 23.h),
                AppText(
                  kind,
                  fontSize: 9.sp,
                  height: 1.6,
                  textAlign: textAlign,
                  color: isPro ? AppColors.profileKind.themeColor : data.accent,
                ),
                SizedBox(height: 11.h),
                AppText(
                  data.name.trim().isEmpty
                      ? LocaleKeys.publicProfile_namePlaceholder.tr()
                      : data.name,
                  fontSize: 35.sp,
                  fontWeight: FontWeight.w800,
                  height: 1.2,
                  letterSpacing: -0.9,
                  textAlign: textAlign,
                  color: ink,
                ),
                SizedBox(height: 12.h),
                AppText(
                  data.title.trim().isEmpty
                      ? LocaleKeys.publicProfile_titlePlaceholder.tr()
                      : data.title,
                  fontSize: 12.sp,
                  height: 1.8,
                  textAlign: textAlign,
                  color: muted,
                ),
                if (data.location.trim().isNotEmpty) ...[
                  SizedBox(height: 9.h),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.location_on_outlined,
                          size: 12.sp,
                          color: isPro
                              ? AppColors.profileLocation.themeColor
                              : soft),
                      5.width,
                      AppText(
                        data.location,
                        fontSize: 9.sp,
                        color:
                            isPro ? AppColors.profileLocation.themeColor : soft,
                      ),
                    ],
                  ),
                ],
                SizedBox(height: 25.h),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  decoration: BoxDecoration(
                    border: Border(top: BorderSide(color: line)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText(
                        LocaleKeys.publicProfile_baseline.tr(),
                        fontSize: 8.sp,
                        color: soft,
                      ),
                      Icon(Icons.arrow_forward_rounded,
                          size: 15.sp, color: soft),
                    ],
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

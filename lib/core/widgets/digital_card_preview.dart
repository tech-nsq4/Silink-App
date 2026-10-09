import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../extensions/extensions.dart';
import '../utils/app_colors.dart';
import '../utils/locale_keys.dart';
import 'app_text.dart';
import 'image/custom_image.dart';

class DigitalCardPreview extends StatelessWidget {
  const DigitalCardPreview({
    super.key,
    required this.name,
    required this.title,
    required this.company,
    required this.initials,
    required this.accent,
    this.template = 'pro',
    this.buttonRadius = 12,
    this.fontFamily,
    this.photoUrl,
  });

  static const Map<String, double> shapeRadii = {
    'pill': 999,
    'rounded': 12,
    'square': 4,
  };

  final String name;
  final String title;
  final String company;
  final String initials;
  final Color accent;
  final String template;
  final double buttonRadius;
  final String? fontFamily;
  final String? photoUrl;

  bool get _isPro => template == 'pro';
  bool get _isPersonal => template == 'personal';

  @override
  Widget build(BuildContext context) {
    final white = AppColors.white.light;
    final font = fontFamily;
    final name = this.name.trim();
    final title = this.title.trim();
    final company = this.company.trim();
    final photo = photoUrl?.trim() ?? '';
    final ink = _isPro ? white : AppColors.textPrimaryColor.themeColor;
    final muted = _isPro
        ? AppColors.studioCardTitle.themeColor
        : AppColors.textSecondaryColor.themeColor;
    final subtle = _isPro
        ? AppColors.studioCardBrand.themeColor
        : AppColors.studioRowIcon.themeColor;
    final textAlign = _isPersonal ? TextAlign.center : TextAlign.start;
    final align =
        _isPersonal ? CrossAxisAlignment.center : CrossAxisAlignment.start;
    final avatarSize = _isPersonal ? 36.w : 34.w;
    final avatar = AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: avatarSize,
      height: avatarSize,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: accent,
        borderRadius:
            BorderRadius.circular(_isPersonal ? avatarSize / 2 : 10.r),
      ),
      clipBehavior: Clip.antiAlias,
      child: photo.isNotEmpty
          ? CustomImage(
              image: photo,
              width: avatarSize,
              height: avatarSize,
              fit: BoxFit.cover,
            )
          : AppText(
              initials.isEmpty ? LocaleKeys.publicProfile_you.tr() : initials,
              fontSize: 11.sp,
              fontWeight: FontWeight.w800,
              color: white,
              fontFamily: font,
            ),
    );
    final texts = Column(
      crossAxisAlignment: align,
      mainAxisSize: MainAxisSize.min,
      children: [
        AppText(
          name.isEmpty ? LocaleKeys.publicProfile_namePlaceholder.tr() : name,
          fontSize: 15.sp,
          fontWeight: FontWeight.w800,
          height: 1.25,
          color: ink,
          textAlign: textAlign,
          fontFamily: font,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 2.h),
        AppText(
          [
            title.isEmpty
                ? LocaleKeys.cardStudio_cardTitlePlaceholder.tr()
                : title,
            if (company.isNotEmpty) company,
          ].join(' · '),
          fontSize: 9.sp,
          color: muted,
          textAlign: textAlign,
          fontFamily: font,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: _isPro
            ? null
            : _isPersonal
                ? Color.alphaBlend(accent.withValues(alpha: 0.08), white)
                : white,
        gradient: _isPro
            ? LinearGradient(
                colors: [
                  AppColors.studioCardStart.themeColor,
                  AppColors.studioCardEnd.themeColor,
                ],
                stops: const [0, 0.75],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
        borderRadius: BorderRadius.circular(19.r),
        border: _isPro
            ? null
            : Border.all(color: AppColors.studioPanelBorder.themeColor),
        boxShadow: [
          BoxShadow(
            color: AppColors.studioCardStart.themeColor.withValues(alpha: 0.08),
            blurRadius: 24,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Stack(
        children: [
          if (_isPro)
            Positioned(
              top: -90.h,
              left: -110.w,
              child: Container(
                width: 200.w,
                height: 200.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: white.withValues(alpha: 0.07)),
                ),
              ),
            ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 13.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText(
                        'Silink',
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w700,
                        color: subtle,
                        fontFamily: font,
                      ),
                      Icon(Icons.contactless_outlined,
                          size: 16.sp, color: _isPro ? subtle : accent),
                    ],
                  ),
                ),
                SizedBox(height: _isPersonal ? 8.h : 26.h),
                if (_isPersonal)
                  Column(children: [avatar, SizedBox(height: 6.h), texts])
                else
                  Row(
                    children: [
                      avatar,
                      10.width,
                      Expanded(child: texts),
                    ],
                  ),
                SizedBox(height: _isPersonal ? 12.h : 28.h),
                Row(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: accent,
                        borderRadius: BorderRadius.circular(buttonRadius),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.chat_bubble_outline_rounded,
                              size: 11.sp, color: white),
                          5.width,
                          AppText(
                            LocaleKeys.publicProfile_contactMe.tr(),
                            fontSize: 8.5.sp,
                            fontWeight: FontWeight.w700,
                            color: white,
                            fontFamily: font,
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Container(
                      width: 4.w,
                      height: 4.w,
                      decoration: BoxDecoration(
                        color: accent,
                        shape: BoxShape.circle,
                      ),
                    ),
                    5.width,
                    AppText(
                      LocaleKeys.cardStudio_digitalCard.tr(),
                      fontSize: 8.sp,
                      color: subtle,
                      fontFamily: font,
                    ),
                    8.width,
                    Icon(Icons.qr_code_2_rounded,
                        size: 22.sp,
                        color: _isPro
                            ? AppColors.studioCardQr.themeColor
                            : subtle),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

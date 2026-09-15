import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:Silink/features/profile_completion/models/profile_completion_data.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widgets/background_style_card.dart';
import 'widgets/color_swatch_row.dart';
import 'widgets/font_style_option.dart';

class AppearanceStep extends StatefulWidget {
  const AppearanceStep({super.key, required this.data});

  final ProfileCompletionData data;

  @override
  State<AppearanceStep> createState() => _AppearanceStepState();
}

class _AppearanceStepState extends State<AppearanceStep> {
  @override
  Widget build(BuildContext context) {
    final data = widget.data;
    final initial = data.fullName.trim().isEmpty
        ? 'س'
        : data.fullName.trim().characters.first.toUpperCase();

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 19.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            LocaleKeys.appearance_title.tr(),
            fontSize: 20.sp,
            fontWeight: FontWeight.w800,
          ),
          16.height,
          ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: Container(
              color: AppColors.white.themeColor,
              child: Column(
                children: [
                  Container(
                    height: 70.h,
                    width: double.infinity,
                    color: data.coverColor,
                  ),
                  Transform.translate(
                    offset: Offset(0, -26.h),
                    child: Column(
                      children: [
                        Container(
                          width: 52.w,
                          height: 52.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: data.primaryColor,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 3),
                          ),
                          child: AppText(
                            initial,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                        4.height,
                        AppText(
                          data.fullName.trim().isEmpty
                              ? LocaleKeys
                                  .profile_type_basic_info_full_name_hint
                                  .tr()
                              : data.fullName.trim(),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                        ),
                        12.height,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _previewPill(
                              LocaleKeys.appearance_previewCall.tr(),
                              data.primaryColor,
                            ),
                            8.width,
                            _previewPill(
                              LocaleKeys.appearance_previewWhatsapp.tr(),
                              data.primaryColor,
                            ),
                          ],
                        ),
                        10.height,
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          8.height,
          AppText(
            LocaleKeys.appearance_primaryColor.tr(),
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
          ),
          10.height,
          ColorSwatchRow(
            selected: data.primaryColor,
            onSelected: (c) => setState(() => data.primaryColor = c),
          ),
          20.height,
          AppText(
            LocaleKeys.appearance_coverColor.tr(),
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
          ),
          10.height,
          ColorSwatchRow(
            selected: data.coverColor,
            onSelected: (c) => setState(() => data.coverColor = c),
          ),
          20.height,
          AppText(
            LocaleKeys.appearance_profileBackground.tr(),
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
          ),
          10.height,
          Row(
            children: [
              BackgroundStyleCard(
                label: LocaleKeys.appearance_backgroundGradient.tr(),
                preview: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF17B78F), Color(0xFF2F6FED)],
                    ),
                  ),
                ),
                selected:
                    data.backgroundStyle == ProfileBackgroundStyle.gradient,
                onTap: () => setState(() =>
                    data.backgroundStyle = ProfileBackgroundStyle.gradient),
              ),
              8.width,
              BackgroundStyleCard(
                label: LocaleKeys.appearance_backgroundLight.tr(),
                preview: Container(color: const Color(0xFFF1F5F9)),
                selected: data.backgroundStyle == ProfileBackgroundStyle.light,
                onTap: () => setState(
                    () => data.backgroundStyle = ProfileBackgroundStyle.light),
              ),
              8.width,
              BackgroundStyleCard(
                label: LocaleKeys.appearance_backgroundWhite.tr(),
                preview: Container(
                  color: Colors.white,
                  child: Center(
                    child: Icon(Icons.circle,
                        size: 6.sp, color: AppColors.dividerColor.themeColor),
                  ),
                ),
                selected: data.backgroundStyle == ProfileBackgroundStyle.white,
                onTap: () => setState(
                    () => data.backgroundStyle = ProfileBackgroundStyle.white),
              ),
            ],
          ),
          20.height,
          AppText(
            LocaleKeys.appearance_elementShape.tr(),
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
          ),
          10.height,
          Row(
            children: [
              BackgroundStyleCard(
                label: LocaleKeys.appearance_shapeSquare.tr(),
                preview: _shapePreview(0),
                selected: data.elementShape == ProfileElementShape.square,
                onTap: () => setState(
                    () => data.elementShape = ProfileElementShape.square),
              ),
              8.width,
              BackgroundStyleCard(
                label: LocaleKeys.appearance_shapeCurved.tr(),
                preview: _shapePreview(8.r),
                selected: data.elementShape == ProfileElementShape.curved,
                onTap: () => setState(
                    () => data.elementShape = ProfileElementShape.curved),
              ),
              8.width,
              BackgroundStyleCard(
                label: LocaleKeys.appearance_shapeRounded.tr(),
                preview: _shapePreview(999),
                selected: data.elementShape == ProfileElementShape.rounded,
                onTap: () => setState(
                    () => data.elementShape = ProfileElementShape.rounded),
              ),
            ],
          ),
          20.height,
          AppText(
            LocaleKeys.appearance_fontStyle.tr(),
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
          ),
          10.height,
          FontStyleOption(
            label: LocaleKeys.appearance_fontTajawal.tr(),
            fontFamily: 'Tajawal',
            sampleText: LocaleKeys.appearance_fontSample.tr(),
            selected: data.fontStyle == ProfileFontStyle.tajawal,
            onTap: () =>
                setState(() => data.fontStyle = ProfileFontStyle.tajawal),
          ),
          10.height,
          FontStyleOption(
            label: LocaleKeys.appearance_fontCairo.tr(),
            fontFamily: 'Cairo',
            sampleText: LocaleKeys.appearance_fontSample.tr(),
            selected: data.fontStyle == ProfileFontStyle.cairo,
            onTap: () =>
                setState(() => data.fontStyle = ProfileFontStyle.cairo),
          ),
          10.height,
          FontStyleOption(
            label: LocaleKeys.appearance_fontAlmarai.tr(),
            fontFamily: 'Almarai',
            sampleText: LocaleKeys.appearance_fontSample.tr(),
            selected: data.fontStyle == ProfileFontStyle.almarai,
            onTap: () =>
                setState(() => data.fontStyle = ProfileFontStyle.almarai),
          ),
        ],
      ),
    );
  }

  Widget _shapePreview(double radius) {
    return Container(
      color: AppColors.fieldFill,
      child: Center(
        child: Container(
          width: 60.w,
          height: 20.h,
          decoration: BoxDecoration(
            color: const Color(0xFF17B78F),
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
      ),
    );
  }

  Widget _previewPill(String label, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: AppText(
        label,
        fontSize: 11.sp,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
    );
  }
}

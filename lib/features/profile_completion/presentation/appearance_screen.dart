import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/convert_helper.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:Silink/core/widgets/screen_state_layout.dart';
import 'package:Silink/features/profile_completion/logic/profile_completion_cubit.dart';
import 'package:Silink/features/profile_completion/data/models/profile_completion_data.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  void initState() {
    super.initState();
    context.read<ProfileCompletionCubit>().loadAppearance();
  }

  Widget _backgroundPreview(String type, String colorValue) {
    if (type == 'gradient') {
      final hexes = RegExp(r'#[0-9A-Fa-f]{3,8}')
          .allMatches(colorValue)
          .map((m) => m.group(0)!)
          .toList();
      final colors = hexes.map((h) => ConvertHelper.hexToColor(h)).toList();
      return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: colors.length >= 2
                ? colors
                : [ConvertHelper.hexToColor(colorValue), AppColors.fieldFill],
          ),
        ),
      );
    }
    return Container(color: ConvertHelper.hexToColor(colorValue));
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

  Widget _previewPill(String label, Color color, double radius, String? fontFamily) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius > 40 ? 20.r : radius),
      ),
      child: AppText(
        label,
        fontSize: 11.sp,
        fontWeight: FontWeight.w700,
        color: Colors.white,
        fontFamily: fontFamily,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final initial = widget.data.fullName.trim().isEmpty
        ? 'س'
        : widget.data.fullName.trim().characters.first.toUpperCase();

    return BlocBuilder<ProfileCompletionCubit, ProfileCompletionState>(
      builder: (context, state) {
        return CustomScreenStateLayout(
          isLoading: state.appearanceLoading && state.appearance == null,
          error: state.appearanceError != null
              ? ErrorModel(
                  code: ErrorEnum.otherError,
                  errorMessage: state.appearanceError!,
                )
              : null,
          onRetry: () => context
              .read<ProfileCompletionCubit>()
              .loadAppearance(force: true),
          builder: (context) {
            final appearance = state.appearance;
            if (appearance == null) return const SizedBox.shrink();
            final primaryColor = ConvertHelper.hexToColor(appearance.primaryColor);
            final coverColor = ConvertHelper.hexToColor(appearance.coverColor);
            final cubit = context.read<ProfileCompletionCubit>();

            final selectedShape = appearance.shapes
                .where((s) => s.type == appearance.buttonShape)
                .toList();
            final buttonRadius =
                selectedShape.isEmpty ? 999.0 : selectedShape.first.radius;

            final selectedFont = appearance.fonts
                .where((f) => f.id == appearance.fontId)
                .toList();
            final fontFamily =
                selectedFont.isEmpty ? null : selectedFont.first.family;

            final selectedBackground = appearance.backgrounds
                .where((b) => b.type == appearance.background)
                .toList();
            final previewBackground = selectedBackground.isEmpty
                ? BoxDecoration(color: AppColors.white.themeColor)
                : appearance.background == 'gradient'
                    ? BoxDecoration(
                        gradient: LinearGradient(
                          colors: RegExp(r'#[0-9A-Fa-f]{3,8}')
                              .allMatches(selectedBackground.first.color)
                              .map((m) => ConvertHelper.hexToColor(m.group(0)!))
                              .toList(),
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      )
                    : BoxDecoration(
                        color: ConvertHelper.hexToColor(
                            selectedBackground.first.color),
                      );

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
                            color: coverColor,
                          ),
                          Transform.translate(
                            offset: Offset(0, -26.h),
                            child: Container(
                              width: double.infinity,
                              decoration: previewBackground,
                              child: Column(
                                children: [
                                  Container(
                                    width: 52.w,
                                    height: 52.w,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: primaryColor,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: Colors.white, width: 3),
                                    ),
                                    child: AppText(
                                      initial,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                      fontFamily: fontFamily,
                                    ),
                                  ),
                                  4.height,
                                  AppText(
                                    widget.data.fullName.trim().isEmpty
                                        ? LocaleKeys
                                            .profile_type_basic_info_full_name_hint
                                            .tr()
                                        : widget.data.fullName.trim(),
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: fontFamily,
                                  ),
                                  12.height,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      _previewPill(
                                        LocaleKeys.appearance_previewCall.tr(),
                                        primaryColor,
                                        buttonRadius,
                                        fontFamily,
                                      ),
                                      8.width,
                                      _previewPill(
                                        LocaleKeys.appearance_previewWhatsapp
                                            .tr(),
                                        primaryColor,
                                        buttonRadius,
                                        fontFamily,
                                      ),
                                    ],
                                  ),
                                  10.height,
                                ],
                              ),
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
                    colors: appearance.colors
                        .map((c) => ConvertHelper.hexToColor(c))
                        .toList(),
                    selected: primaryColor,
                    onSelected: (c) => cubit.updateAppearanceDraft(
                      primaryColor: ConvertHelper.colorToHex(c),
                    ),
                  ),
                  20.height,
                  AppText(
                    LocaleKeys.appearance_coverColor.tr(),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
                  10.height,
                  ColorSwatchRow(
                    colors: appearance.colors
                        .map((c) => ConvertHelper.hexToColor(c))
                        .toList(),
                    selected: coverColor,
                    onSelected: (c) => cubit.updateAppearanceDraft(
                      coverColor: ConvertHelper.colorToHex(c),
                    ),
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
                      for (int i = 0; i < appearance.backgrounds.length; i++) ...[
                        if (i > 0) 8.width,
                        BackgroundStyleCard(
                          label: appearance.backgrounds[i].label,
                          preview: _backgroundPreview(
                            appearance.backgrounds[i].type,
                            appearance.backgrounds[i].color,
                          ),
                          selected: appearance.background ==
                              appearance.backgrounds[i].type,
                          onTap: () => cubit.updateAppearanceDraft(
                              background: appearance.backgrounds[i].type),
                        ),
                      ],
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
                      for (int i = 0; i < appearance.shapes.length; i++) ...[
                        if (i > 0) 8.width,
                        BackgroundStyleCard(
                          label: appearance.shapes[i].label,
                          preview: _shapePreview(appearance.shapes[i].radius),
                          selected:
                              appearance.buttonShape == appearance.shapes[i].type,
                          onTap: () => cubit.updateAppearanceDraft(
                              buttonShape: appearance.shapes[i].type),
                        ),
                      ],
                    ],
                  ),
                  20.height,
                  AppText(
                    LocaleKeys.appearance_fontStyle.tr(),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
                  10.height,
                  for (final font in appearance.fonts) ...[
                    FontStyleOption(
                      label: font.name,
                      fontFamily: font.family,
                      sampleText: font.sample,
                      selected: appearance.fontId == font.id,
                      onTap: () =>
                          cubit.updateAppearanceDraft(fontId: font.id),
                    ),
                    10.height,
                  ],
                ],
              ),
            );
          },
        );
      },
    );
  }
}

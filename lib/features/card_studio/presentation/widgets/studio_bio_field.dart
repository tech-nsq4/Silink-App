import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_text.dart';
import 'studio_input.dart';

class StudioBioField extends StatefulWidget {
  const StudioBioField({
    super.key,
    required this.controller,
    required this.title,
    required this.onChanged,
  });

  static const int maxLength = 200;

  final TextEditingController controller;
  final String title;
  final ValueChanged<String> onChanged;

  @override
  State<StudioBioField> createState() => _StudioBioFieldState();
}

class _StudioBioFieldState extends State<StudioBioField> {
  bool _showSuggestion = false;

  String get _suggestion {
    final bio = widget.controller.text.trim();
    if (bio.isNotEmpty) return '${bio.split('.').first}.';
    final title = widget.title.trim();
    return LocaleKeys.cardStudio_bioSuggestion.tr(args: [
      title.isEmpty ? LocaleKeys.cardStudio_bioSuggestionRole.tr() : title,
    ]);
  }

  void _useSuggestion() {
    final text = _suggestion;
    widget.controller.text = text;
    widget.onChanged(text);
    setState(() => _showSuggestion = false);
  }

  @override
  Widget build(BuildContext context) {
    final accent = AppColors.accentTeal.themeColor;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                LocaleKeys.cardStudio_bioLabel.tr(),
                fontSize: 11.sp,
                fontWeight: FontWeight.w700,
              ),
              GestureDetector(
                onTap: () => setState(() => _showSuggestion = !_showSuggestion),
                child: Row(
                  children: [
                    Icon(Icons.auto_awesome_outlined,
                        size: 13.sp, color: accent),
                    4.width,
                    AppText(
                      LocaleKeys.cardStudio_bioHelp.tr(),
                      fontSize: 10.sp,
                      color: accent,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (_showSuggestion)
          Container(
            margin: EdgeInsets.only(bottom: 12.h),
            padding: EdgeInsets.all(13.w),
            decoration: BoxDecoration(
              color: AppColors.studioSuggestion.themeColor,
              borderRadius: BorderRadius.circular(11.r),
              border: Border.all(
                  color: AppColors.studioSuggestionBorder.themeColor),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  _suggestion,
                  fontSize: 11.sp,
                  height: 1.8,
                  color: AppColors.studioSuggestionText.themeColor,
                ),
                SizedBox(height: 7.h),
                GestureDetector(
                  onTap: _useSuggestion,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppText(
                        LocaleKeys.cardStudio_useDraft.tr(),
                        fontSize: 10.sp,
                        color: accent,
                      ),
                      6.width,
                      Icon(Icons.check_rounded, size: 12.sp, color: accent),
                    ],
                  ),
                ),
              ],
            ),
          ),
        StudioInput(
          controller: widget.controller,
          hint: LocaleKeys.cardStudio_bioHint.tr(),
          minLines: 3,
          maxLines: 6,
          maxLength: StudioBioField.maxLength,
          onChanged: (value) {
            widget.onChanged(value);
            setState(() {});
          },
        ),
        SizedBox(height: 8.h),
        AppText(
          LocaleKeys.cardStudio_bioCounter
              .tr(args: ['${widget.controller.text.length}']),
          fontSize: 9.sp,
          color: AppColors.studioInputHint.themeColor,
        ),
      ],
    );
  }
}

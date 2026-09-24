import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/app_overlay.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_button.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:Silink/core/widgets/screen_header_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BrandScreen extends StatefulWidget {
  const BrandScreen({super.key});

  @override
  State<BrandScreen> createState() => _BrandScreenState();
}

class _BrandScreenState extends State<BrandScreen> {
  static const _palette = [
    Color(0xFF2563EB),
    Color(0xFF0D9488),
    Color(0xFF7C3AED),
    Color(0xFFDC2626),
    Color(0xFFEA580C),
    Color(0xFF111827),
  ];

  static const _templates = [
    ('simple', LocaleKeys.company_template_simple),
    ('pro', LocaleKeys.company_template_pro),
    ('personal', LocaleKeys.company_template_personal),
  ];

  Color _primary = _palette[0];
  String _template = 'simple';
  bool _lockColors = true;
  final _taglineCtrl = TextEditingController();

  @override
  void dispose() {
    _taglineCtrl.dispose();
    super.dispose();
  }

  void _save() => AppOverlay.showSuccess(LocaleKeys.company_brand_saved.tr());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ScreenHeaderBar(
            title: LocaleKeys.company_brand_identity_title.tr(),
            trailing: TextButton(
              onPressed: _save,
              child: Text(
                LocaleKeys.company_save.tr(),
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.blue.themeColor,
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    LocaleKeys.company_brand_hint.tr(),
                    fontSize: 12.sp,
                    color: AppColors.textSecondaryColor.themeColor,
                  ),
                  12.height,
                  _buildPreview(),
                  20.height,
                  _sectionLabel(LocaleKeys.company_primary_color.tr()),
                  10.height,
                  Wrap(
                    spacing: 10.w,
                    runSpacing: 10.h,
                    children: [
                      for (final color in _palette)
                        InkWell(
                          onTap: () => setState(() => _primary = color),
                          borderRadius: BorderRadius.circular(14.r),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 150),
                            width: 40.w,
                            height: 40.w,
                            decoration: BoxDecoration(
                              color: color,
                              borderRadius: BorderRadius.circular(14.r),
                              border: Border.all(
                                color: _primary == color
                                    ? AppColors.textPrimaryColor.themeColor
                                    : Colors.transparent,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  20.height,
                  _sectionLabel(LocaleKeys.company_profile_template.tr()),
                  10.height,
                  Row(
                    children: [
                      for (final (id, labelKey) in _templates) ...[
                        Expanded(
                          child: InkWell(
                            onTap: () => setState(() => _template = id),
                            borderRadius: BorderRadius.circular(12.r),
                            child: Container(
                              height: 40.h,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: _template == id
                                    ? AppColors.blue.themeColor
                                        .withValues(alpha: 0.08)
                                    : AppColors.cardColor.themeColor,
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                  color: _template == id
                                      ? AppColors.blue.themeColor
                                      : AppColors.borderColor.themeColor,
                                ),
                              ),
                              child: AppText(
                                labelKey.tr(),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w700,
                                color: _template == id
                                    ? AppColors.blue.themeColor
                                    : AppColors.textSecondaryColor.themeColor,
                              ),
                            ),
                          ),
                        ),
                        if (id != 'personal') 8.width,
                      ],
                    ],
                  ),
                  20.height,
                  _sectionLabel(LocaleKeys.company_tagline.tr()),
                  8.height,
                  TextField(
                    controller: _taglineCtrl,
                    onChanged: (_) => setState(() {}),
                    decoration: InputDecoration(
                      hintText: LocaleKeys.company_tagline_hint.tr(),
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                        vertical: 14.h,
                      ),
                      filled: true,
                      fillColor: AppColors.fieldFill,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide(
                          color: AppColors.blue.themeColor,
                          width: 1.2,
                        ),
                      ),
                    ),
                  ),
                  20.height,
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 12.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.cardColor.themeColor,
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(
                        color: AppColors.borderColor.themeColor,
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(
                                LocaleKeys.company_lock_colors.tr(),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                              2.height,
                              AppText(
                                LocaleKeys.company_lock_colors_hint.tr(),
                                fontSize: 11.5.sp,
                                color: AppColors.textSecondaryColor.themeColor,
                              ),
                            ],
                          ),
                        ),
                        Switch(
                          value: _lockColors,
                          activeThumbColor: Colors.white,
                          activeTrackColor: AppColors.mint.themeColor,
                          onChanged: (v) => setState(() => _lockColors = v),
                        ),
                      ],
                    ),
                  ),
                  24.height,
                  CustomButton(
                    onTap: _save,
                    title: LocaleKeys.company_save.tr(),
                    height: 48,
                    radius: 16,
                    fontSize: 15,
                  ),
                  24.height,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionLabel(String label) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 2.w),
      child: AppText(
        label,
        fontSize: 13.sp,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _buildPreview() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardColor.themeColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.borderColor.themeColor),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 56.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  _primary.withValues(alpha: 0.7),
                  _primary,
                ],
                begin: AlignmentDirectional.topStart,
                end: AlignmentDirectional.bottomEnd,
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(0, -26.h),
            child: Padding(
              padding: EdgeInsetsDirectional.only(start: 14.w, end: 14.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        width: 56.w,
                        height: 56.w,
                        decoration: BoxDecoration(
                          color: _primary,
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(
                            color: AppColors.backgroundColor.themeColor,
                            width: 3,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: AppText(
                          'S',
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 3.h,
                        ),
                        decoration: BoxDecoration(
                          color:
                              AppColors.blue.themeColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: AppText(
                          LocaleKeys.company_preview.tr(),
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.blue.themeColor,
                        ),
                      ),
                    ],
                  ),
                  8.height,
                  AppText(
                    'Silink',
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                  ),
                  2.height,
                  AppText(
                    _taglineCtrl.text.trim().isEmpty
                        ? LocaleKeys.company_bio_default.tr()
                        : _taglineCtrl.text.trim(),
                    fontSize: 12.sp,
                    color: AppColors.textSecondaryColor.themeColor,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

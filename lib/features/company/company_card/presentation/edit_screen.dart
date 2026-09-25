import 'dart:io';

import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/app_overlay.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_button.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:Silink/core/widgets/app_text_field.dart';
import 'package:Silink/core/widgets/screen_header_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../company_profile_completion/presentation/widgets/company_image_picker.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({super.key, this.initialImagePath});

  final String? initialImagePath;

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class CompanyEditResult {
  const CompanyEditResult({this.image});

  final File? image;
}

class _EditScreenState extends State<EditScreen> {
  static const _businessTypes = [
    (
      'general',
      LocaleKeys.company_type_general,
      LocaleKeys.company_type_general_desc
    ),
    (
      'restaurant',
      LocaleKeys.company_type_restaurant2,
      LocaleKeys.company_type_restaurant_desc
    ),
    (
      'clinic',
      LocaleKeys.company_type_clinic2,
      LocaleKeys.company_type_clinic_desc
    ),
    (
      'retail',
      LocaleKeys.company_type_retail2,
      LocaleKeys.company_type_retail_desc
    ),
  ];

  static const _industries = [
    ('professional', LocaleKeys.company_ind_professional),
    ('marketing', LocaleKeys.company_ind_marketing),
    ('retail', LocaleKeys.company_ind_retail),
    ('food', LocaleKeys.company_ind_food),
    ('real_estate', LocaleKeys.company_ind_real_estate),
    ('health', LocaleKeys.company_ind_health),
    ('education', LocaleKeys.company_ind_education),
    ('tourism', LocaleKeys.company_ind_tourism),
    ('events', LocaleKeys.company_ind_events),
    ('other', LocaleKeys.company_ind_other),
  ];

  static const _sizes = [
    ('1-10', LocaleKeys.company_size_1_10),
    ('11-50', LocaleKeys.company_size_11_50),
    ('51-200', LocaleKeys.company_size_51_200),
    ('200+', LocaleKeys.company_size_200_plus),
  ];

  final _nameCtrl = TextEditingController(text: 'Silink');
  final _bioCtrl = TextEditingController();
  final _websiteCtrl = TextEditingController();
  final _cityCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  File? _image;

  @override
  void initState() {
    super.initState();
    final path = widget.initialImagePath;
    if (path != null && path.trim().isNotEmpty) {
      _image = File(path);
    }
  }

  String _businessType = 'restaurant';
  String _industry = 'food';
  String _size = '11-50';

  String get _industryLabel => switch (_industry) {
        'professional' => LocaleKeys.company_ind_professional.tr(),
        'marketing' => LocaleKeys.company_ind_marketing.tr(),
        'retail' => LocaleKeys.company_ind_retail.tr(),
        'food' => LocaleKeys.company_ind_food.tr(),
        'real_estate' => LocaleKeys.company_ind_real_estate.tr(),
        'health' => LocaleKeys.company_ind_health.tr(),
        'education' => LocaleKeys.company_ind_education.tr(),
        'tourism' => LocaleKeys.company_ind_tourism.tr(),
        'events' => LocaleKeys.company_ind_events.tr(),
        _ => LocaleKeys.company_ind_other.tr(),
      };

  @override
  void dispose() {
    _nameCtrl.dispose();
    _bioCtrl.dispose();
    _websiteCtrl.dispose();
    _cityCtrl.dispose();
    _phoneCtrl.dispose();
    _emailCtrl.dispose();
    super.dispose();
  }

  void _save() {
    if (_nameCtrl.text.trim().isEmpty) {
      AppOverlay.showError(LocaleKeys.company_name_required.tr());
      return;
    }
    AppOverlay.showSuccess(LocaleKeys.company_saved.tr());
    Navigator.of(context).pop(CompanyEditResult(image: _image));
  }

  Widget _labeledField(String label, Widget child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(label, fontSize: 13.sp, fontWeight: FontWeight.w600),
        8.height,
        child,
      ],
    );
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ScreenHeaderBar(
            title: LocaleKeys.company_edit_data_title.tr(),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CompanyImagePicker(
                      image: _image,
                      companyName: _nameCtrl.text,
                      industry: _industryLabel,
                      onChanged: (image) => setState(() => _image = image),
                    ),
                    14.height,
                    _labeledField(
                      LocaleKeys.company_name_label.tr(),
                      CustomTextField(
                        borderColor: AppColors.borderColor.themeColor,
                        controller: _nameCtrl,
                        onChanged: (_) => setState(() {}),
                        hint: LocaleKeys.company_name_label.tr(),
                      ),
                    ),
                    14.height,
                    _labeledField(
                      LocaleKeys.company_bio_label.tr(),
                      CustomTextField(
                        borderColor: AppColors.borderColor.themeColor,
                        controller: _bioCtrl,
                        maxLines: 3,
                        hint: LocaleKeys.company_bio_label.tr(),
                      ),
                    ),
                    14.height,
                    _labeledField(
                      LocaleKeys.company_website_label.tr(),
                      CustomTextField(
                        borderColor: AppColors.borderColor.themeColor,
                        controller: _websiteCtrl,
                        hint: LocaleKeys.company_website_label.tr(),
                      ),
                    ),
                    14.height,
                    _labeledField(
                      LocaleKeys.company_business_type_label.tr(),
                      Column(
                        children: [
                          for (final (id, titleKey, descKey) in _businessTypes)
                            _OptionCard(
                              selected: _businessType == id,
                              title: titleKey.tr(),
                              desc: descKey.tr(),
                              onTap: () => setState(() => _businessType = id),
                            ),
                        ],
                      ),
                    ),
                    14.height,
                    _labeledField(
                      LocaleKeys.company_industry_label.tr(),
                      Wrap(
                        spacing: 8.w,
                        runSpacing: 8.h,
                        children: [
                          for (final (id, labelKey) in _industries)
                            _ChoiceChip(
                              label: labelKey.tr(),
                              selected: _industry == id,
                              onTap: () => setState(() => _industry = id),
                            ),
                        ],
                      ),
                    ),
                    14.height,
                    _labeledField(
                      LocaleKeys.company_size_label.tr(),
                      Wrap(
                        spacing: 8.w,
                        runSpacing: 8.h,
                        children: [
                          for (final (id, labelKey) in _sizes)
                            _ChoiceChip(
                              label: labelKey.tr(),
                              selected: _size == id,
                              onTap: () => setState(() => _size = id),
                            ),
                        ],
                      ),
                    ),
                    14.height,
                    _labeledField(
                      LocaleKeys.company_city_label.tr(),
                      CustomTextField(
                        borderColor: AppColors.borderColor.themeColor,
                        controller: _cityCtrl,
                        hint: LocaleKeys.company_city_label.tr(),
                      ),
                    ),
                    14.height,
                    _labeledField(
                      LocaleKeys.company_phone_contact.tr(),
                      CustomTextField(
                        borderColor: AppColors.borderColor.themeColor,
                        controller: _phoneCtrl,
                        keyboardType: TextInputType.phone,
                        hint: LocaleKeys.company_phone_contact.tr(),
                      ),
                    ),
                    14.height,
                    _labeledField(
                      LocaleKeys.company_email_official.tr(),
                      CustomTextField(
                        borderColor: AppColors.borderColor.themeColor,
                        controller: _emailCtrl,
                        keyboardType: TextInputType.emailAddress,
                        hint: LocaleKeys.company_email_official.tr(),
                      ),
                    ),
                    24.height,
                    24.height,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 14.h),
        child: CustomButton(
          onTap: _save,
          title: LocaleKeys.company_save_changes.tr(),
          height: 48,
          radius: 16,
          fontSize: 15,
        ),
      ),
    );
  }
}

class _OptionCard extends StatelessWidget {
  const _OptionCard({
    required this.selected,
    required this.title,
    required this.desc,
    required this.onTap,
  });

  final bool selected;
  final String title;
  final String desc;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final accent = AppColors.blue.themeColor;
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: selected
                ? accent.withValues(alpha: 0.06)
                : AppColors.cardColor.themeColor,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: selected ? accent : AppColors.borderColor.themeColor,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(title, fontSize: 13.sp, fontWeight: FontWeight.w700),
              2.height,
              AppText(
                desc,
                fontSize: 11.sp,
                color: AppColors.textSecondaryColor.themeColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChoiceChip extends StatelessWidget {
  const _ChoiceChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final accent = AppColors.blue.themeColor;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: selected
              ? accent.withValues(alpha: 0.06)
              : AppColors.cardColor.themeColor,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: selected ? accent : AppColors.borderColor.themeColor,
          ),
        ),
        child: AppText(
          label,
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: selected ? accent : AppColors.textSecondaryColor.themeColor,
        ),
      ),
    );
  }
}

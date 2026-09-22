import 'dart:io';

import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/app_overlay.dart';
import 'package:Silink/core/utils/custom_text_field_phone/custom_text_field_phone_code.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:Silink/core/widgets/app_text_field.dart';
import 'package:Silink/features/profile_completion/data/models/profile_completion_data.dart';
import 'package:Silink/features/location/presentation/location_picker_screen.dart';
import 'package:Silink/core/widgets/field_label.dart';
import 'package:Silink/core/widgets/photo_source_sheet.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class BasicInfoStep extends StatefulWidget {
  final ProfileCompletionData data;
  final ValueChanged<bool> onValidityChanged;

  const BasicInfoStep({
    super.key,
    required this.data,
    required this.onValidityChanged,
  });

  @override
  State<BasicInfoStep> createState() => _BasicInfoStepState();
}

class _BasicInfoStepState extends State<BasicInfoStep> {
  late final TextEditingController _nameCtrl;
  late final TextEditingController _jobCtrl;
  late final TextEditingController _companyCtrl;
  late final TextEditingController _bioCtrl;
  late final TextEditingController _phoneCtrl;
  late final TextEditingController _passwordCtrl;
  late final TextEditingController _locationCtrl;

  static const int _bioMaxLength = 200;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.data.fullName)
      ..addListener(_onChanged);
    _jobCtrl = TextEditingController(text: widget.data.jobTitle)
      ..addListener(_onChanged);
    _companyCtrl = TextEditingController(text: widget.data.company)
      ..addListener(_onChanged);
    _bioCtrl = TextEditingController(text: widget.data.bio)
      ..addListener(_onChanged);
    _phoneCtrl = TextEditingController(text: widget.data.phone)
      ..addListener(_onChanged);
    _passwordCtrl = TextEditingController(text: widget.data.password)
      ..addListener(_onChanged);
    _locationCtrl = TextEditingController(text: widget.data.location)
      ..addListener(_onChanged);

    WidgetsBinding.instance.addPostFrameCallback((_) => _reportValidity());
  }

  void _onChanged() {
    widget.data
      ..fullName = _nameCtrl.text.trim()
      ..jobTitle = _jobCtrl.text.trim()
      ..company = _companyCtrl.text.trim()
      ..bio = _bioCtrl.text.trim()
      ..password = _passwordCtrl.text.trim()
      ..location = _locationCtrl.text.trim();

    _reportValidity();
    setState(() {});
  }

  void _onPhoneChanged(PhoneNumber phone) {
    widget.data.phone =
        phone.number.trim().isEmpty ? '' : phone.completeNumber;
    _reportValidity();
  }

  void _reportValidity() {
    final valid = _nameCtrl.text.trim().isNotEmpty &&
        _jobCtrl.text.trim().isNotEmpty &&
        _phoneCtrl.text.trim().isNotEmpty;
    widget.onValidityChanged(valid);
  }

  String get _initial {
    final t = _nameCtrl.text.trim();
    return t.isEmpty ? 'م' : t.characters.first.toUpperCase();
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
      setState(() => widget.data.photo = File(picked.path));
    } catch (_) {
      if (!mounted) return;
      AppOverlay.showError(
        LocaleKeys.profile_type_basic_info_photo_pick_error.tr(),
      );
    }
  }

  Future<void> _pickLocation() async {
    final result = await Navigator.of(context).push<LocationPickerResult>(
      MaterialPageRoute(builder: (_) => const LocationPickerScreen()),
    );
    if (result == null || !mounted) return;
    widget.data.lat = result.lat;
    widget.data.lng = result.lng;
    _locationCtrl.text = result.address;
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _jobCtrl.dispose();
    _companyCtrl.dispose();
    _bioCtrl.dispose();
    _phoneCtrl.dispose();
    _passwordCtrl.dispose();
    _locationCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 19.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            LocaleKeys.profile_type_basic_info_title.tr(),
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
          ),
          4.height,
          AppText(
            LocaleKeys.profile_type_basic_info_subtitle.tr(),
            fontSize: 14.sp,
          ),
          24.height,

          Row(
            children: [
              Container(
                width: 70.w,
                height: 70.w,
                alignment: Alignment.center,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: AppColors.successColor.themeColor,
                  borderRadius: BorderRadius.circular(22.r),
                ),
                child: widget.data.photo != null
                    ? Image.file(
                        widget.data.photo!,
                        width: 70.w,
                        height: 70.w,
                        fit: BoxFit.cover,
                      )
                    : AppText(
                        _initial,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w800,
                        color: AppColors.white.themeColor,
                      ),
              ),
              12.width,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    LocaleKeys.profile_type_basic_info_photo_label.tr(),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  4.height,
                  AppText(
                    LocaleKeys.profile_type_basic_info_photo_hint.tr(),
                    fontSize: 12.sp,
                  ),
                  6.height,
                  InkWell(
                    onTap: _pickPhoto,
                    borderRadius: BorderRadius.circular(12.r),
                    child: Row(
                      children: [
                        Icon(
                          Icons.camera_alt_outlined,
                          size: 16.sp,
                          color: AppColors.successColor.themeColor,
                        ),
                        8.width,
                        AppText(
                          LocaleKeys.profile_type_basic_info_choose_photo.tr(),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.successColor.themeColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),

          24.height,

          FieldLabel(
            text: LocaleKeys.profile_type_basic_info_full_name.tr(),
            required: true,
          ),
          CustomTextField(
            controller: _nameCtrl,
            hint: LocaleKeys.profile_type_basic_info_full_name_hint.tr(),
          ),
          16.height,

          FieldLabel(
            text: LocaleKeys.profile_type_basic_info_job_title.tr(),
            required: true,
          ),
          CustomTextField(
            controller: _jobCtrl,
            hint: LocaleKeys.profile_type_basic_info_job_title_hint.tr(),
          ),
          16.height,

          FieldLabel(text: LocaleKeys.profile_type_basic_info_company.tr()),
          CustomTextField(
            controller: _companyCtrl,
            hint: LocaleKeys.profile_type_basic_info_company_hint.tr(),
          ),
          16.height,

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FieldLabel(text: LocaleKeys.profile_type_basic_info_bio.tr()),
              AppText(
                '${_bioCtrl.text.length}/$_bioMaxLength',
                fontSize: 12.sp,
                color: AppColors.textSecondaryColor.themeColor,
              ),
            ],
          ),
          CustomTextField(
            controller: _bioCtrl,
            hint: LocaleKeys.profile_type_basic_info_bio_hint.tr(),
            maxLines: 3,
          ),
          16.height,

          FieldLabel(
            text: LocaleKeys.profile_type_basic_info_phone.tr(),
            required: true,
          ),
          CustomTextFieldPhoneCode(
            controller: _phoneCtrl,
            hint: LocaleKeys.profile_type_basic_info_phone_hint.tr(),
            // egyptIsInitial: true,
            onChanged: _onPhoneChanged,
          ),
          12.height,

          FieldLabel(text: LocaleKeys.auth_password.tr()),
          CustomTextField(
            controller: _passwordCtrl,
            hint: LocaleKeys.auth_passwordPlaceholder.tr(),
            isPassword: true,
          ),
          12.height,
          FieldLabel(
              text:
                  '${LocaleKeys.profile_type_location.tr()} / ${LocaleKeys.profile_type_city.tr()}'),
          CustomTextField(
            controller: _locationCtrl,
            hint: 'الرياض، المملكة العربية السعودية',
            prefixIcon: Icon(Icons.location_on_rounded, size: 23.sp,color: Colors.grey,),
            readOnly: true,
            onTap: _pickLocation,
          ),
          12.height,
        ],
      ),
    );
  }
}

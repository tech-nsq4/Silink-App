import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_overlay.dart';
import '../../../../core/utils/custom_text_field_phone/custom_text_field_phone_code.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/photo_source_sheet.dart';
import '../../../location/presentation/location_picker_screen.dart';
import '../../data/models/studio_draft.dart';
import 'studio_bio_field.dart';
import 'studio_editor_heading.dart';
import 'studio_field.dart';
import 'studio_field_label.dart';
import 'studio_identity_head.dart';
import 'studio_panel.dart';

class StudioIdentityStep extends StatefulWidget {
  const StudioIdentityStep({
    super.key,
    required this.draft,
    required this.withAccount,
    required this.onChanged,
  });

  final StudioDraft draft;
  final bool withAccount;
  final ValueChanged<StudioDraft> onChanged;

  @override
  State<StudioIdentityStep> createState() => _StudioIdentityStepState();
}

class _StudioIdentityStepState extends State<StudioIdentityStep> {
  late final _nameCtrl = TextEditingController(text: widget.draft.name);
  late final _titleCtrl = TextEditingController(text: widget.draft.title);
  late final _companyCtrl = TextEditingController(text: widget.draft.company);
  static const String _countryIso = 'SA';
  static const String _countryCode = '+966';

  late final _phoneCtrl = TextEditingController(
    text: widget.draft.phone.startsWith(_countryCode)
        ? widget.draft.phone.substring(_countryCode.length)
        : widget.draft.phone,
  );
  late final _emailCtrl = TextEditingController(text: widget.draft.email);
  late final _locationCtrl = TextEditingController(text: widget.draft.location);
  late final _passwordCtrl = TextEditingController(text: widget.draft.password);
  late final _bioCtrl = TextEditingController(text: widget.draft.bio);

  @override
  void dispose() {
    for (final controller in [
      _nameCtrl,
      _titleCtrl,
      _companyCtrl,
      _phoneCtrl,
      _emailCtrl,
      _locationCtrl,
      _passwordCtrl,
      _bioCtrl,
    ]) {
      controller.dispose();
    }
    super.dispose();
  }

  void _change(StudioDraft Function(StudioDraft draft) update) =>
      widget.onChanged(update(widget.draft));

  Future<void> _pickPhoto() async {
    final source = await PhotoSourceSheet.show(context);
    if (source == null || !mounted) return;
    try {
      final picked = await ImagePicker()
          .pickImage(source: source, maxWidth: 1024, imageQuality: 85);
      if (picked == null || !mounted) return;
      _change((d) => d.copyWith(photoFile: File(picked.path)));
    } catch (_) {
      if (mounted) {
        AppOverlay.showError(
          LocaleKeys.profile_type_basic_info_photo_pick_error.tr(),
        );
      }
    }
  }

  Future<void> _pickLocation() async {
    final result = await Navigator.of(context).push<LocationPickerResult>(
      MaterialPageRoute(builder: (_) => const LocationPickerScreen()),
    );
    if (result == null || !mounted) return;
    _locationCtrl.text = result.address;
    _change((d) => d.copyWith(
          location: result.address,
          lat: result.lat,
          lng: result.lng,
        ));
  }

  @override
  Widget build(BuildContext context) {
    final draft = widget.draft;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        StudioEditorHeading(
          title: LocaleKeys.cardStudio_identityTitle.tr(),
          subtitle: LocaleKeys.cardStudio_identitySubtitle.tr(),
        ),
        StudioIdentityHead(
          name: draft.name,
          photoFile: draft.photoFile,
          photoUrl: draft.photoUrl,
          onTap: _pickPhoto,
        ),
        StudioPanel(
          children: [
            StudioField(
              label: LocaleKeys.cardStudio_nameLabel.tr(),
              hint: LocaleKeys.cardStudio_nameHint.tr(),
              controller: _nameCtrl,
              required: true,
              onChanged: (v) => _change((d) => d.copyWith(name: v)),
            ),
            StudioField(
              label: LocaleKeys.cardStudio_titleLabel.tr(),
              hint: LocaleKeys.cardStudio_titleHint.tr(),
              controller: _titleCtrl,
              required: true,
              onChanged: (v) => _change((d) => d.copyWith(title: v)),
            ),
            StudioField(
              label: LocaleKeys.cardStudio_companyLabel.tr(),
              hint: LocaleKeys.cardStudio_optional.tr(),
              controller: _companyCtrl,
              onChanged: (v) => _change((d) => d.copyWith(company: v)),
            ),
          ],
        ),
        StudioPanel(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                StudioFieldLabel(
                  label: LocaleKeys.cardStudio_phoneLabel.tr(),
                  required: true,
                ),
                SizedBox(height: 7.h),
                CustomTextFieldPhoneCode(
                  controller: _phoneCtrl,
                  hint: LocaleKeys.profile_type_basic_info_phone_hint.tr(),
                  initialCountryCode: _countryIso,
                  isRequired: false,
                  borderRadius: 9.r,
                  fillColor: AppColors.studioFieldFill.themeColor,
                  borderColor: AppColors.studioFieldBorder.themeColor,
                  focusedBorderColor: AppColors.accentTeal.themeColor,
                  onChanged: (phone) => _change(
                    (d) => d.copyWith(
                      phone: phone.number.trim().isEmpty
                          ? ''
                          : phone.completeNumber,
                    ),
                  ),
                ),
              ],
            ),
            StudioField(
              label: LocaleKeys.cardStudio_emailLabel.tr(),
              hint: 'name@company.com',
              controller: _emailCtrl,
              keyboardType: TextInputType.emailAddress,
              ltr: true,
              onChanged: (v) => _change((d) => d.copyWith(email: v)),
            ),
            StudioField(
              label: LocaleKeys.cardStudio_locationLabel.tr(),
              hint: LocaleKeys.cardStudio_locationHint.tr(),
              controller: _locationCtrl,
              readOnly: true,
              prefixIcon: Icons.location_on_rounded,
              onTap: _pickLocation,
            ),
            if (widget.withAccount)
              StudioField(
                label: LocaleKeys.cardStudio_passwordLabel.tr(),
                hint: LocaleKeys.cardStudio_passwordHint.tr(),
                controller: _passwordCtrl,
                required: true,
                obscure: true,
                onChanged: (v) => _change((d) => d.copyWith(password: v)),
              ),
          ],
        ),
        StudioBioField(
          controller: _bioCtrl,
          title: draft.title,
          onChanged: (v) => _change((d) => d.copyWith(bio: v)),
        ),
      ],
    );
  }
}

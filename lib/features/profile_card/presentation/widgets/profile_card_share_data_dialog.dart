import 'dart:ui';

import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/app_images.dart';
import 'package:Silink/core/utils/custom_text_field_phone/custom_text_field_phone_code.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:Silink/features/profile_card/data/models/profile_card_lead_request.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'profile_card_gradient_button.dart';
import 'profile_card_lead_consent.dart';
import 'profile_card_lead_field.dart';

class ProfileCardShareDataDialog extends StatefulWidget {
  const ProfileCardShareDataDialog({
    super.key,
    required this.ownerName,
    required this.onSubmit,
  });

  final String ownerName;
  final Future<bool> Function(ProfileCardLeadRequest lead) onSubmit;

  static Future<void> show(
    BuildContext context, {
    required String ownerName,
    required Future<bool> Function(ProfileCardLeadRequest lead) onSubmit,
  }) {
    return showDialog<void>(
      context: context,
      barrierColor: AppColors.black.themeColor.withValues(alpha: 0.35),
      builder: (_) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: ProfileCardShareDataDialog(
          ownerName: ownerName,
          onSubmit: onSubmit,
        ),
      ),
    );
  }

  @override
  State<ProfileCardShareDataDialog> createState() =>
      _ProfileCardShareDataDialogState();
}

class _ProfileCardShareDataDialogState
    extends State<ProfileCardShareDataDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameCtrl = TextEditingController()
    ..addListener(_refresh);
  final _phoneCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _companyCtrl = TextEditingController();
  final _jobTitleCtrl = TextEditingController();
  final _messageCtrl = TextEditingController();
  String _completePhone = '';
  bool _consent = false;
  bool _submitting = false;

  bool get _canSubmit => _nameCtrl.text.trim().isNotEmpty && _consent;

  static final RegExp _emailPattern = RegExp(r'^[\w.\-+]+@[\w\-]+\.[\w.\-]+$');

  void _refresh() => setState(() {});

  String? _validateEmail(String? value) {
    final email = value?.trim() ?? '';
    if (email.isEmpty || _emailPattern.hasMatch(email)) return null;
    return LocaleKeys.validation_invalidEmail.tr();
  }

  Future<void> _submit() async {
    if (!_canSubmit || !(_formKey.currentState?.validate() ?? false)) return;
    setState(() => _submitting = true);
    final sent = await widget.onSubmit(
      ProfileCardLeadRequest(
        fullName: _nameCtrl.text.trim(),
        phone: _completePhone,
        email: _emailCtrl.text.trim(),
        company: _companyCtrl.text.trim(),
        jobTitle: _jobTitleCtrl.text.trim(),
        message: _messageCtrl.text.trim(),
        consent: _consent,
      ),
    );
    if (!mounted) return;
    setState(() => _submitting = false);
    if (sent) Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    _emailCtrl.dispose();
    _companyCtrl.dispose();
    _jobTitleCtrl.dispose();
    _messageCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final secondary = AppColors.textSecondaryColor.themeColor;

    return Dialog(
      backgroundColor: AppColors.white.themeColor,
      insetPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 32.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 20.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          LocaleKeys.publish_share_data.tr(),
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w800,
                        ),
                        4.height,
                        AppText(
                          LocaleKeys.publish_shareDataSubtitle
                              .tr(args: [widget.ownerName]),
                          fontSize: 13.sp,
                          color: secondary,
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    borderRadius: BorderRadius.circular(10.r),
                    child: Container(
                      width: 34.w,
                      height: 34.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.profileCardLightBackground.themeColor,
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(
                            color: AppColors.dividerColor.themeColor),
                      ),
                      child: Icon(Icons.close_rounded,
                          size: 18.sp, color: secondary),
                    ),
                  ),
                ],
              ),
              20.height,
              ProfileCardLeadField(
                label: LocaleKeys.publish_leadFullName.tr(),
                hint: LocaleKeys.publish_leadFullNameHint.tr(),
                controller: _nameCtrl,
                isRequired: true,
              ),
              14.height,
              ProfileCardLeadField(
                label: LocaleKeys.publish_leadPhone.tr(),
                hint: LocaleKeys.publish_leadPhoneHint.tr(),
                field: CustomTextFieldPhoneCode(
                  controller: _phoneCtrl,
                  hint: LocaleKeys.publish_leadPhoneHint.tr(),
                  initialCountryCode: 'SA',
                  isRequired: false,
                  fillColor: AppColors.fieldFill,
                  onChanged: (phone) => _completePhone =
                      phone.number.trim().isEmpty ? '' : phone.completeNumber,
                ),
              ),
              14.height,
              ProfileCardLeadField(
                label: LocaleKeys.publish_leadEmail.tr(),
                hint: LocaleKeys.publish_leadEmailHint.tr(),
                controller: _emailCtrl,
                keyboardType: TextInputType.emailAddress,
                validator: _validateEmail,
              ),
              14.height,
              ProfileCardLeadField(
                label: LocaleKeys.publish_leadCompany.tr(),
                hint: LocaleKeys.publish_leadCompanyHint.tr(),
                controller: _companyCtrl,
              ),
              14.height,
              ProfileCardLeadField(
                label: LocaleKeys.publish_leadJobTitle.tr(),
                hint: LocaleKeys.publish_leadJobTitleHint.tr(),
                controller: _jobTitleCtrl,
              ),
              14.height,
              ProfileCardLeadField(
                label: LocaleKeys.publish_leadMessage.tr(),
                optionalLabel: LocaleKeys.publish_leadOptional.tr(),
                hint: LocaleKeys.publish_leadMessageHint.tr(),
                controller: _messageCtrl,
                maxLines: 4,
              ),
              18.height,
              ProfileCardLeadConsent(
                label:
                    LocaleKeys.publish_leadConsent.tr(args: [widget.ownerName]),
                value: _consent,
                onChanged: (value) => setState(() => _consent = value),
              ),
              20.height,
              ProfileCardGradientButton(
                label: LocaleKeys.publish_leadSubmit.tr(),
                icon: AppImages.iconsSend,
                enabled: _canSubmit,
                loading: _submitting,
                onTap: _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

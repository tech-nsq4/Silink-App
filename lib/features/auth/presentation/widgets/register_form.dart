import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/custom_text_field_phone/custom_text_field_phone_code.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/gradient_action_button.dart';
import '../../logic/auth_cubit.dart';
import 'auth_error_box.dart';
import 'auth_field_label.dart';
import 'auth_guest_link.dart';
import 'auth_stage_indicator.dart';
import 'auth_terms_note.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key, required this.loading});

  final bool loading;

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  static const int _minPasswordLength = 8;
  static final RegExp _phonePattern = RegExp(r'^\+?[\d\s-]{7,16}$');
  static final RegExp _emailPattern = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');

  final _nameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  int _step = 0;
  String? _error;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  String? _validateDetails() {
    if (_nameCtrl.text.trim().isEmpty) return LocaleKeys.auth_nameRequired.tr();
    if (!_phonePattern.hasMatch(_phoneCtrl.text.trim())) {
      return LocaleKeys.auth_phoneInvalid.tr();
    }
    return null;
  }

  String? _validateSecurity() {
    if (!_emailPattern.hasMatch(_emailCtrl.text.trim())) {
      return LocaleKeys.auth_emailInvalid.tr();
    }
    if (_passwordCtrl.text.length < _minPasswordLength) {
      return LocaleKeys.auth_passwordMinEight.tr();
    }
    return null;
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    if (_step == 0) {
      final error = _validateDetails();
      setState(() {
        _error = error;
        if (error == null) _step = 1;
      });
      return;
    }
    final error = _validateSecurity();
    setState(() => _error = error);
    if (error != null) return;
    final phone = _phoneCtrl.text.replaceAll(RegExp(r'[\s-]'), '');
    context.read<AuthCubit>().registerCompany(
          fullName: _nameCtrl.text.trim(),
          phone: phone,
          email: _emailCtrl.text.trim(),
          password: _passwordCtrl.text,
        );
  }

  void _backToDetails() => setState(() {
        _step = 0;
        _error = null;
      });

  Widget _fieldIcon(IconData icon) =>
      Icon(icon, size: 16.sp, color: AppColors.fieldIcon.themeColor);

  List<Widget> _detailsFields() => [
        AuthFieldLabel(text: LocaleKeys.auth_fullNameLabel.tr()),
        9.height,
        CustomTextField(
          controller: _nameCtrl,
          hint: LocaleKeys.auth_fullNameHint.tr(),
          keyboardType: TextInputType.name,
        ),
        18.height,
        AuthFieldLabel(text: LocaleKeys.auth_phoneLabel.tr()),
        9.height,
        CustomTextFieldPhoneCode(
          controller: _phoneCtrl,
          hint: LocaleKeys.auth_phoneHint.tr(),
          initialCountryCode: 'SA',
          isRequired: false,
          borderRadius: 11,
          fillColor: AppColors.white.themeColor,
          borderColor: AppColors.borderColor.themeColor,
          focusedBorderColor: AppColors.mint.themeColor,
        ),
      ];

  List<Widget> _securityFields() => [
        AuthFieldLabel(text: LocaleKeys.auth_email.tr()),
        9.height,
        CustomTextField(
          controller: _emailCtrl,
          hint: LocaleKeys.auth_emailHint.tr(),
          keyboardType: TextInputType.emailAddress,
          prefixIcon: _fieldIcon(Icons.mail_outline_rounded),
        ),
        18.height,
        AuthFieldLabel(text: LocaleKeys.auth_password.tr()),
        9.height,
        CustomTextField(
          controller: _passwordCtrl,
          hint: LocaleKeys.auth_passwordPlaceholder.tr(),
          isPassword: true,
          prefixIcon: _fieldIcon(Icons.shield_outlined),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AuthStageIndicator(step: _step, onDetailsTap: _backToDetails),
        24.height,
        ...(_step == 0 ? _detailsFields() : _securityFields()),
        18.height,
        if (_error != null) ...[
          AuthErrorBox(message: _error!),
          14.height,
        ],
        GradientActionButton(
          title: _step == 0
              ? LocaleKeys.auth_continueSetup.tr()
              : LocaleKeys.auth_createAccountButton.tr(),
          loadingTitle: LocaleKeys.auth_pleaseWait.tr(),
          loading: widget.loading,
          onTap: _submit,
        ),
        if (_step == 1) ...[
          AuthGuestLink(
            label: LocaleKeys.auth_editNamePhone.tr(),
            showArrow: false,
            onTap: _backToDetails,
          ),
          const AuthTermsNote(),
        ],
      ],
    );
  }
}

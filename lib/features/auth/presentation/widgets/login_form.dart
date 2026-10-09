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

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
    required this.loading,
    required this.onGuest,
  });

  final bool loading;
  final VoidCallback onGuest;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  static const int _minPasswordLength = 6;

  final _phoneCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  String? _error;

  @override
  void dispose() {
    _phoneCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  String? _validate() {
    if (_phoneCtrl.text.trim().isEmpty) {
      return LocaleKeys.auth_phoneRequired.tr();
    }
    if (_passwordCtrl.text.length < _minPasswordLength) {
      return LocaleKeys.validation_shortPassword.tr();
    }
    return null;
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    final error = _validate();
    setState(() => _error = error);
    if (error != null) return;
    context.read<AuthCubit>().login(
          phone: _phoneCtrl.text.trim(),
          password: _passwordCtrl.text,
        );
  }

  Widget _fieldIcon(IconData icon) =>
      Icon(icon, size: 16.sp, color: AppColors.fieldIcon.themeColor);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AuthFieldLabel(text: LocaleKeys.auth_phone.tr()),
        9.height,
        CustomTextFieldPhoneCode(
          controller: _phoneCtrl,
          hint: LocaleKeys.auth_phonePlaceholder.tr(),
          initialCountryCode: 'SA',
          isRequired: false,
          borderRadius: 11,
          fillColor: AppColors.white.themeColor,
          borderColor: AppColors.borderColor.themeColor,
          focusedBorderColor: AppColors.mint.themeColor,
        ),
        18.height,
        AuthFieldLabel(text: LocaleKeys.auth_password.tr()),
        9.height,
        CustomTextField(
          controller: _passwordCtrl,
          hint: LocaleKeys.auth_passwordHint.tr(),
          isPassword: true,
          prefixIcon: _fieldIcon(Icons.shield_outlined),
        ),
        18.height,
        if (_error != null) ...[
          AuthErrorBox(message: _error!),
          14.height,
        ],
        GradientActionButton(
          title: LocaleKeys.auth_login.tr(),
          loadingTitle: LocaleKeys.auth_pleaseWait.tr(),
          loading: widget.loading,
          onTap: _submit,
        ),
        AuthGuestLink(
          label: LocaleKeys.auth_exploreAsGuest.tr(),
          onTap: widget.onGuest,
        ),
      ],
    );
  }
}

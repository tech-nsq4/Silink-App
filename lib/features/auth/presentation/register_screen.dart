import 'package:easy_localization/easy_localization.dart';
import 'package:Silink/core/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/router/routes.dart';
import '../../../core/utils/locale_keys.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text_field.dart';
import '../logic/auth_cubit.dart';
import 'widgets/auth_field_label.dart';
import 'widgets/register_header.dart';
import 'widgets/register_sign_in_footer.dart';
import 'widgets/register_terms_notice.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  static const String _defaultCountryCode = '+966';

  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    context.read<AuthCubit>().register(
        name: _nameCtrl.text.trim(),
        email: _emailCtrl.text.trim(),
        phone: _phoneCtrl.text.trim(),
        password: _passwordCtrl.text,
        countryCode: _defaultCountryCode);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          Navigator.pushNamed(
            context,
            Routes.otpScreen,
            arguments: {'destination': _phoneCtrl.text.trim()},
          );
        }
      },
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          final isLoading = state is AuthLoading;

          return Scaffold(
            body: SafeArea(
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 19.w, vertical: 16.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const RegisterHeader(),
                        24.height,
                        AuthFieldLabel(text: LocaleKeys.auth_name.tr()),
                        8.height,
                        CustomTextField(
                          hint: LocaleKeys.auth_namePlaceholder.tr(),
                          controller: _nameCtrl,
                          keyboardType: TextInputType.name,
                          validator: (v) {
                            if (v == null || v.trim().isEmpty) {
                              return LocaleKeys.validation_required.tr();
                            }
                            return null;
                          },
                        ),
                        14.height,
                        AuthFieldLabel(text: LocaleKeys.auth_phone.tr()),
                        8.height,
                        CustomTextField(
                          hint: LocaleKeys.auth_phonePlaceholder.tr(),
                          controller: _phoneCtrl,
                          keyboardType: TextInputType.phone,
                          validator: (v) {
                            if (v == null || v.trim().isEmpty) {
                              return LocaleKeys.validation_required.tr();
                            }
                            return null;
                          },
                        ),
                        14.height,
                        AuthFieldLabel(text: LocaleKeys.auth_email.tr()),
                        8.height,
                        CustomTextField(
                          hint: LocaleKeys.auth_emailPlaceholder.tr(),
                          controller: _emailCtrl,
                          keyboardType: TextInputType.emailAddress,
                          validator: (v) {
                            if (v == null || v.trim().isEmpty) {
                              return LocaleKeys.validation_required.tr();
                            }
                            if (!v.contains('@')) {
                              return LocaleKeys.validation_invalidEmail.tr();
                            }
                            return null;
                          },
                        ),
                        14.height,
                        AuthFieldLabel(text: LocaleKeys.auth_password.tr()),
                        8.height,
                        CustomTextField(
                          hint: LocaleKeys.auth_passwordPlaceholder.tr(),
                          controller: _passwordCtrl,
                          isPassword: true,
                          validator: (v) {
                            if (v == null || v.isEmpty) {
                              return LocaleKeys.validation_required.tr();
                            }
                            if (v.length < 6) {
                              return LocaleKeys.validation_shortPassword.tr();
                            }
                            return null;
                          },
                        ),
                        16.height,
                        const RegisterTermsNotice(),
                        22.height,
                        CustomButton(
                          title: LocaleKeys.auth_createAccountButton.tr(),
                          onTap: _submit,
                          loading: isLoading,
                        ),
                        18.height,
                        RegisterSignInFooter(
                          onTap: () => Navigator.pop(context),
                        ),
                        50.height,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/di/injection.dart';
import '../../../core/extensions/extensions.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/locale_keys.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/screen_header_bar.dart';
import '../logic/change_password_cubit.dart';
import '../widgets/account_edit_field.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  static const int _minPasswordLength = 6;

  final _formKey = GlobalKey<FormState>();
  late final ChangePasswordCubit _cubit = getIt<ChangePasswordCubit>();
  final _currentCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();

  @override
  void dispose() {
    _currentCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmCtrl.dispose();
    _cubit.close();
    super.dispose();
  }

  String? _requiredValidator(String? value) =>
      (value == null || value.isEmpty)
          ? LocaleKeys.validation_required.tr()
          : null;

  String? _newPasswordValidator(String? value) {
    final required = _requiredValidator(value);
    if (required != null) return required;
    if (value!.length < _minPasswordLength) {
      return LocaleKeys.validation_shortPassword.tr();
    }
    if (value == _currentCtrl.text) {
      return LocaleKeys.account_samePassword.tr();
    }
    return null;
  }

  String? _confirmValidator(String? value) {
    final required = _requiredValidator(value);
    if (required != null) return required;
    if (value != _passwordCtrl.text) {
      return LocaleKeys.account_passwordsMismatch.tr();
    }
    return null;
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) return;
    _cubit.changePassword(
      currentPassword: _currentCtrl.text,
      password: _passwordCtrl.text,
      passwordConfirmation: _confirmCtrl.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
      bloc: _cubit,
      listener: (context, state) {
        if (state is ChangePasswordSuccess) context.pop();
      },
      builder: (context, state) {
        return Scaffold(
          body: Column(
            children: [
              ScreenHeaderBar(title: LocaleKeys.account_changePassword.tr()),
              Expanded(
                child: Form(
                  key: _formKey,
                  child: ListView(
                    padding:
                        EdgeInsets.symmetric(horizontal: 19.w, vertical: 20.h),
                    children: [
                      AppText(
                        LocaleKeys.account_changePasswordSubtitle.tr(),
                        fontSize: 13.sp,
                        height: 1.6,
                        color: AppColors.textSecondaryColor.themeColor,
                      ),
                      20.height,
                      AccountEditField(
                        label: LocaleKeys.account_currentPassword.tr(),
                        hint: LocaleKeys.account_currentPasswordHint.tr(),
                        controller: _currentCtrl,
                        isPassword: true,
                        validator: _requiredValidator,
                      ),
                      16.height,
                      AccountEditField(
                        label: LocaleKeys.account_newPassword.tr(),
                        hint: LocaleKeys.account_newPasswordHint.tr(),
                        controller: _passwordCtrl,
                        isPassword: true,
                        validator: _newPasswordValidator,
                      ),
                      16.height,
                      AccountEditField(
                        label: LocaleKeys.account_confirmPassword.tr(),
                        hint: LocaleKeys.account_confirmPasswordHint.tr(),
                        controller: _confirmCtrl,
                        isPassword: true,
                        validator: _confirmValidator,
                      ),
                      32.height,
                      CustomButton(
                        title: LocaleKeys.account_changePassword.tr(),
                        loading: state is ChangePasswordLoading,
                        onTap: _submit,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

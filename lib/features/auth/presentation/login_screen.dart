import 'package:Silink/app/router/navigation_services.dart';
import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_images.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:Silink/features/auth/presentation/widgets/social_auth_buttons.dart';
import 'package:Silink/features/profile/logic/profile_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/router/routes.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/locale_keys.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text_field.dart';
import '../logic/auth_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    NavigationService.pushNamedAndRemoveUntil(Routes.layoutScreen);
    // if (!_formKey.currentState!.validate()) return;
    // context.read<AuthCubit>().login(
    //       email: _emailCtrl.text.trim(),
    //       password: _passwordCtrl.text,
    //     );
  }

  void _continueAsGuest() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      Routes.layoutScreen,
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          context.read<ProfileCubit>().getProfile();
          Navigator.pushNamedAndRemoveUntil(
              context, Routes.layoutScreen, (_) => false);
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
                        Center(
                          child: AppText(
                            LocaleKeys.auth_login.tr(),
                            fontSize: 24,
                            color: const Color(0xFF17212B),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        16.height,
                        Divider(
                            height: 1.h,
                            color: AppColors.textSecondaryColor.themeColor
                                .withValues(alpha: 0.30)),
                        16.height,
                        Container(
                          height: 40.h,
                          width: 110.w,
                          padding: EdgeInsets.all(6.w),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors.darkSlate.themeColor,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Image.asset(AppImages.logoApp),
                        ),
                        24.height,
                        AppText(
                          LocaleKeys.auth_welcome_back.tr(),
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w800,
                        ),
                        AppText(LocaleKeys.login_subtitle.tr(),
                            fontSize: 14.sp),
                        16.height,
                        _FieldLabel(text: LocaleKeys.auth_phone_or_email.tr()),
                        8.height,
                        CustomTextField(
                          hint: '05xxxxxxxx أو name@example.com',
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
                        _FieldLabel(text: LocaleKeys.auth_password.tr()),
                        8.height,
                        CustomTextField(
                          hint: LocaleKeys.enter_password.tr(),
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
                        12.height,
                        AppText(
                          LocaleKeys.forgot_your_password.tr(),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.mint.themeColor,
                        ),
                        22.height,
                        CustomButton(
                          title: LocaleKeys.auth_login.tr(),
                          onTap: _submit,
                          loading: isLoading,
                        ),
                        18.height,
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: const Color(0xFFD4D9D3),
                                thickness: 1,
                                endIndent: 8.w,
                              ),
                            ),
                            AppText(
                              LocaleKeys.auth_or.tr(),
                              fontSize: 14,
                              color: const Color(0xFF9AA19C),
                              fontWeight: FontWeight.w600,
                            ),
                            Expanded(
                              child: Divider(
                                color: const Color(0xFFD4D9D3),
                                thickness: 1,
                                indent: 8.w,
                              ),
                            ),
                          ],
                        ),
                        16.height,
                        SocialAuthButtons(),
                        16.height,
                        Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AppText(
                                LocaleKeys.auth_dontHaveAccount.tr(),
                                fontSize: 14.sp,
                              ),
                              4.width,
                              GestureDetector(
                                onTap: () => Navigator.pushNamed(
                                    context, Routes.registerScreen),
                                child: AppText(
                                  LocaleKeys.register_now.tr(),
                                  fontSize: 14.sp,
                                  color: AppColors.mint.themeColor,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        20.height,
                        _DashedGuestButton(
                          label:
                              '${LocaleKeys.guest.tr()} - ${LocaleKeys.explore_account.tr()}',
                          onTap: _continueAsGuest,
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

class _FieldLabel extends StatelessWidget {
  const _FieldLabel({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: AppText(
        text,
        fontSize: 14,
        color: AppColors.primaryColor.themeColor,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class _DashedGuestButton extends StatelessWidget {
  const _DashedGuestButton({
    required this.label,
    required this.onTap,
  });

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 54.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.white.themeColor,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: const Color(0xFFE2E8F0),
            width: 1,
          ),
        ),
        child: AppText(
          label,
          fontSize: 14.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

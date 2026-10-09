import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/router/routes.dart';
import '../../../core/extensions/extensions.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_constants.dart';
import '../../../core/utils/locale_keys.dart';
import '../../profile/logic/profile_cubit.dart';
import '../logic/auth_cubit.dart';
import 'widgets/auth_assurance_note.dart';
import 'widgets/auth_editorial_card.dart';
import 'widgets/auth_mode_tabs.dart';
import 'widgets/auth_top_bar.dart';
import 'widgets/login_form.dart';
import 'widgets/register_form.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key, this.startWithRegister = false});

  final bool startWithRegister;

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late bool _isRegister = widget.startWithRegister;

  void _setMode(bool isRegister) {
    if (_isRegister == isRegister) return;
    FocusScope.of(context).unfocus();
    setState(() => _isRegister = isRegister);
  }

  void _continueAsGuest() => Navigator.pushNamedAndRemoveUntil(
        context,
        Routes.layoutScreen,
        (_) => false,
      );

  void _onStateChanged(BuildContext context, AuthState state) {
    if (state is AuthSuccess) {
      context.read<ProfileCubit>().setUser(state.user);
      Navigator.pushNamedAndRemoveUntil(context, kHomeRoute, (_) => false);
    } else if (state is AuthRegistrationPending) {
      Navigator.pushNamed(
        context,
        Routes.otpScreen,
        arguments: {
          'destination': state.phone,
          'registrationId': state.registrationId,
          'expiresAt': state.expiresAt,
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: _onStateChanged,
      builder: (context, state) {
        final loading = state is AuthLoading;
        return Scaffold(
          backgroundColor: AppColors.backgroundColor.themeColor,
          body: SafeArea(
            child: Column(
              children: [
                const AuthTopBar(),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.fromLTRB(24.w, 9.h, 24.w, 27.h),
                    children: [
                      AuthEditorialCard(
                        eyebrow: _isRegister
                            ? LocaleKeys.auth_registerEyebrow.tr()
                            : LocaleKeys.auth_loginEyebrow.tr(),
                        title: _isRegister
                            ? LocaleKeys.auth_registerHeadline.tr()
                            : LocaleKeys.auth_loginHeadline.tr(),
                        body: _isRegister
                            ? LocaleKeys.auth_registerIntro.tr()
                            : LocaleKeys.auth_loginIntro.tr(),
                      ),
                      24.height,
                      AuthModeTabs(
                        isRegister: _isRegister,
                        onLoginTap: () => _setMode(false),
                        onRegisterTap: () => _setMode(true),
                      ),
                      22.height,
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 250),
                        switchInCurve: Curves.easeOut,
                        switchOutCurve: Curves.easeIn,
                        layoutBuilder: (current, previous) => Stack(
                          alignment: Alignment.topCenter,
                          children: [...previous, if (current != null) current],
                        ),
                        transitionBuilder: (child, animation) =>
                            FadeTransition(opacity: animation, child: child),
                        child: _isRegister
                            ? RegisterForm(
                                key: const ValueKey('register'),
                                loading: loading,
                              )
                            : LoginForm(
                                key: const ValueKey('login'),
                                loading: loading,
                                onGuest: _continueAsGuest,
                              ),
                      ),
                      const AuthAssuranceNote(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

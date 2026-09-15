import 'package:easy_localization/easy_localization.dart';
import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/app_overlay.dart';
import 'package:Silink/core/widgets/app_button.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/router/routes.dart';
import '../../../core/utils/locale_keys.dart';
import '../../profile/logic/profile_cubit.dart';
import 'widgets/otp_code_input.dart';
import 'widgets/otp_intro.dart';
import 'widgets/otp_resend_timer.dart';
import 'widgets/otp_top_bar.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key, required this.destination});

  final String destination;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  static const int _codeLength = 6;
  static const int _resendSeconds = 56;

  final _codeInputKey = GlobalKey<OtpCodeInputState>();

  String _code = '';
  bool _isVerifying = false;

  void _onCodeChanged(String value) {
    setState(() => _code = value);
  }

  void _resend() {
    _codeInputKey.currentState?.clear();
  }

  Future<void> _verify() async {
    if (_code.length < _codeLength) {
      AppOverlay.showError(LocaleKeys.otp_enterFullCode.tr());
      return;
    }
    setState(() => _isVerifying = true);
    await Future.delayed(const Duration(milliseconds: 400));
    if (!mounted) return;
    setState(() => _isVerifying = false);
    context.read<ProfileCubit>().getProfile();
    Navigator.pushNamedAndRemoveUntil(
        context, Routes.layoutScreen, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    final isComplete = _code.length == _codeLength;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 19.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              OtpTopBar(title: LocaleKeys.otp_title.tr()),
              32.height,
              OtpIntro(destination: widget.destination),
              32.height,
              OtpCodeInput(
                key: _codeInputKey,
                length: _codeLength,
                onChanged: _onCodeChanged,
              ),
              28.height,
              CustomButton(
                title: LocaleKeys.otp_verify.tr(),
                onTap: _verify,
                loading: _isVerifying,
                color: isComplete ? null : AppColors.dividerColor.themeColor,
                textColor: isComplete
                    ? null
                    : AppColors.textSecondaryColor.themeColor,
              ),
              18.height,
              Center(
                child: OtpResendTimer(
                  seconds: _resendSeconds,
                  onResend: _resend,
                ),
              ),
              const Spacer(),
              Center(
                child: GestureDetector(
                  onTap: () => Navigator.of(context).maybePop(),
                  child: AppText(
                    LocaleKeys.otp_changePhone.tr(),
                    fontSize: 12.sp,
                    color: AppColors.textSecondaryColor.themeColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              20.height,
            ],
          ),
        ),
      ),
    );
  }
}

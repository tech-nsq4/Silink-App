import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OtpResendTimer extends StatefulWidget {
  const OtpResendTimer({
    super.key,
    required this.seconds,
    required this.onResend,
  });

  final int seconds;
  final VoidCallback onResend;

  @override
  State<OtpResendTimer> createState() => _OtpResendTimerState();
}

class _OtpResendTimerState extends State<OtpResendTimer> {
  late int _remaining;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _remaining = widget.seconds;
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remaining <= 1) {
        timer.cancel();
        setState(() => _remaining = 0);
        return;
      }
      setState(() => _remaining -= 1);
    });
  }

  void _resend() {
    widget.onResend();
    setState(() => _remaining = widget.seconds);
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_remaining <= 0) {
      return GestureDetector(
        onTap: _resend,
        child: Text(
          LocaleKeys.otp_resendAction.tr(),
          style: TextStyle(
            fontFamily: 'Tajawal',
            fontSize: 13.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.mint.themeColor,
          ),
        ),
      );
    }

    final baseStyle = TextStyle(
      fontFamily: 'Tajawal',
      fontSize: 13.sp,
      fontWeight: FontWeight.w500,
      color: AppColors.textSecondaryColor.themeColor,
    );

    return Text.rich(
      TextSpan(
        style: baseStyle,
        children: [
          TextSpan(text: '${LocaleKeys.otp_resendPrefix.tr()} '),
          TextSpan(
            text: '$_remaining',
            style: baseStyle.copyWith(
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimaryColor.themeColor,
            ),
          ),
          TextSpan(text: ' ${LocaleKeys.otp_resendSuffix.tr()}'),
        ],
      ),
    );
  }
}

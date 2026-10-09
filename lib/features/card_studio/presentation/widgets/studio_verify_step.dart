import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../auth/presentation/widgets/otp_code_input.dart';
import '../../../auth/presentation/widgets/otp_resend_timer.dart';
import 'studio_editor_heading.dart';

class StudioVerifyStep extends StatefulWidget {
  const StudioVerifyStep({
    super.key,
    required this.phone,
    required this.codeLength,
    required this.onChanged,
    this.expiresAt,
  });

  static const int _defaultResendSeconds = 56;

  final String phone;
  final int codeLength;
  final DateTime? expiresAt;
  final ValueChanged<String> onChanged;

  @override
  State<StudioVerifyStep> createState() => _StudioVerifyStepState();
}

class _StudioVerifyStepState extends State<StudioVerifyStep> {
  final _codeKey = GlobalKey<OtpCodeInputState>();

  int get _resendSeconds {
    final expiresAt = widget.expiresAt;
    if (expiresAt == null) return StudioVerifyStep._defaultResendSeconds;
    final diff = expiresAt.difference(DateTime.now()).inSeconds;
    return diff > 0 ? diff : StudioVerifyStep._defaultResendSeconds;
  }

  void _resend() {
    _codeKey.currentState?.clear();
    widget.onChanged('');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        StudioEditorHeading(
          title: LocaleKeys.cardStudio_verifyTitle.tr(),
          subtitle: LocaleKeys.cardStudio_verifySubtitle.tr(),
        ),
        Container(
          padding: EdgeInsets.all(17.w),
          decoration: BoxDecoration(
            color: AppColors.white.themeColor,
            borderRadius: BorderRadius.circular(15.r),
            border: Border.all(color: AppColors.studioPanelBorder.themeColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Icon(Icons.sms_outlined,
                      size: 16.sp, color: AppColors.accentTeal.themeColor),
                  8.width,
                  Expanded(
                    child: AppText(
                      LocaleKeys.cardStudio_verifySentTo.tr(),
                      fontSize: 10.sp,
                      color: AppColors.studioFieldLabel.themeColor,
                    ),
                  ),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: AppText(
                      widget.phone,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Directionality(
                textDirection: TextDirection.ltr,
                child: OtpCodeInput(
                  key: _codeKey,
                  length: widget.codeLength,
                  onChanged: widget.onChanged,
                ),
              ),
              SizedBox(height: 18.h),
              Center(
                child: OtpResendTimer(
                  seconds: _resendSeconds,
                  onResend: _resend,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        AppText(
          LocaleKeys.cardStudio_verifyNote.tr(),
          fontSize: 9.sp,
          height: 1.8,
          color: AppColors.studioNote.themeColor,
        ),
      ],
    );
  }
}

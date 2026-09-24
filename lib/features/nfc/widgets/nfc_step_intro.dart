import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/extensions/extensions.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/locale_keys.dart';
import '../../../core/widgets/app_text.dart';
import 'nfc_common.dart';

class NfcStepIntro extends StatelessWidget {
  const NfcStepIntro({
    super.key,
    required this.onEnterSerial,
    required this.onScanQr,
  });

  final VoidCallback onEnterSerial;
  final VoidCallback onScanQr;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Container(
            width: 88.w,
            height: 88.w,
            decoration: BoxDecoration(
              color: AppColors.blue.themeColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(26.r),
            ),
            child: Icon(
              Icons.credit_card_rounded,
              size: 42.sp,
              color: AppColors.blue.themeColor,
            ),
          ),
        ),
        16.height,
        Center(
          child: AppText(
            LocaleKeys.company_nfc_intro_title.tr(),
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        8.height,
        Center(
          child: AppText(
            LocaleKeys.company_nfc_intro_desc.tr(),
            fontSize: 13.sp,
            color: AppColors.textSecondaryColor.themeColor,
            textAlign: TextAlign.center,
            height: 1.5,
          ),
        ),
        20.height,
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(14.w),
          decoration: BoxDecoration(
            color: AppColors.cardColor.themeColor,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: AppColors.borderColor.themeColor),
          ),
          child: Column(
            children: [
              NfcRequirementRow(text: LocaleKeys.company_nfc_req1.tr()),
              10.height,
              NfcRequirementRow(text: LocaleKeys.company_nfc_req2.tr()),
            ],
          ),
        ),
        20.height,
        NfcPrimaryButton(
          label: LocaleKeys.company_enter_serial.tr(),
          onTap: onEnterSerial,
        ),
        10.height,
        NfcSecondaryButton(
          label: LocaleKeys.company_scan_serial_qr.tr(),
          onTap: onScanQr,
        ),
      ],
    );
  }
}
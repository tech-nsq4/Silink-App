import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/extensions/extensions.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/locale_keys.dart';
import '../../../core/widgets/app_text.dart';
import 'nfc_common.dart';

class NfcStepConfirm extends StatelessWidget {
  const NfcStepConfirm({
    super.key,
    required this.serial,
    required this.onActivate,
    required this.onBack,
    this.profileName = 'Silink',
  });

  final String serial;
  final VoidCallback onActivate;
  final VoidCallback onBack;
  final String profileName;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          LocaleKeys.company_confirm_activation.tr(),
          fontSize: 18.sp,
          fontWeight: FontWeight.w700,
        ),
        16.height,
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: AppColors.cardColor.themeColor,
            borderRadius: BorderRadius.circular(18.r),
            border: Border.all(color: AppColors.borderColor.themeColor),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 12,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              NfcKeyValueRow(
                label: LocaleKeys.company_product_label.tr(),
                value: LocaleKeys.company_nfc_product_name.tr(),
              ),
              Directionality(
                textDirection: ui.TextDirection.ltr,
                child: NfcKeyValueRow(
                  label: LocaleKeys.company_serial_label.tr(),
                  value: serial,
                ),
              ),
              NfcKeyValueRow(
                label: LocaleKeys.company_linked_profile_label.tr(),
                value: profileName,
              ),
            ],
          ),
        ),
        20.height,
        NfcPrimaryButton(
          label: LocaleKeys.company_activate_button.tr(),
          onTap: onActivate,
        ),
        10.height,
        NfcSecondaryButton(
          label: LocaleKeys.company_back_button.tr(),
          onTap: onBack,
        ),
      ],
    );
  }
}

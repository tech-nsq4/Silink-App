import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/extensions/extensions.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/locale_keys.dart';
import '../../../core/widgets/app_text.dart';
import 'nfc_common.dart';

class NfcStepSerial extends StatelessWidget {
  const NfcStepSerial({
    super.key,
    required this.controller,
    required this.error,
    required this.onChanged,
    required this.onVerify,
  });

  final TextEditingController controller;
  final String? error;
  final ValueChanged<String> onChanged;
  final VoidCallback onVerify;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          LocaleKeys.company_serial_label.tr(),
          fontSize: 17.sp,
          fontWeight: FontWeight.w700,
        ),
        4.height,
        AppText(
          LocaleKeys.company_serial_hint.tr(),
          fontSize: 12.sp,
          color: AppColors.textSecondaryColor.themeColor,
        ),
        16.height,
        TextField(
          controller: controller,
          textCapitalization: TextCapitalization.characters,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: LocaleKeys.company_serial_placeholder.tr(),
            isDense: true,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
            filled: true,
            fillColor: AppColors.fieldFill,
            errorText: error,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: error == null
                  ? BorderSide.none
                  : const BorderSide(color: Color(0xFFEF4444)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide:
                  BorderSide(color: AppColors.blue.themeColor, width: 1.2),
            ),
          ),
        ),
        20.height,
        NfcPrimaryButton(
          label: LocaleKeys.company_verify_serial.tr(),
          onTap: onVerify,
        ),
      ],
    );
  }
}

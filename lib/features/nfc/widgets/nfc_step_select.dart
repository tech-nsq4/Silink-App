import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/extensions/extensions.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/locale_keys.dart';
import '../../../core/widgets/app_text.dart';
import 'nfc_common.dart';

class NfcStepSelect extends StatelessWidget {
  const NfcStepSelect({
    super.key,
    required this.onConfirm,
    this.profileName = 'Silink',
  });

  final VoidCallback onConfirm;

  /// Hardcoded to 'Silink' in the original screen — there was only ever one
  /// profile to pick. Exposed as a param in case a real profile list is
  /// wired in later.
  final String profileName;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.check_circle_rounded,
              size: 18.sp,
              color: const Color(0xFF0D9488),
            ),
            8.width,
            Expanded(
              child: AppText(
                LocaleKeys.company_select_profile.tr(),
                fontSize: 15.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        16.height,
        Container(
          padding: EdgeInsets.all(14.w),
          decoration: BoxDecoration(
            color: const Color(0xFFF0FDFA),
            borderRadius: BorderRadius.circular(18.r),
            border: Border.all(color: const Color(0xFF0D9488), width: 2),
          ),
          child: Row(
            children: [
              Container(
                width: 50.w,
                height: 50.w,
                decoration: BoxDecoration(
                  color: AppColors.blue.themeColor,
                  borderRadius: BorderRadius.circular(14.r),
                ),
                alignment: Alignment.center,
                child: AppText(
                  profileName.isEmpty ? '?' : profileName[0],
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              12.width,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      profileName,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    2.height,
                    AppText(
                      LocaleKeys.company_my_profile_fallback.tr(),
                      fontSize: 12.sp,
                      color: AppColors.textSecondaryColor.themeColor,
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.check_circle_rounded,
                size: 20.sp,
                color: const Color(0xFF0D9488),
              ),
            ],
          ),
        ),
        20.height,
        NfcPrimaryButton(
          label: LocaleKeys.company_confirm_activation.tr(),
          onTap: onConfirm,
        ),
      ],
    );
  }
}
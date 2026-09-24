import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/extensions/extensions.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/locale_keys.dart';
import '../../../core/widgets/app_text.dart';
import 'nfc_common.dart';

class NfcStepDone extends StatelessWidget {
  const NfcStepDone({
    super.key,
    required this.activatedAt,
    required this.onBackHome,
    this.profileName = 'Silink',
  });

  final String activatedAt;
  final VoidCallback onBackHome;
  final String profileName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16.h),
      child: Column(
        children: [
          Container(
            width: 88.w,
            height: 88.w,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Color(0xFFF0FDFA), Color(0xFFDCFCE7)],
              ),
            ),
            child: Icon(
              Icons.check_circle_outline_rounded,
              size: 46.sp,
              color: const Color(0xFF0D9488),
            ),
          ),
          20.height,
          AppText(
            LocaleKeys.company_activation_done.tr(),
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
          ),
          6.height,
          AppText(
            LocaleKeys.company_activation_done_desc.tr(),
            fontSize: 14.sp,
            color: AppColors.textSecondaryColor.themeColor,
          ),
          20.height,
          Container(
            width: double.infinity,
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
                NfcKeyValueRow(
                  label: LocaleKeys.company_status_active_short.tr(),
                  value: LocaleKeys.company_status_active.tr(),
                  valueColor: const Color(0xFF0D9488),
                ),
                NfcKeyValueRow(
                  label: LocaleKeys.company_linked_profile_label.tr(),
                  value: profileName,
                ),
                NfcKeyValueRow(
                  label: LocaleKeys.company_activation_date.tr(),
                  value: activatedAt,
                ),
              ],
            ),
          ),
          20.height,
          NfcPrimaryButton(
            label: LocaleKeys.company_back_home.tr(),
            onTap: onBackHome,
          ),
        ],
      ),
    );
  }
}
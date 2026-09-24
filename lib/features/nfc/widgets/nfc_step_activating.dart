import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/extensions/extensions.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/locale_keys.dart';
import '../../../core/widgets/app_text.dart';

class NfcStepActivating extends StatelessWidget {
  const NfcStepActivating({super.key, required this.progress});

  /// 0-100
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 50.h),
      child: Column(
        children: [
          Container(
            width: 96.w,
            height: 96.w,
            decoration: BoxDecoration(
              color: AppColors.blue.themeColor.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(28.r),
            ),
            child: Icon(
              Icons.credit_card_rounded,
              size: 44.sp,
              color: const Color(0xFF0D9488),
            ),
          ),
          22.height,
          AppText(
            LocaleKeys.company_activating.tr(),
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
          ),
          4.height,
          AppText(
            LocaleKeys.company_activating_desc.tr(),
            fontSize: 13.sp,
            color: AppColors.textSecondaryColor.themeColor,
          ),
          24.height,
          ClipRRect(
            borderRadius: BorderRadius.circular(99.r),
            child: LinearProgressIndicator(
              value: progress / 100,
              minHeight: 8.h,
              backgroundColor: const Color(0xFFE2E8F0),
              valueColor: AlwaysStoppedAnimation<Color>(
                AppColors.blue.themeColor,
              ),
            ),
          ),
          8.height,
          AppText(
            '${progress.toInt()}%',
            fontSize: 13.sp,
            color: const Color(0xFF94A3B8),
          ),
        ],
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/extensions/extensions.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/locale_keys.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../core/widgets/custom_tap_effect.dart';

class HubTeamInviteCard extends StatelessWidget {
  const HubTeamInviteCard({
    super.key,
    required this.memberNames,
    required this.onAdd,
  });

  final List<String> memberNames;
  final VoidCallback onAdd;

  Widget _bubble(String text, Color color) => Container(
        width: 26.w,
        height: 26.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.white.themeColor, width: 2),
        ),
        child: AppText(text, fontSize: 9.sp, fontWeight: FontWeight.w700),
      );

  @override
  Widget build(BuildContext context) {
    final accent = AppColors.accentTeal.themeColor;
    final tints = [
      accent.withValues(alpha: 0.3),
      AppColors.accentBlue.themeColor.withValues(alpha: 0.25),
      AppColors.accentGold.themeColor.withValues(alpha: 0.3),
    ];
    final initials = [
      for (final name in memberNames.take(3))
        if (name.trim().isNotEmpty) name.trim().characters.first,
    ];
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 22.h, 20.w, 20.h),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: accent.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          Directionality(
            textDirection: TextDirection.ltr,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _bubble('+', AppColors.white.themeColor),
                for (final (index, initial) in initials.indexed) ...[
                  SizedBox(width: 2.w),
                  _bubble(initial, tints[index % tints.length]),
                ],
              ],
            ),
          ),
          SizedBox(height: 14.h),
          AppText(
            LocaleKeys.companyHub_teamTitle.tr(),
            fontSize: 13.sp,
            fontWeight: FontWeight.w800,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h),
          AppText(
            LocaleKeys.companyHub_teamSubtitle.tr(),
            fontSize: 8.5.sp,
            textAlign: TextAlign.center,
            color: AppColors.textSecondaryColor.themeColor,
          ),
          SizedBox(height: 16.h),
          CustomTapEffect(
            onTap: onAdd,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 13.h),
              decoration: BoxDecoration(
                color: AppColors.white.themeColor,
                borderRadius: BorderRadius.circular(14.r),
                border:
                    Border.all(color: AppColors.studioPanelBorder.themeColor),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_rounded, size: 17.sp, color: accent),
                  8.width,
                  AppText(
                    LocaleKeys.companyHub_addMember.tr(),
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w800,
                    color: accent,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

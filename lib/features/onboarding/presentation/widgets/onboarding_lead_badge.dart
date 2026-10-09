import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_text.dart';
import 'onboarding_float_card.dart';

class OnboardingLeadBadge extends StatelessWidget {
  const OnboardingLeadBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return OnboardingFloatCard(
      padding: 13,
      radius: 13,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 29,
            height: 29,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.leadAvatarBackground.themeColor,
              shape: BoxShape.circle,
            ),
            child: AppText(
              LocaleKeys.onboarding_leadInitial.tr(),
              fontSize: 11,
              color: AppColors.leadAvatarText.themeColor,
            ),
          ),
          const SizedBox(width: 9),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                LocaleKeys.onboarding_leadTitle.tr(),
                fontSize: 9,
                fontWeight: FontWeight.w700,
              ),
              const SizedBox(height: 4),
              AppText(
                LocaleKeys.onboarding_leadSubtitle.tr(),
                fontSize: 7,
                color: AppColors.leadMuted.themeColor,
              ),
            ],
          ),
          const SizedBox(width: 9),
          Icon(
            Icons.add_rounded,
            size: 15,
            color: AppColors.accentTeal.themeColor,
          ),
        ],
      ),
    );
  }
}

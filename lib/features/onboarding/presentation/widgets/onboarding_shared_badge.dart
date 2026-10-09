import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_text.dart';
import 'onboarding_float_card.dart';

class OnboardingSharedBadge extends StatelessWidget {
  const OnboardingSharedBadge({super.key});

  @override
  Widget build(BuildContext context) {
    final accent = AppColors.accentTeal.themeColor;
    return OnboardingFloatCard(
      padding: 12,
      radius: 12,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.contactless_outlined, size: 22, color: accent),
          const SizedBox(width: 8),
          AppText(
            LocaleKeys.onboarding_cardShared.tr(),
            fontSize: 9,
            color: accent,
          ),
          const SizedBox(width: 8),
          Icon(Icons.check_rounded, size: 14, color: accent),
        ],
      ),
    );
  }
}

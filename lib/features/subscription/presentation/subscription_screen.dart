import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/extensions/extensions.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_overlay.dart';
import '../../../core/utils/locale_keys.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/screen_header_bar.dart';
import '../widgets/plan_card.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ScreenHeaderBar(title: LocaleKeys.account_subscriptionTitle.tr()),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 19.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // ─── Current plan ──────────────────────────────────────
                  PlanCard(
                    label: LocaleKeys.account_currentPlanLabel.tr(),
                    title: 'خطة مجاني',
                    badge: LocaleKeys.account_activeBadge.tr(),
                    badgeColor: const Color(0x1064748B),
                    price: LocaleKeys.account_freePlanPrice.tr(),
                    period: LocaleKeys.account_pricePerMonth.tr(),
                    isCurrent: true,
                    backgroundColor: const Color(0x1064748B),
                    features: _freeFeatures,
                  ),
                  20.height,
                  // ─── Plans comparison ─────────────────────────────────
                  _SectionTitle(LocaleKeys.account_comparePlans.tr()),
                  10.height,
                  PlanCard(
                    title: LocaleKeys.account_freePlanCard.tr(),
                    badge: LocaleKeys.account_yourCurrentPlan.tr(),
                    badgeColor: AppColors.textSecondaryColor.themeColor,
                    price: LocaleKeys.account_freePlanFree.tr(),
                    priceColor: AppColors.textSecondaryColor.themeColor,
                    features: _freeFeatures,
                  ),
                  12.height,
                  PlanCard(
                    title: LocaleKeys.account_professionalPlan.tr(),
                    badge: LocaleKeys.account_upgradeChip.tr(),
                    badgeColor: AppColors.mint.themeColor,
                    onBadgeTap: _comingSoon,
                    price: LocaleKeys.account_professionalPrice.tr(),
                    period: LocaleKeys.account_pricePerMonth.tr(),
                    features: [
                      LocaleKeys.account_professionalFeature1.tr(),
                      LocaleKeys.account_professionalFeature2.tr(),
                      LocaleKeys.account_professionalFeature3.tr(),
                      LocaleKeys.account_professionalFeature4.tr(),
                      LocaleKeys.account_professionalFeature5.tr(),
                    ],
                  ),
                  12.height,
                  PlanCard(
                    title: LocaleKeys.account_businessPlan.tr(),
                    badge: LocaleKeys.account_upgradeChip.tr(),
                    badgeColor: AppColors.purple.themeColor,
                    onBadgeTap: _comingSoon,
                    price: LocaleKeys.account_businessPrice.tr(),
                    period: LocaleKeys.account_pricePerMonth.tr(),
                    features: [
                      LocaleKeys.account_businessFeature1.tr(),
                      LocaleKeys.account_businessFeature2.tr(),
                      LocaleKeys.account_businessFeature3.tr(),
                      LocaleKeys.account_businessFeature4.tr(),
                    ],
                  ),
                  24.height,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _comingSoon() =>
      AppOverlay.showSuccess(LocaleKeys.common_comingSoon.tr());

  List<String> get _freeFeatures => [
        LocaleKeys.account_freeFeature1.tr(),
        LocaleKeys.account_freeFeature2.tr(),
        LocaleKeys.account_freeFeature3.tr(),
        LocaleKeys.account_freeFeature4.tr(),
      ];
}

/// Bold section label placed above a group of cards.
class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 4.w),
      child: AppText(
        title,
        fontSize: 15.sp,
        fontWeight: FontWeight.w800,
      ),
    );
  }
}

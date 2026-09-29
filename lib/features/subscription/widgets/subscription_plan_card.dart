import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/convert_helper.dart';
import '../../../core/utils/locale_keys.dart';
import '../data/models/subscription_plan.dart';
import 'plan_card.dart';

class SubscriptionPlanCard extends StatelessWidget {
  const SubscriptionPlanCard({
    super.key,
    required this.plan,
    required this.accentColor,
    this.onUpgrade,
  });

  final SubscriptionPlan plan;
  final Color accentColor;
  final VoidCallback? onUpgrade;

  @override
  Widget build(BuildContext context) {
    final price = ConvertHelper.formatPrice(plan.price);

    return PlanCard(
      title: plan.localizedName(context.locale.languageCode),
      badge: LocaleKeys.account_upgradeChip.tr(),
      badgeColor: accentColor,
      onBadgeTap: onUpgrade,
      price: '$price ${LocaleKeys.store_currency.tr()}',
      period: plan.isYearly
          ? LocaleKeys.account_pricePerYear.tr()
          : LocaleKeys.account_pricePerMonth.tr(),
      features: plan.features,
    );
  }
}

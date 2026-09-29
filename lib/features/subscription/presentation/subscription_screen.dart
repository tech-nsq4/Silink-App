import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/di/injection.dart';
import '../../../core/extensions/extensions.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_overlay.dart';
import '../../../core/utils/locale_keys.dart';
import '../../../core/widgets/screen_header_bar.dart';
import '../../../core/widgets/screen_state_layout.dart';
import '../data/models/subscription_plan.dart';
import '../logic/subscription_cubit.dart';
import '../widgets/plan_card.dart';
import '../widgets/plan_section_title.dart';
import '../widgets/subscription_plan_card.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  late final SubscriptionCubit _cubit = getIt<SubscriptionCubit>()
    ..getSubscriptions();

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  void _comingSoon() =>
      AppOverlay.showSuccess(LocaleKeys.common_comingSoon.tr());

  List<String> get _freeFeatures => [
        LocaleKeys.account_freeFeature1.tr(),
        LocaleKeys.account_freeFeature2.tr(),
        LocaleKeys.account_freeFeature3.tr(),
        LocaleKeys.account_freeFeature4.tr(),
      ];

  List<Color> get _planAccents => [
        AppColors.mint.themeColor,
        AppColors.purple.themeColor,
        AppColors.accentGold.themeColor,
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ScreenHeaderBar(title: LocaleKeys.account_subscriptionTitle.tr()),
          Expanded(
            child: BlocBuilder<SubscriptionCubit, SubscriptionState>(
              bloc: _cubit,
              builder: (context, state) {
                final plans = state is SubscriptionSuccess
                    ? state.plans
                    : const <SubscriptionPlan>[];

                return CustomScreenStateLayout(
                  isLoading: state is SubscriptionInitial ||
                      state is SubscriptionLoading,
                  error: state is SubscriptionError
                      ? ErrorModel(
                          code: ErrorEnum.otherError,
                          errorMessage: state.message,
                        )
                      : null,
                  onRetry: _cubit.getSubscriptions,
                  onRefresh: _cubit.refresh,
                  builder: (context) => _buildContent(plans),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(List<SubscriptionPlan> plans) {
    final accents = _planAccents;

    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 19.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PlanCard(
            label: LocaleKeys.account_currentPlanLabel.tr(),
            title: LocaleKeys.account_freePlanCard.tr(),
            badge: LocaleKeys.account_activeBadge.tr(),
            badgeColor: const Color(0x1064748B),
            price: LocaleKeys.account_freePlanPrice.tr(),
            period: LocaleKeys.account_pricePerMonth.tr(),
            isCurrent: true,
            backgroundColor: const Color(0x1064748B),
            features: _freeFeatures,
          ),
          20.height,
          PlanSectionTitle(LocaleKeys.account_comparePlans.tr()),
          10.height,
          PlanCard(
            title: LocaleKeys.account_freePlanCard.tr(),
            badge: LocaleKeys.account_yourCurrentPlan.tr(),
            badgeColor: AppColors.textSecondaryColor.themeColor,
            price: LocaleKeys.account_freePlanFree.tr(),
            priceColor: AppColors.textSecondaryColor.themeColor,
            features: _freeFeatures,
          ),
          for (var i = 0; i < plans.length; i++) ...[
            12.height,
            SubscriptionPlanCard(
              plan: plans[i],
              accentColor: accents[i % accents.length],
              onUpgrade: _comingSoon,
            ),
          ],
          24.height,
        ],
      ),
    );
  }
}

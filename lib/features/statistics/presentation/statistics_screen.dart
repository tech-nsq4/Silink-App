import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/screen_header_bar.dart';
import '../models/ranked_metric.dart';
import 'widgets/performance_summary_card.dart';
import 'widgets/period_filter_tabs.dart';
import 'widgets/profile_stats_footer_card.dart';
import 'widgets/ranked_metric_list_card.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  StatsPeriod _period = StatsPeriod.last7Days;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ScreenHeaderBar(title: LocaleKeys.stats_title.tr()),
          Padding(
            padding: 12.paddingVert + 19.paddingHorizontal,
            child: PeriodFilterTabs(
              selected: _period,
              onChanged: (p) => setState(() => _period = p),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 19.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  PerformanceSummaryCard(
                    title: LocaleKeys.stats_summary_title.tr(),
                    rows: [
                      SummaryRow(
                          label: LocaleKeys.stats_total_visits.tr(),
                          value: '13'),
                      SummaryRow(
                          label: LocaleKeys.stats_unique_visitors.tr(),
                          value: '13'),
                      SummaryRow(
                          label: LocaleKeys.stats_contact_saved.tr(),
                          value: '2'),
                      SummaryRow(
                          label: LocaleKeys.stats_potential_clients.tr(),
                          value: '2'),
                      SummaryRow(
                        label: LocaleKeys.stats_conversion_rate.tr(),
                        value: '15.4%',
                        valueColor: AppColors.statsAccentGreen,
                      ),
                    ],
                  ),
                  16.height,
                  RankedMetricListCard(
                    title: LocaleKeys.stats_visit_sources.tr(),
                    items: [
                      RankedMetric(
                          label: LocaleKeys.stats_source_nfc.tr(),
                          value: '7',
                          percent: 0.54),
                      RankedMetric(
                          label: LocaleKeys.stats_source_qr.tr(),
                          value: '4',
                          percent: 0.31),
                      RankedMetric(
                          label: LocaleKeys.stats_source_direct.tr(),
                          value: '2',
                          percent: 0.15),
                    ],
                  ),
                  20.height,
                  RankedMetricListCard(
                    title: LocaleKeys.stats_link_interaction.tr(),
                    items: [
                      RankedMetric(
                          label: LocaleKeys.stats_source_whatsapp.tr(),
                          value: '4',
                          percent: 0.44),
                      RankedMetric(
                          label: LocaleKeys.stats_source_call.tr(),
                          value: '2',
                          percent: 0.22),
                      RankedMetric(
                          label: LocaleKeys.stats_source_website.tr(),
                          value: '1',
                          percent: 0.11),
                      RankedMetric(
                          label: LocaleKeys.stats_source_email.tr(),
                          value: '1',
                          percent: 0.11),
                      RankedMetric(
                          label: LocaleKeys.stats_source_booking.tr(),
                          value: '1',
                          percent: 0.11),
                    ],
                  ),
                  20.height,
                  ProfileStatsFooterCard(
                    title: LocaleKeys.stats_profile_performance.tr(),
                    profileName: 'حازم العتيبي',
                    stats: [
                      ProfileStatBox(
                          value: '13', label: LocaleKeys.stats_visit.tr()),
                      ProfileStatBox(
                          value: '2', label: LocaleKeys.stats_client.tr()),
                      ProfileStatBox(
                          value: '2', label: LocaleKeys.stats_saved.tr()),
                      ProfileStatBox(
                          value: '15.4%',
                          label: LocaleKeys.stats_conversion.tr()),
                    ],
                  ),
                  12.height,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

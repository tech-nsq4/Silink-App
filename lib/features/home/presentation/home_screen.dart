import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/locale_keys.dart';
import '../models/activity_item.dart';
import '../../profile_completion/models/profile_completion_data.dart';
import 'widgets/header.dart';
import 'widgets/my_cards_section.dart';
import 'widgets/potential_clients_section.dart';
import 'widgets/profile_completion_card.dart';
import 'widgets/profile_overview_card.dart';
import 'widgets/recent_activity_section.dart';
import 'widgets/store_banner.dart';

class _NoStretchScrollBehavior extends MaterialScrollBehavior {
  const _NoStretchScrollBehavior();

  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child;
  }

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const ClampingScrollPhysics();
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, this.cardData});

  final ProfileCompletionData? cardData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(19.w, 16.h, 19.w, 6),
              child: const Header(userName: 'حازم العتيبي'),
            ),
            Expanded(
              child: ScrollConfiguration(
                behavior: const _NoStretchScrollBehavior(),
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(19.w, 20.h, 19.w, 16.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const ProfileOverviewCard(
                        name: 'حازم العتيبي',
                        jobTitle: 'مدير تطوير الأعمال',
                        company: 'شركة الرؤية التقنية',
                        initials: 'حا',
                        isActive: true,
                        conversionRate: '0.0%',
                        potentialClients: '0',
                        visits: '36',
                      ),
                      16.height,
                      const ProfileCompletionCard(percent: 0.78),
                      16.height,
                      MyCardsSection(cardData: cardData),
                      16.height,
                      const StoreBanner(),
                      16.height,
                      const RecentActivitySection(
                        activities: [
                          ActivityItem(
                            icon: AppImages.iconsPreview,
                            iconColor: Color(0xFF2F6FED),
                            iconBackground: Color(0xFFE9F1FF),
                            titleKey: LocaleKeys.home_activity_profile_visit,
                            subjectName: 'حازم العتيبي',
                            hoursAgo: 8,
                          ),
                          ActivityItem(
                            icon: AppImages.iconsShare,
                            iconColor: Color(0xFF8B5CF6),
                            iconBackground: Color(0xFFF1EBFF),
                            titleKey: LocaleKeys.home_activity_link_interaction,
                            subjectName: 'حازم العتيبي',
                            hoursAgo: 11,
                          ),
                          ActivityItem(
                            icon: AppImages.iconsShare,
                            iconColor: Color(0xFF8B5CF6),
                            iconBackground: Color(0xFFF1EBFF),
                            titleKey: LocaleKeys.home_activity_contact_saved,
                            subjectName: 'حازم العتيبي',
                            hoursAgo: 16,
                          ),
                        ],
                      ),
                      16.height,
                      const PotentialClientsSection(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

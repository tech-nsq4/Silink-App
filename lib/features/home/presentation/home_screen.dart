import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_images.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/locale_keys.dart';
import '../../profile/logic/profile_cubit.dart';
import '../models/activity_item.dart';
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

String _initialsFor(String name) {
  final words =
      name.trim().split(' ').where((word) => word.isNotEmpty).take(2).toList();
  if (words.isEmpty) return '?';
  return words.map((word) => word[0].toUpperCase()).join();
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        final user = state is ProfileSuccess ? state.user : null;
        final displayName = user != null && user.fullName.trim().isNotEmpty
            ? user.fullName
            : LocaleKeys.profile_title.tr();
        final initials = _initialsFor(displayName);

        return Scaffold(
          backgroundColor: const Color(0xFFF7F8FA),
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(19.w, 16.h, 19.w, 6),
                  child: Header(userName: user?.fullName.trim() ?? ''),
                ),
                Expanded(
                  child: ScrollConfiguration(
                    behavior: const _NoStretchScrollBehavior(),
                    child: SingleChildScrollView(
                      padding: EdgeInsets.fromLTRB(19.w, 20.h, 19.w, 16.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ProfileOverviewCard(
                            name: displayName,
                            jobTitle: user?.jobTitle ?? '',
                            company: user?.company ?? '',
                            initials: initials,
                            photoUrl: user?.photoUrl,
                            isActive: user?.status == 'active',
                            conversionRate: '0.0%',
                            potentialClients: '0',
                            visits: '36',
                          ),
                          16.height,
                          const ProfileCompletionCard(percent: 0.78),
                          16.height,
                          const MyCardsSection(),
                          16.height,
                          const StoreBanner(),
                          16.height,
                          RecentActivitySection(
                            activities: [
                              ActivityItem(
                                icon: AppImages.iconsPreview,
                                iconColor: const Color(0xFF2F6FED),
                                iconBackground: const Color(0xFFE9F1FF),
                                titleKey:
                                    LocaleKeys.home_activity_profile_visit,
                                subjectName: displayName,
                                hoursAgo: 8,
                              ),
                              ActivityItem(
                                icon: AppImages.iconsShare,
                                iconColor: const Color(0xFF8B5CF6),
                                iconBackground: const Color(0xFFF1EBFF),
                                titleKey:
                                    LocaleKeys.home_activity_link_interaction,
                                subjectName: displayName,
                                hoursAgo: 11,
                              ),
                              ActivityItem(
                                icon: AppImages.iconsShare,
                                iconColor: const Color(0xFF8B5CF6),
                                iconBackground: const Color(0xFFF1EBFF),
                                titleKey:
                                    LocaleKeys.home_activity_contact_saved,
                                subjectName: displayName,
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
      },
    );
  }
}

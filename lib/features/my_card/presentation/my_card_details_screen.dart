import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/app_overlay.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:Silink/core/widgets/screen_header_bar.dart';
import 'package:Silink/features/my_card/models/my_card_model.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/my_card_details_widgets.dart';
import '../widgets/my_card_hero_card.dart';

class MyCardDetailsScreen extends StatelessWidget {
  const MyCardDetailsScreen({super.key, required this.card});

  final MyCardModel card;

  String get _statusLabel {
    switch (card.status) {
      case CardLifecycleStatus.active:
        return LocaleKeys.myCards_statusActive.tr();
      case CardLifecycleStatus.draft:
        return LocaleKeys.myCards_statusDraft.tr();
      case CardLifecycleStatus.paused:
        return LocaleKeys.myCards_statusPaused.tr();
    }
  }

  String get _categoryLabel {
    switch (card.category) {
      case CardCategory.business:
        return LocaleKeys.myCards_categoryBusiness.tr();
      case CardCategory.personal:
        return LocaleKeys.myCards_categoryPersonal.tr();
      case CardCategory.freelancer:
        return LocaleKeys.myCards_categoryFreelancer.tr();
    }
  }

  List<String> get _categoryLabels =>
      card.categoryNames?.where((n) => n.trim().isNotEmpty).toList() ??
      [_categoryLabel];

  String _formatDate(DateTime date) {
    return '${date.year}/${date.month}/${date.day}';
  }

  void _copyLink() {
    Clipboard.setData(ClipboardData(text: card.link));
    AppOverlay.showSuccess(LocaleKeys.publish_linkCopied.tr());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ScreenHeaderBar(title: LocaleKeys.myCards_detailsTitle.tr()),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  MyCardHeroCard(
                    card: card,
                    statusLabel: _statusLabel,
                    categoryLabels: _categoryLabels,
                  ),
                  12.height,
                  ActionsCard(
                    onPreview: () {},
                    onQr: () {},
                    onShare: () {},
                  ),
                  12.height,
                  PublishStatusCard(card: card, onCopy: _copyLink),
                  if (card.hasNfc) ...[
                    12.height,
                    NfcCard(card: card),
                  ],
                  12.height,
                  StatsCard(
                    visitsCount: card.visitsCount,
                    clientsCount: card.clientsCount,
                    lastUpdated: _formatDate(card.lastUpdated),
                  ),
                  18.height,
                  Center(
                    child: AppText(
                      LocaleKeys.myCards_createdAt
                          .tr(args: [_formatDate(card.createdAt)]),
                      fontSize: 11.sp,
                      color: AppColors.textSecondaryColor.themeColor
                          .withValues(alpha: 0.7),
                    ),
                  ),
                  10.height,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

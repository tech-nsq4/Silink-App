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
                  _HeroCard(
                    card: card,
                    statusLabel: _statusLabel,
                    categoryLabel: _categoryLabel,
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
                      '${LocaleKeys.myCards_createdAt.tr()} ${_formatDate(card.createdAt)}',
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

// ─── Hero (gradient + avatar + name + tags) ──────────────────────────────

class _HeroCard extends StatelessWidget {
  const _HeroCard({
    required this.card,
    required this.statusLabel,
    required this.categoryLabel,
  });

  final MyCardModel card;
  final String statusLabel;
  final String categoryLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white.themeColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.borderColor.themeColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 92.h,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(16.r)),
                  gradient: const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Color(0xFF17B78F), Color(0xFF2F6FED)],
                  ),
                ),
              ),
              PositionedDirectional(
                start: 16.w,
                bottom: -28.h,
                child: Container(
                  width: 64.w,
                  height: 64.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: card.avatarColor,
                    borderRadius: BorderRadius.circular(14.r),
                    border: Border.all(
                      color: AppColors.white.themeColor,
                      width: 3,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.10),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: AppText(
                    card.initials,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 38.h, 16.w, 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  alignment: WrapAlignment.start,
                  spacing: 8.w,
                  runSpacing: 6.h,
                  children: [
                    _SmallPill(
                      label: statusLabel,
                      background: const Color(0xFFE7F8F0),
                      textColor: const Color(0xFF17B78F),
                    ),
                    if (card.isDefault)
                      _SmallPill(
                        label: LocaleKeys.myCards_isDefault.tr(),
                        background: const Color(0xFFE8F0FE),
                        textColor: const Color(0xFF2F6FED),
                      ),
                    _SmallPill(
                      label: categoryLabel,
                      background: const Color(0xFFE7F8F0),
                      textColor: const Color(0xFF17B78F),
                    ),
                  ],
                ),
                12.height,
                AppText(
                  card.name,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w800,
                  textAlign: TextAlign.start,
                ),
                2.height,
                if (card.role.trim().isNotEmpty)
                  AppText(
                    card.role,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondaryColor.themeColor,
                    textAlign: TextAlign.start,
                  ),
                if (card.company.trim().isNotEmpty)
                  AppText(
                    card.company,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondaryColor.themeColor,
                    textAlign: TextAlign.start,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SmallPill extends StatelessWidget {
  const _SmallPill({
    required this.label,
    required this.background,
    required this.textColor,
  });

  final String label;
  final Color background;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: AppText(
        label,
        fontSize: 11.sp,
        fontWeight: FontWeight.w700,
        color: textColor,
      ),
    );
  }
}


  // ─── _StatsCard moved to my_card_details_widgets.dart ─────────────────────
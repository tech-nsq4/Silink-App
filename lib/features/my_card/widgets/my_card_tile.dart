import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/features/my_card/models/my_card_model.dart';
import 'package:Silink/features/my_card/widgets/card_action_bar.dart';
import 'package:Silink/features/my_card/widgets/card_stats_row.dart';
import 'package:Silink/features/my_card/widgets/tag_pill.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/extensions/extensions.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/app_text.dart';

class MyCardTile extends StatelessWidget {
  const MyCardTile({
    super.key,
    required this.card,
    required this.onMoreTap,
    required this.onQrTap,
    required this.onPreviewTap,
    required this.onEditTap,
    this.onTap,
  });

  final MyCardModel card;
  final VoidCallback onMoreTap;
  final VoidCallback onQrTap;
  final VoidCallback onPreviewTap;
  final VoidCallback onEditTap;
  final VoidCallback? onTap;

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

  ({String label, Color bg, Color text, Color dot}) get _statusStyle {
    switch (card.status) {
      case CardLifecycleStatus.active:
        return (
          label: _statusLabel,
          bg: const Color(0xFFEFFAF3),
          text: const Color(0xFF17B78F),
          dot: const Color(0xFF17B78F),
        );
      case CardLifecycleStatus.draft:
        return (
          label: _statusLabel,
          bg: const Color(0xFFF2F2F2),
          text: const Color(0xFF6B7280),
          dot: const Color(0xFF9CA3AF),
        );
      case CardLifecycleStatus.paused:
        return (
          label: _statusLabel,
          bg: const Color(0xFFFFF7E0),
          text: const Color(0xFFB8860B),
          dot: const Color(0xFFE0A800),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final status = _statusStyle;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: 16.paddingTop + 19.paddingHorizontal,
        decoration: BoxDecoration(
          color: AppColors.white.themeColor,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColors.borderColor.themeColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 46.w,
                      height: 46.w,
                      decoration: BoxDecoration(
                        color: card.avatarColor,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      alignment: Alignment.center,
                      child: AppText(card.initials,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                    8.width,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          card.name,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                        ),
                        2.height,
                        AppText(
                          card.role,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        if (card.company.trim().isNotEmpty)
                          AppText(
                            card.company,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textSecondaryColor.themeColor,
                          ),
                        6.height,
                        Wrap(
                          alignment: WrapAlignment.start,
                          spacing: 8.w,
                          runSpacing: 6.h,
                          children: [
                            TagPill(
                              label: _categoryLabel,
                              background: const Color(0xFFE8F0FE),
                              textColor: const Color(0xFF2F6FED),
                            ),
                            TagPill(
                              label: card.isPublished
                                  ? LocaleKeys.myCards_isPublished.tr()
                                  : LocaleKeys.myCards_notPublished.tr(),
                              background: card.isPublished
                                  ? const Color(0xFFEFFAF3)
                                  : const Color(0xFFF2F2F2),
                              textColor: card.isPublished
                                  ? const Color(0xFF17B78F)
                                  : const Color(0xFF6B7280),
                            ),
                            if (card.hasNfc)
                              TagPill(
                                label: LocaleKeys.myCards_hasNfc.tr(),
                                background: const Color(0xFFcbfbf1),
                                textColor: AppColors.mint.themeColor,
                              ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                TagPill(
                  label: status.label,
                  background: status.bg,
                  textColor: status.text,
                  dotColor: status.dot,
                ),
              ],
            ),
            10.height,
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: CardStatsRow(
                date: card.lastUpdated,
                clientsCount: card.clientsCount,
                visitsCount: card.visitsCount,
              ),
            ),
            10.height,
            Divider(height: 1, color: AppColors.borderColor.themeColor),
            CardActionBar(
              onMoreTap: onMoreTap,
              onQrTap: onQrTap,
              onPreviewTap: onPreviewTap,
              onEditTap: onEditTap,
            ),
          ],
        ),
      ),
    );
  }
}

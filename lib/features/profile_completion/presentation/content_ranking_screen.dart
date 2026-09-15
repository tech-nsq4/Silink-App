import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:Silink/features/profile_completion/models/profile_completion_data.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widgets/ranking_row_card.dart';

class ContentRankingStep extends StatefulWidget {
  const ContentRankingStep({super.key, required this.data});

  final ProfileCompletionData data;

  @override
  State<ContentRankingStep> createState() => _ContentRankingStepState();
}

class _ContentRankingStepState extends State<ContentRankingStep> {
  String _titleFor(RankingSectionType type) {
    switch (type) {
      case RankingSectionType.bio:
        return LocaleKeys.ranking_bio.tr();
      case RankingSectionType.quickContact:
        return LocaleKeys.ranking_quickContact.tr();
      case RankingSectionType.channels:
        return LocaleKeys.ranking_channels.tr();
      case RankingSectionType.links:
        return LocaleKeys.ranking_links.tr();
      case RankingSectionType.products:
        return LocaleKeys.ranking_products.tr();
      case RankingSectionType.services:
        return LocaleKeys.ranking_services.tr();
    }
  }

  IconData _iconFor(RankingSectionType type) {
    switch (type) {
      case RankingSectionType.bio:
        return Icons.description_outlined;
      case RankingSectionType.quickContact:
        return Icons.call_outlined;
      case RankingSectionType.channels:
        return Icons.share_outlined;
      case RankingSectionType.links:
        return Icons.link;
      case RankingSectionType.products:
        return Icons.inventory_2_outlined;
      case RankingSectionType.services:
        return Icons.work_outline;
    }
  }

  void _move(int index, int delta) {
    setState(() {
      final list = widget.data.ranking;
      final target = index + delta;
      final item = list.removeAt(index);
      list.insert(target, item);
    });
  }

  @override
  Widget build(BuildContext context) {
    final ranking = widget.data.ranking;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 19.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            LocaleKeys.ranking_title.tr(),
            fontSize: 20.sp,
            fontWeight: FontWeight.w800,
          ),
          4.height,
          AppText(
            LocaleKeys.ranking_subtitle.tr(),
            fontSize: 14.sp,
          ),
          16.height,
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            margin: EdgeInsets.only(bottom: 10.h),
            decoration: BoxDecoration(
              color: const Color(0xFFF7F8FA),
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(color: AppColors.dividerColor.themeColor),
            ),
            child: Row(
              children: [
                Icon(Icons.lock_outline,
                    size: 16.sp,
                    color: AppColors.textSecondaryColor.themeColor),
                8.width,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        LocaleKeys.ranking_basicInfo.tr(),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                      ),
                      AppText(
                        LocaleKeys.ranking_basicInfoPinned.tr(),
                        fontSize: 11.sp,
                        color: AppColors.textSecondaryColor.themeColor,
                      ),
                    ],
                  ),
                ),
                Icon(Icons.person_outline,
                    size: 18.sp,
                    color: AppColors.textSecondaryColor.themeColor),
              ],
            ),
          ),
          for (int i = 0; i < ranking.length; i++)
            RankingRowCard(
              title: _titleFor(ranking[i].type),
              icon: _iconFor(ranking[i].type),
              enabled: ranking[i].enabled,
              canMoveUp: i > 0,
              canMoveDown: i < ranking.length - 1,
              onToggle: (v) => setState(() => ranking[i].enabled = v),
              onMoveUp: () => _move(i, -1),
              onMoveDown: () => _move(i, 1),
            ),
          8.height,
          Center(
            child: AppText(
              LocaleKeys.ranking_dragHint.tr(),
              fontSize: 11.sp,
              color: AppColors.textSecondaryColor.themeColor,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

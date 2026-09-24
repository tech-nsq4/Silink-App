import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:Silink/core/widgets/screen_header_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/cards/company_card_stat_box.dart';
import '../widgets/cards/company_card_status.dart';
import '../widgets/cards/company_card_tile.dart';
import '../widgets/cards/company_cards_empty_state.dart';

class CardsScreen extends StatefulWidget {
  const CardsScreen({super.key});

  @override
  State<CardsScreen> createState() => _CardsScreenState();
}

class _CardsScreenState extends State<CardsScreen> {
  static const _allFilters = [
    ('all', LocaleKeys.company_filter_all),
    ('active', LocaleKeys.company_status_active),
    ('available', LocaleKeys.company_status_available),
    ('suspended', LocaleKeys.company_status_disabled),
  ];

  String _filter = 'all';

  late final List<CompanyCardItem> _cards = [
    ...CompanyCardItem.demoCards,
  ];

  void _updateCardStatus(CompanyCardItem card, CompanyCardStatus status) {
    final index = _cards.indexWhere((item) => item.id == card.id);
    if (index == -1) return;
    setState(
      () => _cards[index] = _cards[index].copyWith(status: status),
    );
  }

  List<CompanyCardItem> get _filtered => _cards.where((card) {
        return switch (_filter) {
          'available' => card.status == CompanyCardStatus.available,
          'active' => card.status == CompanyCardStatus.active,
          'suspended' => card.status == CompanyCardStatus.suspended,
          _ => true,
        };
      }).toList();

  @override
  Widget build(BuildContext context) {
    final filtered = _filtered;
    final total = _cards.length;
    final available =
        _cards.where((c) => c.status == CompanyCardStatus.available).length;
    final active =
        _cards.where((c) => c.status == CompanyCardStatus.active).length;
    final suspended =
        _cards.where((c) => c.status == CompanyCardStatus.suspended).length;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor.themeColor,
      body: Column(
        children: [
          ScreenHeaderBar(
            title: LocaleKeys.company_cards_page_title.tr(),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 0),
            child: Row(
              children: [
                CompanyCardStatBox(
                  label: LocaleKeys.company_stat_total.tr(),
                  value: total,
                  color: const Color(0xFF64748B),
                ),
                8.width,
                CompanyCardStatBox(
                  label: LocaleKeys.company_stat_active.tr(),
                  value: active,
                  color: AppColors.blue.themeColor,
                ),
                8.width,
                CompanyCardStatBox(
                  label: LocaleKeys.company_stat_available.tr(),
                  value: available,
                  color: AppColors.mint.themeColor,
                ),
                8.width,
                CompanyCardStatBox(
                  label: LocaleKeys.company_stat_disabled.tr(),
                  value: suspended,
                  color: const Color(0xFF94A3B8),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 54.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 4.h),
              itemCount: _allFilters.length,
              separatorBuilder: (_, __) => 8.width,
              itemBuilder: (context, index) {
                final (id, labelKey) = _allFilters[index];
                final selected = _filter == id;
                return InkWell(
                  onTap: () => setState(() => _filter = id),
                  borderRadius: BorderRadius.circular(20.r),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 7.h,
                    ),
                    decoration: BoxDecoration(
                      color: selected
                          ? AppColors.blue.themeColor
                          : AppColors.cardColor.themeColor,
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(
                        color: selected
                            ? Colors.transparent
                            : AppColors.borderColor.themeColor,
                      ),
                    ),
                    child: AppText(
                      labelKey.tr(),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      color: selected
                          ? Colors.white
                          : AppColors.textSecondaryColor.themeColor,
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: filtered.isEmpty
                ? CompanyCardsEmptyState(
                    title: LocaleKeys.company_cards_empty.tr(),
                    desc: LocaleKeys.company_cards_empty_desc.tr(),
                  )
                : ListView.separated(
                    padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 24.h),
                    itemCount: filtered.length,
                    separatorBuilder: (_, __) => 10.height,
                    itemBuilder: (context, index) {
                      final card = filtered[index];
                      return CompanyCardTile(
                        card: card,
                        onStatusChanged: (status) =>
                            _updateCardStatus(card, status),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

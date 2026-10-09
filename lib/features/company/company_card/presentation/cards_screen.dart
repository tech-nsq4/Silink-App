import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/filter_chips_bar.dart';
import '../../../../core/widgets/flow_top_bar.dart';
import '../../company_profile_completion/presentation/widgets/cards/company_card_stat_box.dart';
import '../../company_profile_completion/presentation/widgets/cards/company_card_status.dart';
import '../../company_profile_completion/presentation/widgets/cards/company_card_tile.dart';

class CardsScreen extends StatefulWidget {
  const CardsScreen({super.key});

  @override
  State<CardsScreen> createState() => _CardsScreenState();
}

class _CardsScreenState extends State<CardsScreen> {
  static const _filters = [
    CompanyCardStatus.available,
    CompanyCardStatus.active,
    CompanyCardStatus.suspended,
  ];

  CompanyCardStatus? _filter;

  late final List<CompanyCardItem> _cards = [...CompanyCardItem.demoCards];

  void _updateCardStatus(CompanyCardItem card, CompanyCardStatus status) {
    final index = _cards.indexWhere((item) => item.id == card.id);
    if (index == -1) return;
    setState(() => _cards[index] = _cards[index].copyWith(status: status));
  }

  int _count(CompanyCardStatus status) =>
      _cards.where((card) => card.status == status).length;

  @override
  Widget build(BuildContext context) {
    final filtered = _filter == null
        ? _cards
        : _cards.where((card) => card.status == _filter).toList();
    return Scaffold(
      backgroundColor: AppColors.backgroundColor.themeColor,
      body: Column(
        children: [
          SafeArea(
            bottom: false,
            child: FlowTopBar(
              eyebrow: LocaleKeys.companyHub_cardsEyebrow.tr(),
              title: LocaleKeys.companyHub_cards.tr(),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.fromLTRB(22.w, 8.h, 22.w, 28.h),
              children: [
                Row(
                  children: [
                    CompanyCardStatBox(
                      label: LocaleKeys.companyHub_statTotal.tr(),
                      value: _cards.length,
                    ),
                    8.width,
                    CompanyCardStatBox(
                      label: LocaleKeys.companyHub_statAvailable.tr(),
                      value: _count(CompanyCardStatus.available),
                    ),
                    8.width,
                    CompanyCardStatBox(
                      label: LocaleKeys.companyHub_statActive.tr(),
                      value: _count(CompanyCardStatus.active),
                    ),
                    8.width,
                    CompanyCardStatBox(
                      label: LocaleKeys.companyHub_statSuspended.tr(),
                      value: _count(CompanyCardStatus.suspended),
                    ),
                  ],
                ),
                SizedBox(height: 14.h),
                FilterChipsBar<CompanyCardStatus>(
                  allLabel: LocaleKeys.clientsHub_all.tr(),
                  options: _filters,
                  labelOf: companyCardStatusLabel,
                  selected: _filter,
                  onSelected: (status) => setState(() => _filter = status),
                ),
                SizedBox(height: 14.h),
                if (filtered.isEmpty)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 40.h),
                    child: AppText(
                      LocaleKeys.companyHub_cardsEmpty.tr(),
                      fontSize: 10.sp,
                      textAlign: TextAlign.center,
                      color: AppColors.textSecondaryColor.themeColor,
                    ),
                  )
                else
                  for (final card in filtered)
                    Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: CompanyCardTile(
                        card: card,
                        onStatusChanged: (status) =>
                            _updateCardStatus(card, status),
                      ),
                    ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

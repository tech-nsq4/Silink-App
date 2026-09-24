import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/app_images.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'company_stat_tile.dart';

class CompanyStatsGrid extends StatelessWidget {
  const CompanyStatsGrid({
    super.key,
    required this.employees,
    required this.cards,
    this.visits = 0,
    this.leads = 0,
  });

  final int employees;
  final int cards;
  final int visits;
  final int leads;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 10.h,
      crossAxisSpacing: 10.w,
      childAspectRatio: 1.40,
      children: [
        CompanyStatTile(
          value: '$employees',
          label: LocaleKeys.company_active_employees.tr(),
          icon: AppImages.iconsClients,
          color: AppColors.blue.themeColor,
        ),
        CompanyStatTile(
          value: '$cards',
          label: LocaleKeys.company_active_cards.tr(),
          icon: AppImages.iconsCard,
          color: const Color(0xFF0D9488),
        ),
        CompanyStatTile(
          value: '$visits',
          label: LocaleKeys.company_visits.tr(),
          icon: AppImages.iconsPreview,
          color: AppColors.purple.themeColor,
        ),
        CompanyStatTile(
          value: '$leads',
          label: LocaleKeys.company_leads.tr(),
          icon: AppImages.iconsSave,
          color: const Color(0xFFEA580C),
        ),
      ],
    );
  }
}


import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_text.dart';
import '../../data/models/portfolio_model.dart';

class PortfolioDatesCard extends StatelessWidget {
  const PortfolioDatesCard({super.key, required this.portfolio});

  final PortfolioModel portfolio;

  @override
  Widget build(BuildContext context) {
    final locale = context.locale.toString();
    final format = DateFormat.yMd(locale);
    final secondary = AppColors.textSecondaryColor.themeColor;
    final stats = [
      (
        Icons.event_available_outlined,
        portfolio.createdAt == null ? '—' : format.format(portfolio.createdAt!),
        LocaleKeys.portfolios_createdAt.tr(),
      ),
      (
        Icons.update_rounded,
        portfolio.updatedAt == null ? '—' : format.format(portfolio.updatedAt!),
        LocaleKeys.portfolios_updatedAt.tr(),
      ),
    ];
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColors.white.themeColor,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: AppColors.studioPanelBorder.themeColor),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            for (final (index, stat) in stats.indexed) ...[
              if (index > 0)
                VerticalDivider(
                    width: 1, color: AppColors.studioStepLine.themeColor),
              Expanded(
                child: Column(
                  children: [
                    Icon(stat.$1, size: 15.sp, color: secondary),
                    SizedBox(height: 6.h),
                    AppText(stat.$2,
                        fontSize: 12.sp, fontWeight: FontWeight.w800),
                    SizedBox(height: 4.h),
                    AppText(stat.$3, fontSize: 8.sp, color: secondary),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

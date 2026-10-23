import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_text.dart';
import '../../data/models/portfolio_model.dart';
import 'portfolio_badge.dart';

class PortfolioPublishCard extends StatelessWidget {
  const PortfolioPublishCard({
    super.key,
    required this.portfolio,
    required this.onCopy,
  });

  final PortfolioModel portfolio;
  final VoidCallback onCopy;

  @override
  Widget build(BuildContext context) {
    final teal = AppColors.accentTeal.themeColor;
    final secondary = AppColors.textSecondaryColor.themeColor;
    final link = portfolio.shareUrl.replaceFirst(RegExp(r'^https?://'), '');
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.white.themeColor,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: AppColors.studioPanelBorder.themeColor),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.language_rounded, size: 16.sp, color: secondary),
              8.width,
              Expanded(
                child: AppText(LocaleKeys.portfolios_publishState.tr(),
                    fontSize: 10.5.sp, fontWeight: FontWeight.w800),
              ),
              PortfolioBadge(
                label: portfolio.isActive
                    ? LocaleKeys.portfolios_published.tr()
                    : LocaleKeys.portfolios_unpublished.tr(),
                color: portfolio.isActive ? teal : secondary,
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: AppColors.studioSelectFill.themeColor,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Directionality(
                    textDirection: TextDirection.ltr,
                    child: AppText(link,
                        fontSize: 8.5.sp,
                        color: secondary,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                  ),
                ),
                8.width,
                GestureDetector(
                  onTap: onCopy,
                  child: AppText(LocaleKeys.portfolios_copy.tr(),
                      fontSize: 9.5.sp,
                      fontWeight: FontWeight.w800,
                      color: teal),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

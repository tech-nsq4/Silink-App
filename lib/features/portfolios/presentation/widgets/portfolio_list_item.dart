import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_text.dart';
import '../../data/models/portfolio_model.dart';
import 'portfolio_action_bar.dart';
import 'portfolio_card_preview.dart';

class PortfolioListItem extends StatelessWidget {
  const PortfolioListItem({
    super.key,
    required this.portfolio,
    required this.onOpen,
    required this.onMore,
    required this.onEdit,
    required this.onShare,
    required this.onPreview,
  });

  final PortfolioModel portfolio;
  final VoidCallback onOpen;
  final VoidCallback onMore;
  final VoidCallback onEdit;
  final VoidCallback onShare;
  final VoidCallback onPreview;

  @override
  Widget build(BuildContext context) {
    final accent = AppColors.accentTeal.themeColor;
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: AppColors.white.themeColor,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.studioPanelBorder.themeColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(14.w, 6.h, 4.w, 0),
            child: Row(
              children: [
                Expanded(
                  child: AppText(
                    portfolio.isPrimary
                        ? LocaleKeys.portfolios_primary.tr()
                        : LocaleKeys.portfolios_secondary.tr(),
                    fontSize: 8.5.sp,
                    fontWeight: FontWeight.w700,
                    color: portfolio.isActive
                        ? accent
                        : AppColors.textSecondaryColor.themeColor,
                  ),
                ),
                IconButton(
                  onPressed: onMore,
                  icon: Icon(Icons.more_horiz_rounded,
                      size: 20.sp,
                      color: AppColors.textSecondaryColor.themeColor),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: GestureDetector(
              onTap: onOpen,
              child: Opacity(
                opacity: portfolio.isActive ? 1 : 0.5,
                child: PortfolioCardPreview(portfolio: portfolio),
              ),
            ),
          ),
          SizedBox(height: 6.h),
          PortfolioActionBar(
            actions: [
              PortfolioAction(
                icon: Icons.edit_outlined,
                label: LocaleKeys.portfolios_edit.tr(),
                onTap: onEdit,
              ),
              PortfolioAction(
                icon: Icons.qr_code_2_rounded,
                label: LocaleKeys.portfolios_share.tr(),
                onTap: onShare,
              ),
              PortfolioAction(
                icon: Icons.visibility_outlined,
                label: LocaleKeys.portfolios_preview.tr(),
                onTap: onPreview,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/convert_helper.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/image/custom_image.dart';
import '../../data/models/portfolio_model.dart';
import 'portfolio_badge.dart';

class PortfolioDetailsHeader extends StatelessWidget {
  const PortfolioDetailsHeader({super.key, required this.portfolio});

  final PortfolioModel portfolio;

  @override
  Widget build(BuildContext context) {
    final accent = ConvertHelper.hexToColor(
      portfolio.card?.appearance.primaryColor ?? '',
      fallback: AppColors.accentTeal.themeColor,
    );
    final photo =
        (portfolio.card?.basic.photoUrl ?? portfolio.photoUrl ?? '').trim();
    final name = portfolio.displayName;
    final initials = name
        .trim()
        .split(RegExp(r'\s+'))
        .where((w) => w.isNotEmpty)
        .take(2)
        .map((w) => w.characters.first)
        .join();
    final secondary = AppColors.textSecondaryColor.themeColor;
    final teal = AppColors.accentTeal.themeColor;
    final avatar = 52.w;
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.white.themeColor,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.studioPanelBorder.themeColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 56.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [accent, AppColors.accentBlue.themeColor],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Transform.translate(
                  offset: Offset(0, -avatar / 2),
                  child: Container(
                    width: avatar,
                    height: avatar,
                    alignment: Alignment.center,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: accent,
                      borderRadius: BorderRadius.circular(15.r),
                      border: Border.all(
                          color: AppColors.white.themeColor, width: 3),
                    ),
                    child: photo.isNotEmpty
                        ? CustomImage(
                            image: photo,
                            width: avatar,
                            height: avatar,
                            fit: BoxFit.cover,
                          )
                        : AppText(initials,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w800,
                            color: AppColors.white.light),
                  ),
                ),
                Transform.translate(
                  offset: Offset(0, -avatar / 2 + 10.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: AppText(name,
                                fontSize: 15.sp, fontWeight: FontWeight.w800),
                          ),
                          Wrap(
                            spacing: 4.w,
                            children: [
                              PortfolioBadge(
                                label: portfolio.isActive
                                    ? LocaleKeys.portfolios_badgeActive.tr()
                                    : LocaleKeys.portfolios_badgePaused.tr(),
                                color: portfolio.isActive ? teal : secondary,
                              ),
                              if (portfolio.isPrimary)
                                PortfolioBadge(
                                  label:
                                      LocaleKeys.portfolios_badgeDefault.tr(),
                                  color: AppColors.accentBlue.themeColor,
                                ),
                              PortfolioBadge(
                                label: portfolio.isBusiness
                                    ? LocaleKeys.portfolios_typeBusiness.tr()
                                    : LocaleKeys.portfolios_typeFreelance.tr(),
                                color: AppColors.purple.themeColor,
                              ),
                            ],
                          ),
                        ],
                      ),
                      if (portfolio.jobTitle.isNotEmpty) ...[
                        SizedBox(height: 4.h),
                        AppText(portfolio.jobTitle,
                            fontSize: 9.sp, color: secondary),
                      ],
                      if (portfolio.company.isNotEmpty) ...[
                        SizedBox(height: 3.h),
                        AppText(portfolio.company,
                            fontSize: 9.sp, color: secondary),
                      ],
                    ],
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

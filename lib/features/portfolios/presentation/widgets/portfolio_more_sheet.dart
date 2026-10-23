import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_text.dart';
import '../../data/models/portfolio_model.dart';
import 'portfolio_status_switch.dart';

enum PortfolioMoreAction { copyLink, toggle, delete }

class PortfolioMoreSheet extends StatelessWidget {
  const PortfolioMoreSheet({super.key, required this.portfolio});

  final PortfolioModel portfolio;

  static Future<PortfolioMoreAction?> show(
    BuildContext context,
    PortfolioModel portfolio,
  ) =>
      showModalBottomSheet<PortfolioMoreAction>(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (_) => PortfolioMoreSheet(portfolio: portfolio),
      );

  Widget _tile(BuildContext context, IconData icon, String label,
      PortfolioMoreAction action,
      {bool destructive = false}) {
    final color = destructive
        ? AppColors.errorColor.themeColor
        : AppColors.textPrimaryColor.themeColor;
    return InkWell(
      onTap: () => Navigator.of(context).pop(action),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
        child: Row(
          children: [
            Icon(icon, size: 19.sp, color: color),
            12.width,
            AppText(label,
                fontSize: 11.sp, fontWeight: FontWeight.w700, color: color),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white.themeColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.h),
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: AppColors.studioStepLine.themeColor,
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
            _tile(
                context,
                Icons.link_rounded,
                LocaleKeys.portfolios_copyLink.tr(),
                PortfolioMoreAction.copyLink),
            InkWell(
              onTap: () =>
                  Navigator.of(context).pop(PortfolioMoreAction.toggle),
              child: PortfolioStatusSwitch(
                isActive: portfolio.isActive,
                bordered: false,
                onChanged: (_) =>
                    Navigator.of(context).pop(PortfolioMoreAction.toggle),
              ),
            ),
            if (!portfolio.isPrimary)
              _tile(context, Icons.delete_outline_rounded,
                  LocaleKeys.portfolios_delete.tr(), PortfolioMoreAction.delete,
                  destructive: true),
            SizedBox(height: 8.h),
          ],
        ),
      ),
    );
  }
}

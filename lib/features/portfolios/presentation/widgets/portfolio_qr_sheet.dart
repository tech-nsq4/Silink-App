import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_text.dart';
import '../../data/models/portfolio_model.dart';

class PortfolioQrSheet extends StatelessWidget {
  const PortfolioQrSheet({super.key, required this.portfolio});

  final PortfolioModel portfolio;

  static Future<void> show(BuildContext context, PortfolioModel portfolio) =>
      showModalBottomSheet<void>(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (_) => PortfolioQrSheet(portfolio: portfolio),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 28.h),
      decoration: BoxDecoration(
        color: AppColors.white.themeColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppText(portfolio.displayName,
                fontSize: 14.sp, fontWeight: FontWeight.w800),
            SizedBox(height: 16.h),
            QrImageView(
              data: portfolio.shareUrl,
              size: 200.w,
              eyeStyle: QrEyeStyle(
                eyeShape: QrEyeShape.square,
                color: AppColors.studioCardStart.themeColor,
              ),
              dataModuleStyle: QrDataModuleStyle(
                dataModuleShape: QrDataModuleShape.square,
                color: AppColors.studioCardStart.themeColor,
              ),
            ),
            SizedBox(height: 12.h),
            AppText(
              LocaleKeys.portfolios_scanHint.tr(),
              fontSize: 9.sp,
              color: AppColors.textSecondaryColor.themeColor,
            ),
          ],
        ),
      ),
    );
  }
}

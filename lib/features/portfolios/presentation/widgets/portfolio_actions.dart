import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../app/router/navigation_services.dart';
import '../../../../app/router/routes.dart';
import '../../../../core/utils/app_overlay.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../data/models/portfolio_model.dart';
import 'portfolio_qr_sheet.dart';

class PortfolioActions {
  PortfolioActions._();

  static void share(PortfolioModel portfolio) {
    if (portfolio.shareUrl.isEmpty) return;
    Share.share('${portfolio.displayName}\n${portfolio.shareUrl}');
  }

  static Future<void> copyLink(PortfolioModel portfolio) async {
    await Clipboard.setData(ClipboardData(text: portfolio.shareUrl));
    AppOverlay.showSuccess(LocaleKeys.portfolios_copied.tr());
  }

  static Future<void> edit(PortfolioModel portfolio) async {
    if (portfolio.isPrimary) {
      await NavigationService.push(Routes.profileCompletionScreen);
      return;
    }
    await NavigationService.push(
      Routes.portfolioStudioScreen,
      arguments: {'portfolioId': portfolio.id},
    );
  }

  static void preview(PortfolioModel portfolio) => NavigationService.push(
        Routes.portfolioPreviewScreen,
        arguments: {'portfolio': portfolio},
      );

  static void qr(BuildContext context, PortfolioModel portfolio) =>
      PortfolioQrSheet.show(context, portfolio);
}

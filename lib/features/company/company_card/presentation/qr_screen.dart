import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';

import 'package:Silink/app/router/navigation_services.dart';
import 'package:Silink/app/router/routes.dart';
import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_constants.dart';
import 'package:Silink/core/utils/app_images.dart';
import 'package:Silink/core/utils/app_overlay.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/screen_header_bar.dart';
import 'package:Silink/features/company/data/models/company_public_page_data.dart';
import 'package:Silink/features/company/widgets/qr/company_qr_action_button.dart';
import 'package:Silink/features/company/widgets/qr/company_qr_card.dart';

class QrScreen extends StatelessWidget {
  const QrScreen({
    super.key,
    this.data = CompanyPublicPageData.sample,
  });

  final CompanyPublicPageData data;

  String get _url => '${AppConstants.companyPageUrl}${data.slug}';

  String get _displayLink => '${AppConstants.companyPageHost}${data.slug}';

  void _copyLink() {
    Clipboard.setData(ClipboardData(text: _url));
    AppOverlay.showSuccess(LocaleKeys.publish_linkCopied.tr());
  }

  Future<void> _shareLink() async {
    await Share.share(_url);
  }

  void _onSimulateScan() => NavigationService.push(Routes.companyPublicPage);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ScreenHeaderBar(title: LocaleKeys.company_qr_page_title.tr()),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                child: Column(
                  children: [
                    CompanyQrCard(
                      companyName: data.name,
                      qrData: _url,
                      link: _displayLink,
                      onLinkTap: _copyLink,
                    ),
                    20.height,
                    CompanyQrActionButton(
                      icon: AppImages.iconsPreview,
                      label: LocaleKeys.company_qr_simulate_scan.tr(),
                      onTap: _onSimulateScan,
                    ),
                    12.height,
                    CompanyQrActionButton(
                      icon: AppImages.iconsShare,
                      label: LocaleKeys.company_qr_share_link.tr(),
                      onTap: _shareLink,
                      filled: false,
                    ),
                    24.height,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

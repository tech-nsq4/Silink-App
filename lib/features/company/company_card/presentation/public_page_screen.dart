import 'package:Silink/app/router/navigation_services.dart';
import 'package:Silink/app/router/routes.dart';
import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_images.dart';
import 'package:Silink/core/utils/app_overlay.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/features/company/data/models/company_public_page_data.dart';
import 'package:Silink/features/company/widgets/public_page/company_public_brand_button.dart';
import 'package:Silink/features/company/widgets/public_page/company_public_contact_row.dart';
import 'package:Silink/features/company/widgets/public_page/company_public_page_about_card.dart';
import 'package:Silink/features/company/widgets/public_page/company_public_page_cover.dart';
import 'package:Silink/features/company/widgets/public_page/company_public_page_header.dart';
import 'package:Silink/features/company/widgets/public_page/company_public_team_section.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PublicPageScreen extends StatelessWidget {
  const PublicPageScreen({
    super.key,
    this.data = CompanyPublicPageData.sample,
  });

  final CompanyPublicPageData data;

  void _onExit() => NavigationService.goBack();

  void _onCatalog() => NavigationService.push(
        Routes.companyCatalog,
        arguments: {
          'businessType': data.businessType,
          'companyName': data.name,
          'providerCity': data.city,
          'editable': false,
        },
      );

  void _onComingSoon() =>
      AppOverlay.showSuccess(LocaleKeys.common_comingSoon.tr());

  void _onSaveContact() => AppOverlay.showSuccess(
        LocaleKeys.home_activity_contact_saved.tr(namedArgs: {
          'name': data.name,
        }),
      );

  @override
  Widget build(BuildContext context) {
    final about = data.about?.trim();
    final hasAbout = about != null && about.isNotEmpty;
    final catalogLabel = data.catalogLabel?.trim();
    final hasCatalogLabel = catalogLabel != null && catalogLabel.isNotEmpty;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CompanyPublicPageCover(onExit: _onExit),
            Transform.translate(
              offset: Offset(0, -34.h),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 19.w),
                child: Column(
                  children: [
                    CompanyPublicPageHeader(
                      companyName: data.name,
                      industry: data.industry,
                      city: data.city,
                      employeesLabel: data.employeesLabel,
                      imagePath: data.imagePath,
                    ),
                    if (hasAbout) ...[
                      16.height,
                      CompanyPublicPageAboutCard(about: about),
                    ],
                    18.height,
                    CompanyPublicContactRow(
                      onCall: _onComingSoon,
                      onWhatsapp: _onComingSoon,
                      onEmail: _onComingSoon,
                      onWebsite: _onComingSoon,
                      onSaveContact: _onSaveContact,
                    ),
                    18.height,
                    CompanyPublicBrandButton(
                      icon: AppImages.iconsFood,
                      label: hasCatalogLabel
                          ? catalogLabel
                          : LocaleKeys.company_catalog.tr(),
                      onTap: _onCatalog,
                    ),
                    if (data.team.isNotEmpty) ...[
                      22.height,
                      CompanyPublicTeamSection(members: data.team),
                    ],
                    22.height,
                    CompanyPublicBrandButton(
                      icon: AppImages.iconsShare,
                      label: LocaleKeys.company_share_page.tr(),
                      onTap: _onComingSoon,
                    ),
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

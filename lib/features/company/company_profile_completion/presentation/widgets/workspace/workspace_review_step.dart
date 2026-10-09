import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/utils/locale_keys.dart';
import '../../../../../../core/widgets/flow_page_title.dart';
import 'workspace_benefits.dart';
import 'workspace_contact_expander.dart';
import 'workspace_review_card.dart';

class WorkspaceReviewStep extends StatelessWidget {
  const WorkspaceReviewStep({
    super.key,
    required this.name,
    required this.about,
    required this.city,
    required this.size,
    required this.phone,
    required this.email,
    this.logoUrl,
    this.logoFile,
  });

  final String name;
  final String about;
  final String city;
  final String size;
  final String phone;
  final String email;
  final String? logoUrl;
  final File? logoFile;

  @override
  Widget build(BuildContext context) {
    final meta = [
      if (city.isNotEmpty) city,
      if (size.isNotEmpty)
        LocaleKeys.companyWorkspace_reviewMembers.tr(args: [size]),
    ].join(' · ');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FlowPageTitle(
          eyebrow: LocaleKeys.companyWorkspace_reviewEyebrow.tr(),
          title: LocaleKeys.companyWorkspace_reviewTitle.tr(),
          subtitle: LocaleKeys.companyWorkspace_reviewSubtitle.tr(),
        ),
        WorkspaceReviewCard(
          eyebrow: LocaleKeys.companyWorkspace_reviewSpace.tr(),
          name: name,
          about: about,
          meta: meta,
          logoUrl: logoUrl,
          logoFile: logoFile,
        ),
        SizedBox(height: 16.h),
        WorkspaceContactExpander(
          title: LocaleKeys.companyWorkspace_reviewContact.tr(),
          phone: phone,
          email: email,
        ),
        WorkspaceBenefits(
          items: [
            LocaleKeys.companyWorkspace_benefitPage.tr(),
            LocaleKeys.companyWorkspace_benefitCards.tr(),
            LocaleKeys.companyWorkspace_benefitStats.tr(),
          ],
        ),
      ],
    );
  }
}

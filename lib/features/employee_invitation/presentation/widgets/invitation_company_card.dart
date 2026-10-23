import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:Silink/features/employee_invitation/data/models/invitation_details_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'invitation_info_row.dart';
import 'invitation_section_card.dart';

class InvitationCompanyCard extends StatelessWidget {
  const InvitationCompanyCard({super.key, required this.company});

  final InvitationCompany company;

  @override
  Widget build(BuildContext context) {
    final website = Uri.tryParse(company.website)?.host ?? company.website;
    return InvitationSectionCard(
      title: LocaleKeys.invitation_aboutCompany.tr(),
      children: [
        if (company.about.isNotEmpty) ...[
          8.height,
          AppText(
            company.about,
            fontSize: 12.sp,
            height: 1.6,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            color: AppColors.textSecondaryColor.themeColor,
          ),
        ],
        InvitationInfoRow(
          icon: Icons.language_rounded,
          label: LocaleKeys.invitation_website.tr(),
          value: website,
        ),
        InvitationInfoRow(
          icon: Icons.phone_rounded,
          label: LocaleKeys.invitation_phone.tr(),
          value: company.phone,
        ),
        InvitationInfoRow(
          icon: Icons.alternate_email_rounded,
          label: LocaleKeys.invitation_email.tr(),
          value: company.email,
        ),
      ],
    );
  }
}

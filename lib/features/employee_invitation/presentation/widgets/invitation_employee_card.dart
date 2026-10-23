import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/features/employee_invitation/data/models/invitation_details_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'invitation_info_row.dart';
import 'invitation_section_card.dart';

class InvitationEmployeeCard extends StatelessWidget {
  const InvitationEmployeeCard({super.key, required this.employee});

  final InvitationEmployee employee;

  @override
  Widget build(BuildContext context) {
    return InvitationSectionCard(
      title: LocaleKeys.invitation_yourDetails.tr(),
      children: [
        InvitationInfoRow(
          icon: Icons.person_rounded,
          label: LocaleKeys.invitation_name.tr(),
          value: employee.name,
        ),
        InvitationInfoRow(
          icon: Icons.work_rounded,
          label: LocaleKeys.invitation_jobTitle.tr(),
          value: employee.position,
        ),
        InvitationInfoRow(
          icon: Icons.alternate_email_rounded,
          label: LocaleKeys.invitation_email.tr(),
          value: employee.email,
        ),
        InvitationInfoRow(
          icon: Icons.phone_rounded,
          label: LocaleKeys.invitation_phone.tr(),
          value: employee.phone,
        ),
      ],
    );
  }
}

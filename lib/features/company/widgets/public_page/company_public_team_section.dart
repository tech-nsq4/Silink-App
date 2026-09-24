import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:Silink/features/company/data/models/company_public_page_data.dart';

import 'company_public_team_member_tile.dart';

class CompanyPublicTeamSection extends StatelessWidget {
  const CompanyPublicTeamSection({super.key, required this.members});

  final List<CompanyTeamMember> members;

  @override
  Widget build(BuildContext context) {
    if (members.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.only(start: 4.w, bottom: 8.h),
          child: AppText(
            LocaleKeys.company_team.tr(),
            fontSize: 13.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.cardColor.themeColor,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: AppColors.borderColor.themeColor),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              for (var i = 0; i < members.length; i++)
                CompanyPublicTeamMemberTile(
                  member: members[i],
                  showDivider: i != members.length - 1,
                ),
            ],
          ),
        ),
      ],
    );
  }
}

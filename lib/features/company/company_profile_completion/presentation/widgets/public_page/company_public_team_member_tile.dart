import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:Silink/features/company/data/models/company_public_page_data.dart';

class CompanyPublicTeamMemberTile extends StatelessWidget {
  const CompanyPublicTeamMemberTile({
    super.key,
    required this.member,
    this.showDivider = true,
  });

  final CompanyTeamMember member;
  final bool showDivider;

  String get _initials {
    final words = member.fullName
        .trim()
        .split(' ')
        .where((word) => word.trim().isNotEmpty)
        .take(2)
        .toList();
    if (words.isEmpty) return '';
    return words.map((word) => word.trim()[0]).join(' ');
  }

  String get _subtitle {
    final parts = <String>[
      if (member.jobTitle != null && member.jobTitle!.trim().isNotEmpty)
        member.jobTitle!.trim(),
      if (member.department != null && member.department!.trim().isNotEmpty)
        member.department!.trim(),
    ];
    return parts.join(' , ');
  }

  @override
  Widget build(BuildContext context) {
    final brand = AppColors.companyBrand.themeColor;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(14.w),
          child: Row(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 44.w,
                    height: 44.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: brand.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    child: AppText(
                      _initials,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
                      color: brand,
                    ),
                  ),
                  PositionedDirectional(
                    bottom: -2,
                    end: -2,
                    child: Container(
                      width: 12.w,
                      height: 12.w,
                      decoration: BoxDecoration(
                        color: AppColors.successColor.themeColor,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.cardColor.themeColor,
                          width: 2.w,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              12.width,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      member.fullName,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    if (_subtitle.isNotEmpty) ...[
                      3.height,
                      AppText(
                        _subtitle,
                        fontSize: 11.sp,
                        color: AppColors.textSecondaryColor.themeColor,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
        if (showDivider)
          Divider(height: 1, color: AppColors.borderColor.themeColor),
      ],
    );
  }
}

import 'package:flutter/material.dart';

import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'company_quick_action_item.dart';

class CompanyQuickActions extends StatelessWidget {
  const CompanyQuickActions({
    super.key,
    required this.onShare,
    required this.onEmployees,
    required this.onCards,
  });

  final VoidCallback onShare;
  final VoidCallback onEmployees;
  final VoidCallback onCards;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CompanyQuickActionItem(
            icon: Icons.share_outlined,
            label: 'مشاركة',
            color: AppColors.mint.themeColor,
            onTap: onShare,
          ),
        ),
        10.width,
        Expanded(
          child: CompanyQuickActionItem(
            icon: Icons.person_add_alt_outlined,
            label: 'إضافة موظف',
            color: AppColors.blue.themeColor,
            onTap: onEmployees,
          ),
        ),
        10.width,
        Expanded(
          child: CompanyQuickActionItem(
            icon: Icons.add_card_outlined,
            label: 'بطاقة جديدة',
            color: const Color(0xff8B5CF6),
            onTap: onCards,
          ),
        ),
      ],
    );
  }
}

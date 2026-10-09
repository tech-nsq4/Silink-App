import 'package:flutter/material.dart';

import '../../../core/extensions/extensions.dart';
import '../../../core/utils/app_colors.dart';

class AccountSectionDivider extends StatelessWidget {
  const AccountSectionDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 24.paddingVert,
      child: Divider(
        height: 1,
        thickness: 1,
        color: AppColors.dividerColor.themeColor.withValues(alpha: 0.6),
      ),
    );
  }
}

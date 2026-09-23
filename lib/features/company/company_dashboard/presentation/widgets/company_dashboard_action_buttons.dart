import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_button.dart';

class CompanyDashboardActionButtons extends StatelessWidget {
  const CompanyDashboardActionButtons({
    super.key,
    required this.onEdit,
    required this.onShare,
  });

  final VoidCallback onEdit;
  final VoidCallback onShare;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomButton(
          onTap: onEdit,
          title: LocaleKeys.company_edit.tr(),
        ),
        10.height,
        CustomButton(
          onTap: onShare,
          title: LocaleKeys.company_qr.tr(),
          isOutlined: true,
        ),
      ],
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_text.dart';

class ClientAddLink extends StatelessWidget {
  const ClientAddLink({super.key, required this.onTap, this.label});

  final VoidCallback onTap;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AppText(
        label ?? LocaleKeys.clientsHub_add.tr(),
        fontSize: 9.5.sp,
        fontWeight: FontWeight.w800,
        color: AppColors.accentTeal.themeColor,
      ),
    );
  }
}

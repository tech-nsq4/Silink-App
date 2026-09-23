import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/widgets/app_button.dart';
import 'package:Silink/core/widgets/app_text.dart';

class CompanyActionBar extends StatelessWidget {
  const CompanyActionBar({
    super.key,
    required this.titleKey,
    required this.onTap,
    this.secondaryTitleKey,
    this.onSecondaryTap,
    this.loading = false,
  });

  final String titleKey;
  final VoidCallback onTap;
  final String? secondaryTitleKey;
  final VoidCallback? onSecondaryTap;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 19.paddingHorizontal + 12.paddingVert,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomButton(onTap: onTap, title: titleKey.tr(), loading: loading),
          if (secondaryTitleKey != null && onSecondaryTap != null) ...[
            10.height,
            InkWell(
              onTap: onSecondaryTap,
              child: Center(
                child: AppText(
                  secondaryTitleKey!.tr(),
                  fontSize: 12.5.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.mint.themeColor,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

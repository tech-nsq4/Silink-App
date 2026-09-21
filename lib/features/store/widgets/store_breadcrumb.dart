import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/locale_keys.dart';
import '../../../core/widgets/app_text.dart';

class StoreBreadcrumb extends StatelessWidget {
  const StoreBreadcrumb({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: AppText(
        '${LocaleKeys.nav_home.tr()} / ${LocaleKeys.store_title.tr()}',
        fontSize: 12.sp,
        color: AppColors.textSecondaryColor.themeColor,
      ),
    );
  }
}

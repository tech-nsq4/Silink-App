import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_text.dart';

class OrderSuccessHeader extends StatelessWidget {
  const OrderSuccessHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final accent = AppColors.statsAccentGreen.themeColor;

    return Column(
      children: [
        Container(
          width: 84.w,
          height: 84.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.15),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.check_circle_outline_rounded,
            size: 42.sp,
            color: accent,
          ),
        ),
        16.height,
        AppText(
          LocaleKeys.store_order_confirmed.tr(),
          fontSize: 20.sp,
          fontWeight: FontWeight.w800,
          textAlign: TextAlign.center,
        ),
        6.height,
        AppText(
          LocaleKeys.store_order_confirmed_hint.tr(),
          fontSize: 12.5.sp,
          color: AppColors.textSecondaryColor.themeColor,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

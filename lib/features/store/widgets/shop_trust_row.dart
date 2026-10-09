import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/extensions/extensions.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/locale_keys.dart';
import '../../../core/widgets/app_text.dart';

class ShopTrustRow extends StatelessWidget {
  const ShopTrustRow({super.key});

  @override
  Widget build(BuildContext context) {
    final color = AppColors.textSecondaryColor.themeColor;
    return Container(
      padding: EdgeInsets.only(top: 16.h),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: AppColors.studioStepLine.themeColor),
        ),
      ),
      child: Row(
        children: [
          for (final (icon, label) in [
            (Icons.local_shipping_outlined, LocaleKeys.shop_trustDelivery.tr()),
            (Icons.verified_user_outlined, LocaleKeys.shop_trustSecure.tr()),
          ]) ...[
            Icon(icon, size: 15.sp, color: color),
            6.width,
            AppText(label, fontSize: 8.5.sp, color: color),
            28.width,
          ],
        ],
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/extensions/extensions.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/locale_keys.dart';
import '../../../core/widgets/app_text.dart';

class ShopFeaturesRow extends StatelessWidget {
  const ShopFeaturesRow({super.key});

  @override
  Widget build(BuildContext context) {
    final color = AppColors.textSecondaryColor.themeColor;
    final features = [
      (Icons.contactless_outlined, LocaleKeys.shop_featureTouch.tr()),
      (Icons.edit_outlined, LocaleKeys.shop_featureDesign.tr()),
      (Icons.language_rounded, LocaleKeys.shop_featureNoApp.tr()),
    ];
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          for (final (icon, label) in features)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 14.sp, color: color),
                5.width,
                AppText(label, fontSize: 8.5.sp, color: color),
              ],
            ),
        ],
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text.dart';

class OrdersEmptyView extends StatelessWidget {
  const OrdersEmptyView({super.key, required this.onShopNow});

  final VoidCallback onShopNow;

  @override
  Widget build(BuildContext context) {
    final accent = AppColors.successColor.themeColor;

    return Center(
      child: SingleChildScrollView(
        padding: 32.paddingAll,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 88.w,
              height: 88.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.10),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.receipt_long_outlined,
                size: 40.sp,
                color: accent,
              ),
            ),
            16.height,
            AppText(
              LocaleKeys.orders_empty_title.tr(),
              fontSize: 16.sp,
              fontWeight: FontWeight.w800,
              textAlign: TextAlign.center,
            ),
            6.height,
            AppText(
              LocaleKeys.orders_empty_subtitle.tr(),
              fontSize: 12.5.sp,
              color: AppColors.textSecondaryColor.themeColor,
              textAlign: TextAlign.center,
            ),
            20.height,
            CustomButton(
              onTap: onShopNow,
              title: LocaleKeys.orders_shop_now.tr(),
              width: 180.w,
              height: 46,
              fontSize: 14.sp,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text.dart';

class CancelOrderDialog extends StatelessWidget {
  const CancelOrderDialog({super.key});

  static Future<bool> show(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => const CancelOrderDialog(),
    );
    return confirmed ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final danger = AppColors.saleRed.themeColor;

    return Dialog(
      backgroundColor: AppColors.cardColor.themeColor,
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 60.w,
              height: 60.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: danger.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.cancel_outlined, size: 30.sp, color: danger),
            ),
            14.height,
            AppText(
              LocaleKeys.orders_cancel_confirm_title.tr(),
              fontSize: 16.sp,
              fontWeight: FontWeight.w800,
              textAlign: TextAlign.center,
            ),
            8.height,
            AppText(
              LocaleKeys.orders_cancel_confirm_message.tr(),
              fontSize: 12.5.sp,
              color: AppColors.textSecondaryColor.themeColor,
              textAlign: TextAlign.center,
            ),
            20.height,
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    onTap: () => Navigator.of(context).pop(false),
                    title: LocaleKeys.orders_keep_order.tr(),
                    height: 46,
                    fontSize: 13.5.sp,
                    color: AppColors.cardColor.themeColor,
                    borderColor: AppColors.borderColor.themeColor,
                    textColor: AppColors.textPrimaryColor.themeColor,
                  ),
                ),
                10.width,
                Expanded(
                  child: CustomButton(
                    onTap: () => Navigator.of(context).pop(true),
                    title: LocaleKeys.orders_cancel_confirm.tr(),
                    height: 46,
                    fontSize: 13.5.sp,
                    color: danger,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

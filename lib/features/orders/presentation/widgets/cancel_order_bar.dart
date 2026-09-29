import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_button.dart';

class CancelOrderBar extends StatelessWidget {
  const CancelOrderBar({
    super.key,
    required this.onTap,
    this.loading = false,
  });

  final VoidCallback onTap;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    final danger = AppColors.saleRed.themeColor;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundColor.themeColor,
        border: Border(
          top: BorderSide(color: AppColors.borderColor.themeColor, width: 0.5),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: 16.paddingHorizontal + 14.paddingVert,
          child: CustomButton(
            onTap: onTap,
            loading: loading,
            title: LocaleKeys.orders_cancel_order.tr(),
            height: 50,
            fontSize: 14.sp,
            isOutlined: true,
            borderColor: danger,
            textColor: danger,
          ),
        ),
      ),
    );
  }
}

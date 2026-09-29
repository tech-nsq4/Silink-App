import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/app_text.dart';
import '../../data/models/order_status.dart';

class OrderStatusChip extends StatelessWidget {
  const OrderStatusChip({
    super.key,
    required this.status,
    required this.rawValue,
  });

  final OrderStatus status;
  final String rawValue;

  Color get _color => switch (status) {
        OrderStatus.placed => AppColors.blue.themeColor,
        OrderStatus.processing => AppColors.infoCardIcon.themeColor,
        OrderStatus.shipped => AppColors.purple.themeColor,
        OrderStatus.delivered => AppColors.successColor.themeColor,
        OrderStatus.cancelled => AppColors.saleRed.themeColor,
        OrderStatus.unknown => AppColors.textSecondaryColor.themeColor,
      };

  @override
  Widget build(BuildContext context) {
    final color = _color;
    final label =
        status == OrderStatus.unknown ? rawValue : status.labelKey.tr();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: AppText(
        label,
        fontSize: 11.sp,
        fontWeight: FontWeight.w800,
        color: color,
      ),
    );
  }
}

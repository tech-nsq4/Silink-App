import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_text.dart';
import '../../data/models/order_item_model.dart';
import 'order_product_row.dart';

class OrderProductsCard extends StatelessWidget {
  const OrderProductsCard({super.key, required this.items});

  final List<OrderItemModel> items;

  @override
  Widget build(BuildContext context) {
    final divider = Divider(
      height: 1,
      thickness: 0.6,
      color: AppColors.borderColor.themeColor.withValues(alpha: 0.12),
    );

    return AppCard(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 10.h),
            child: AppText(
              LocaleKeys.orders_products.tr(),
              fontSize: 14.sp,
              fontWeight: FontWeight.w800,
            ),
          ),
          for (final item in items) ...[
            divider,
            OrderProductRow(item: item),
          ],
        ],
      ),
    );
  }
}

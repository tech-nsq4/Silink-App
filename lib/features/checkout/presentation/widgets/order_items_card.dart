import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../cart/data/models/cart_item.dart';
import 'order_item_row.dart';

class OrderItemsCard extends StatelessWidget {
  const OrderItemsCard({super.key, required this.items});

  final List<CartItem> items;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          for (var index = 0; index < items.length; index++) ...[
            if (index > 0)
              Divider(
                height: 1,
                thickness: 0.6,
                color: AppColors.borderColor.themeColor.withValues(alpha: 0.12),
              ),
            OrderItemRow(item: items[index]),
          ],
        ],
      ),
    );
  }
}

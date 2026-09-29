import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../checkout/data/models/payment_method.dart';
import '../../../checkout/presentation/widgets/checkout_section_card.dart';
import '../../../checkout/presentation/widgets/order_detail_row.dart';
import '../../data/models/my_order_model.dart';

class OrderShippingCard extends StatelessWidget {
  const OrderShippingCard({super.key, required this.order});

  final MyOrderModel order;

  @override
  Widget build(BuildContext context) {
    final rows = <MapEntry<String, String>>[
      MapEntry(LocaleKeys.orders_name.tr(), order.fullName),
      MapEntry(LocaleKeys.orders_phone.tr(), order.phone),
      MapEntry(LocaleKeys.orders_city.tr(), order.city),
      MapEntry(LocaleKeys.orders_district.tr(), order.district),
      MapEntry(LocaleKeys.orders_street.tr(), order.street),
      MapEntry(LocaleKeys.orders_notes.tr(), order.notes),
      MapEntry(
        LocaleKeys.store_payment_method.tr(),
        order.paymentType.labelKey.tr(),
      ),
    ].where((row) => row.value.trim().isNotEmpty).toList(growable: false);

    return CheckoutSectionCard(
      title: LocaleKeys.orders_shipping_info.tr(),
      icon: Icons.local_shipping_outlined,
      child: Column(
        children: [
          for (var index = 0; index < rows.length; index++) ...[
            if (index > 0) 10.height,
            OrderDetailRow(label: rows[index].key, value: rows[index].value),
          ],
        ],
      ),
    );
  }
}

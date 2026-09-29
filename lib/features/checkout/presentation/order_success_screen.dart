import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/router/routes.dart';
import '../../../core/extensions/extensions.dart';
import '../../../core/utils/locale_keys.dart';
import '../../../core/widgets/bottom_action_bar.dart';
import '../data/models/order_model.dart';
import 'widgets/order_details_card.dart';
import 'widgets/order_items_card.dart';
import 'widgets/order_success_header.dart';

class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({super.key, required this.order});

  final OrderModel order;

  void _continueShopping(BuildContext context) {
    final navigator = Navigator.of(context);
    var reachedStore = false;
    navigator.popUntil((route) {
      reachedStore = route.settings.name == Routes.storeScreen;
      return reachedStore || route.isFirst;
    });
    if (!reachedStore) navigator.pushNamed(Routes.storeScreen);
  }

  void _backToHome(BuildContext context) => Navigator.of(context)
      .pushNamedAndRemoveUntil(Routes.layoutScreen, (_) => false);

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _continueShopping(context);
      },
      child: Scaffold(
        body: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(16.w, 32.h, 16.w, 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const OrderSuccessHeader(),
                22.height,
                OrderDetailsCard(order: order),
                14.height,
                OrderItemsCard(items: order.items),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomActionBar(
          title: LocaleKeys.store_continue_shopping.tr(),
          onTap: () => _continueShopping(context),
          secondaryTitle: LocaleKeys.store_back_to_home.tr(),
          onSecondaryTap: () => _backToHome(context),
        ),
      ),
    );
  }
}

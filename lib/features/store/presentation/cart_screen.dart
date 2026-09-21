import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/router/navigation_services.dart';
import '../../../app/router/routes.dart';
import '../../../core/extensions/extensions.dart';
import '../../../core/utils/convert_helper.dart';
import '../../../core/utils/locale_keys.dart';
import '../../../core/widgets/screen_header_bar.dart';
import '../data/models/product.dart';
import '../logic/cart_cubit.dart';
import '../logic/store_cubit.dart';
import 'widgets/cart_empty_view.dart';
import 'widgets/cart_item_tile.dart';
import 'widgets/order_summary_card.dart';
import 'widgets/store_action_bar.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  List<Color> _gradientOf(BuildContext context, String productId) =>
      context.read<StoreCubit>().productById(productId)?.imageGradient ??
      Product.fallbackGradient;

  void _continueShopping() => NavigationService.goBack();

  void _proceedToCheckout() => NavigationService.push(Routes.checkoutScreen);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ScreenHeaderBar(title: LocaleKeys.store_cart_title.tr()),
          Expanded(
            child: BlocBuilder<CartCubit, CartState>(
              builder: (context, state) {
                if (state.isEmpty) {
                  return const SingleChildScrollView(
                    padding: EdgeInsets.symmetric(vertical: 40),
                    child: CartEmptyView(),
                  );
                }

                return ListView.separated(
                  padding: EdgeInsets.symmetric(
                    horizontal: 19.w,
                    vertical: 16.h,
                  ),
                  itemCount: state.items.length + 1,
                  separatorBuilder: (_, __) => 12.height,
                  itemBuilder: (context, index) {
                    if (index == state.items.length) {
                      return OrderSummaryCard(
                        subtotal: state.subtotal,
                        shipping: state.shipping,
                        total: state.total,
                        note: LocaleKeys.store_shipping_at_checkout.tr(),
                      );
                    }

                    final item = state.items[index];
                    final cubit = context.read<CartCubit>();

                    return CartItemTile(
                      item: item,
                      gradient: _gradientOf(context, item.productId),
                      onIncrease: () =>
                          cubit.increase(item.productId, item.colorValue),
                      onDecrease: () =>
                          cubit.decrease(item.productId, item.colorValue),
                      onRemove: () => cubit.removeItem(
                        item.productId,
                        colorValue: item.colorValue,
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          final currency = LocaleKeys.store_currency.tr();
          final title = state.isEmpty
              ? LocaleKeys.store_continue_shopping.tr()
              : '${LocaleKeys.store_proceed_to_checkout.tr()} · '
                  '${ConvertHelper.formatPrice(state.total)} $currency';

          return StoreActionBar(
            title: title,
            onTap: state.isEmpty ? _continueShopping : _proceedToCheckout,
            secondaryTitle:
                state.isEmpty ? null : LocaleKeys.store_continue_shopping.tr(),
            onSecondaryTap: state.isEmpty ? null : _continueShopping,
          );
        },
      ),
    );
  }
}

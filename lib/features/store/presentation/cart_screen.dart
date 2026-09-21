import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/router/navigation_services.dart';
import '../../../app/router/routes.dart';
import '../../../core/extensions/extensions.dart';
import '../../../core/utils/convert_helper.dart';
import '../../../core/utils/locale_keys.dart';
import '../../../core/widgets/screen_header_bar.dart';
import '../models/cart_item.dart';
import '../models/demo_store_data.dart';
import '../models/store_catalog.dart';
import '../widgets/cart_empty_view.dart';
import '../widgets/cart_item_tile.dart';
import '../widgets/order_summary_card.dart';
import '../widgets/store_action_bar.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final List<CartItem> _items = [...DemoStoreData.cartItems];

  double get _subtotal =>
      _items.fold<double>(0, (sum, item) => sum + item.total);

  double get _shipping => _items.isEmpty ? 0 : DemoStoreData.shipping;

  double get _total => _subtotal + _shipping;

  List<Color> _gradientOf(String productId) =>
      StoreCatalog.productById(productId)?.imageGradient ??
      const [Color(0xFFD8D8D8), Color(0xFFB8B8B8)];

  void _continueShopping() => NavigationService.goBack();

  void _proceedToCheckout() => NavigationService.push(Routes.checkoutScreen);

  void _changeQuantity(CartItem item, int quantity) {
    setState(() {
      if (quantity < 1) {
        _items.remove(item);
        return;
      }
      final index = _items.indexOf(item);
      if (index == -1) return;
      _items[index] = CartItem(
        productId: item.productId,
        name: item.name,
        price: item.price,
        quantity: quantity,
        colorValue: item.colorValue,
        colorLabelKey: item.colorLabelKey,
        summary: item.summary,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final currency = LocaleKeys.store_currency.tr();
    final isEmpty = _items.isEmpty;

    return Scaffold(
      body: Column(
        children: [
          ScreenHeaderBar(title: LocaleKeys.store_cart_title.tr()),
          Expanded(
            child: isEmpty
                ? const SingleChildScrollView(
                    padding: EdgeInsets.symmetric(vertical: 40),
                    child: CartEmptyView(),
                  )
                : ListView.separated(
                    padding: EdgeInsets.symmetric(
                      horizontal: 19.w,
                      vertical: 16.h,
                    ),
                    itemCount: _items.length + 1,
                    separatorBuilder: (_, __) => 12.height,
                    itemBuilder: (context, index) {
                      if (index == _items.length) {
                        return OrderSummaryCard(
                          subtotal: _subtotal,
                          shipping: _shipping,
                          total: _total,
                          note: LocaleKeys.store_shipping_at_checkout.tr(),
                        );
                      }

                      final item = _items[index];

                      return CartItemTile(
                        item: item,
                        gradient: _gradientOf(item.productId),
                        onIncrease: () =>
                            _changeQuantity(item, item.quantity + 1),
                        onDecrease: () =>
                            _changeQuantity(item, item.quantity - 1),
                        onRemove: () => setState(() => _items.remove(item)),
                      );
                    },
                  ),
          ),
        ],
      ),
      bottomNavigationBar: StoreActionBar(
        title: isEmpty
            ? LocaleKeys.store_continue_shopping.tr()
            : '${LocaleKeys.store_proceed_to_checkout.tr()} · '
                '${ConvertHelper.formatPrice(_total)} $currency',
        onTap: isEmpty ? _continueShopping : _proceedToCheckout,
        secondaryTitle:
            isEmpty ? null : LocaleKeys.store_continue_shopping.tr(),
        onSecondaryTap: isEmpty ? null : _continueShopping,
      ),
    );
  }
}

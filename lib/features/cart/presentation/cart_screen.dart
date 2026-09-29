import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/router/navigation_services.dart';
import '../../../app/router/routes.dart';
import '../../../core/extensions/extensions.dart';
import '../../../core/utils/convert_helper.dart';
import '../../../core/utils/locale_keys.dart';
import '../../../core/widgets/bottom_action_bar.dart';
import '../../../core/widgets/screen_header_bar.dart';
import '../logic/cart_cubit.dart';
import 'widgets/cart_count_chip.dart';
import 'widgets/cart_empty_view.dart';
import 'widgets/cart_item_tile.dart';
import 'widgets/cart_summary_card.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  void _continueShopping() => NavigationService.goBack();

  void _proceedToCheckout() => NavigationService.push(Routes.checkoutScreen);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        final cubit = context.read<CartCubit>();

        return Scaffold(
          body: Column(
            children: [
              ScreenHeaderBar(
                title: LocaleKeys.store_cart_title.tr(),
                trailing: state.isEmpty
                    ? null
                    : CartCountChip(count: state.itemsCount),
              ),
              Expanded(
                child: state.isEmpty
                    ? const CartEmptyView()
                    : ListView.separated(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 14.h,
                        ),
                        itemCount: state.items.length + 1,
                        separatorBuilder: (_, __) => 12.height,
                        itemBuilder: (context, index) {
                          if (index == state.items.length) {
                            return CartSummaryCard(
                              subtotal: state.subtotal,
                              shipping: state.shipping,
                              total: state.total,
                            );
                          }

                          final item = state.items[index];

                          return CartItemTile(
                            item: item,
                            onQuantityChanged: (quantity) =>
                                cubit.updateQuantity(item, quantity),
                            onRemove: () => cubit.removeItem(item),
                          );
                        },
                      ),
              ),
            ],
          ),
          bottomNavigationBar: BottomActionBar(
            title: state.isEmpty
                ? LocaleKeys.store_continue_shopping.tr()
                : '${LocaleKeys.store_continue_to_payment.tr()} · '
                    '${ConvertHelper.formatPrice(state.total)} '
                    '${LocaleKeys.store_currency.tr()}',
            onTap: state.isEmpty ? _continueShopping : _proceedToCheckout,
            secondaryTitle:
                state.isEmpty ? null : LocaleKeys.store_continue_shopping.tr(),
            onSecondaryTap: state.isEmpty ? null : _continueShopping,
          ),
        );
      },
    );
  }
}

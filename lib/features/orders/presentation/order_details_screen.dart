import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/di/injection.dart';
import '../../../core/extensions/extensions.dart';
import '../../../core/utils/locale_keys.dart';
import '../../../core/widgets/screen_header_bar.dart';
import '../data/models/my_order_model.dart';
import '../logic/cancel_order_cubit.dart';
import 'widgets/cancel_order_bar.dart';
import 'widgets/cancel_order_dialog.dart';
import 'widgets/order_details_header.dart';
import 'widgets/order_products_card.dart';
import 'widgets/order_shipping_card.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({super.key, required this.order});

  final MyOrderModel order;

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  late final CancelOrderCubit _cubit = getIt<CancelOrderCubit>();
  late MyOrderModel _order = widget.order;

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  Future<void> _confirmCancel() async {
    final confirmed = await CancelOrderDialog.show(context);
    if (confirmed && mounted) _cubit.cancel(_order);
  }

  void _onCancelStateChanged(BuildContext context, CancelOrderState state) {
    if (state is CancelOrderSuccess) setState(() => _order = state.order);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) Navigator.of(context).pop(_order);
      },
      child: BlocConsumer<CancelOrderCubit, CancelOrderState>(
        bloc: _cubit,
        listener: _onCancelStateChanged,
        builder: (context, state) {
          return Scaffold(
            body: Column(
              children: [
                ScreenHeaderBar(title: LocaleKeys.orders_details_title.tr()),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 14.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        OrderDetailsHeader(order: _order),
                        14.height,
                        OrderProductsCard(items: _order.products),
                        14.height,
                        OrderShippingCard(order: _order),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            bottomNavigationBar: _order.canCancel
                ? CancelOrderBar(
                    onTap: _confirmCancel,
                    loading: state is CancelOrderLoading,
                  )
                : null,
          );
        },
      ),
    );
  }
}

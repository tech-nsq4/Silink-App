import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/router/navigation_services.dart';
import '../../../app/router/routes.dart';
import '../../../core/di/injection.dart';
import '../../../core/extensions/extensions.dart';
import '../../../core/utils/locale_keys.dart';
import '../../../core/widgets/screen_header_bar.dart';
import '../../../core/widgets/screen_state_layout.dart';
import '../data/models/my_order_model.dart';
import '../logic/orders_cubit.dart';
import 'widgets/order_card.dart';
import 'widgets/orders_empty_view.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  late final OrdersCubit _cubit = getIt<OrdersCubit>()..getOrders();

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  Future<void> _openOrder(MyOrderModel order) async {
    final result = await NavigationService.push(
      Routes.orderDetailsScreen,
      arguments: {'order': order},
    );
    if (result is MyOrderModel) _cubit.replaceOrder(result);
  }

  void _openStore() => NavigationService.push(Routes.storeScreen);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ScreenHeaderBar(title: LocaleKeys.orders_title.tr()),
          Expanded(
            child: BlocBuilder<OrdersCubit, OrdersState>(
              bloc: _cubit,
              builder: (context, state) {
                final orders = state is OrdersSuccess
                    ? state.orders
                    : const <MyOrderModel>[];

                return CustomScreenStateLayout(
                  isLoading: state is OrdersInitial || state is OrdersLoading,
                  error: state is OrdersError
                      ? ErrorModel(
                          code: ErrorEnum.otherError,
                          errorMessage: state.message,
                        )
                      : null,
                  isEmpty: state is OrdersSuccess && orders.isEmpty,
                  noDataBuilder: (_) => OrdersEmptyView(onShopNow: _openStore),
                  onRetry: _cubit.getOrders,
                  onRefresh: _cubit.refresh,
                  builder: (context) => ListView.separated(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 14.h,
                    ),
                    itemCount: orders.length,
                    separatorBuilder: (_, __) => 12.height,
                    itemBuilder: (context, index) => OrderCard(
                      order: orders[index],
                      onTap: () => _openOrder(orders[index]),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

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
import '../../cart/presentation/widgets/cart_badge_button.dart';
import '../data/models/product.dart';
import '../data/models/product_filters.dart';
import '../logic/store_cubit.dart';
import '../widgets/category_filter_chips.dart';
import '../widgets/product_grid.dart';
import '../widgets/product_search_field.dart';
import '../widgets/section_header.dart';
import '../widgets/special_offer_card.dart';
import '../widgets/store_breadcrumb.dart';
import '../widgets/view_all_products_button.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  late final StoreCubit _cubit = getIt<StoreCubit>()..getProducts();

  String _searchQuery = '';
  ProductCategory? _category;

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  void _openProduct(Product product) => NavigationService.push(
        Routes.productDetailsScreen,
        arguments: {'product': product},
      );

  void _openProducts(List<Product> products, ProductCategory? category) =>
      NavigationService.push(
        Routes.categoryProductsScreen,
        arguments: {'products': products, 'category': category},
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ScreenHeaderBar(
            title: LocaleKeys.store_title.tr(),
            trailing: const CartBadgeButton(),
          ),
          Expanded(
            child: BlocBuilder<StoreCubit, StoreState>(
              bloc: _cubit,
              builder: (context, state) {
                final products =
                    state is StoreSuccess ? state.products : const <Product>[];

                return CustomScreenStateLayout(
                  isLoading: state is StoreInitial || state is StoreLoading,
                  error: state is StoreError
                      ? ErrorModel(
                          code: ErrorEnum.otherError,
                          errorMessage: state.message,
                        )
                      : null,
                  isEmpty: state is StoreSuccess && products.isEmpty,
                  onRetry: _cubit.getProducts,
                  onRefresh: _cubit.refresh,
                  builder: (context) => _buildContent(products),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(List<Product> products) {
    final categories = products
        .map((product) => product.category)
        .whereType<ProductCategory>()
        .toSet()
        .toList(growable: false);
    final filtered = ProductFilters.search(
      ProductFilters.byCategory(products, _category),
      _searchQuery,
    );
    final offers = filtered.where((product) => product.isDiscounted).toList();

    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const StoreBreadcrumb(),
          12.height,
          ProductSearchField(
            onChanged: (value) => setState(() => _searchQuery = value),
          ),
          if (categories.isNotEmpty) ...[
            12.height,
            CategoryFilterChips(
              categories: categories,
              selected: _category,
              onSelected: (category) => setState(() => _category = category),
            ),
          ],
          if (offers.isNotEmpty) ...[
            20.height,
            SectionHeader(
              title: LocaleKeys.store_offers.tr(),
              onViewAll: () => _openProducts(offers, null),
            ),
            10.height,
            SpecialOfferCard(
              product: offers.first,
              onTap: () => _openProduct(offers.first),
            ),
          ],
          20.height,
          SectionHeader(
            title: LocaleKeys.store_featured_products.tr(),
            onViewAll: () => _openProducts(products, _category),
          ),
          10.height,
          ProductGrid(products: filtered, onProductTap: _openProduct),
          16.height,
          ViewAllProductsButton(
            count: products.length,
            onTap: () => _openProducts(products, null),
          ),
        ],
      ),
    );
  }
}

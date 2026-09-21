import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/router/navigation_services.dart';
import '../../../app/router/routes.dart';
import '../../../core/extensions/extensions.dart';
import '../../../core/utils/locale_keys.dart';
import '../../../core/widgets/screen_header_bar.dart';
import '../../../core/widgets/screen_state_layout.dart';
import '../data/models/product.dart';
import '../logic/product_filters.dart';
import '../logic/store_cubit.dart';
import 'widgets/cart_badge_button.dart';
import 'widgets/product_grid.dart';
import 'widgets/product_search_field.dart';
import 'widgets/products_sort_bar.dart';

class CategoryProductsScreen extends StatefulWidget {
  const CategoryProductsScreen({super.key, this.category});

  final ProductCategory? category;

  @override
  State<CategoryProductsScreen> createState() => _CategoryProductsScreenState();
}

class _CategoryProductsScreenState extends State<CategoryProductsScreen> {
  String _searchQuery = '';
  SortOption _sortOption = SortOption.featured;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) context.read<StoreCubit>().loadProducts();
    });
  }

  ErrorModel? _errorOf(StoreState state) => state is StoreError
      ? ErrorModel(code: ErrorEnum.otherError, errorMessage: state.message)
      : null;

  void _openProduct(Product product) {
    NavigationService.push(
      Routes.productDetailsScreen,
      arguments: {'productId': product.id},
    );
  }

  @override
  Widget build(BuildContext context) {
    final category = widget.category;
    final title = category == null
        ? LocaleKeys.store_products_title.tr()
        : category.labelKey.tr();

    return Scaffold(
      body: Column(
        children: [
          ScreenHeaderBar(
            title: title,
            trailing: CartBadgeButton(
              onTap: () => NavigationService.push(Routes.cartScreen),
            ),
          ),
          Expanded(
            child: BlocBuilder<StoreCubit, StoreState>(
              builder: (context, state) {
                final cubit = context.read<StoreCubit>();
                final products = ProductFilters.sorted(
                  ProductFilters.search(
                    ProductFilters.byCategory(cubit.products, category),
                    _searchQuery,
                  ),
                  _sortOption,
                );

                return CustomScreenStateLayout(
                  isLoading: state is StoreLoading || state is StoreInitial,
                  error: _errorOf(state),
                  onRetry: () => cubit.loadProducts(force: true),
                  builder: (context) => SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: 19.w,
                      vertical: 16.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ProductSearchField(
                          onChanged: (value) =>
                              setState(() => _searchQuery = value),
                        ),
                        16.height,
                        ProductsSortBar(
                          sortOption: _sortOption,
                          onSortChanged: (option) =>
                              setState(() => _sortOption = option),
                          productsCount: products.length,
                        ),
                        16.height,
                        ProductGrid(
                          products: products,
                          onProductTap: _openProduct,
                        ),
                      ],
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

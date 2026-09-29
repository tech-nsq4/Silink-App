import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/router/navigation_services.dart';
import '../../../app/router/routes.dart';
import '../../../core/extensions/extensions.dart';
import '../../../core/utils/locale_keys.dart';
import '../../../core/widgets/screen_header_bar.dart';
import '../../cart/presentation/widgets/cart_badge_button.dart';
import '../data/models/product.dart';
import '../data/models/product_filters.dart';
import '../widgets/product_grid.dart';
import '../widgets/product_search_field.dart';
import '../widgets/products_sort_bar.dart';

class CategoryProductsScreen extends StatefulWidget {
  const CategoryProductsScreen({
    super.key,
    required this.products,
    this.category,
  });

  final List<Product> products;
  final ProductCategory? category;

  @override
  State<CategoryProductsScreen> createState() => _CategoryProductsScreenState();
}

class _CategoryProductsScreenState extends State<CategoryProductsScreen> {
  String _searchQuery = '';
  SortOption _sortOption = SortOption.featured;

  void _openProduct(Product product) {
    NavigationService.push(
      Routes.productDetailsScreen,
      arguments: {'product': product},
    );
  }

  @override
  Widget build(BuildContext context) {
    final category = widget.category;
    final title = category == null
        ? LocaleKeys.store_products_title.tr()
        : category.labelKey.tr();

    final products = ProductFilters.sorted(
      ProductFilters.search(
        ProductFilters.byCategory(widget.products, category),
        _searchQuery,
      ),
      _sortOption,
    );

    return Scaffold(
      body: Column(
        children: [
          ScreenHeaderBar(
            title: title,
            trailing: const CartBadgeButton(),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: 19.w,
                vertical: 16.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ProductSearchField(
                    onChanged: (value) => setState(() => _searchQuery = value),
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
          ),
        ],
      ),
    );
  }
}

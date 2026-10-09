import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/router/navigation_services.dart';
import '../../../app/router/routes.dart';
import '../../../core/di/injection.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_overlay.dart';
import '../../../core/utils/locale_keys.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/flow_top_bar.dart';
import '../../../core/widgets/screen_state_layout.dart';
import '../../cart/data/models/cart_item.dart';
import '../../cart/logic/cart_cubit.dart';
import '../data/models/product.dart';
import '../data/models/product_filters.dart';
import '../logic/store_cubit.dart';
import '../widgets/shop_cart_button.dart';
import '../../../core/widgets/filter_chips_bar.dart';
import '../widgets/shop_features_row.dart';
import '../widgets/shop_hero_banner.dart';
import '../widgets/shop_product_card.dart';
import '../widgets/shop_search_field.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  late final StoreCubit _cubit = getIt<StoreCubit>()..getProducts();
  final _productsKey = GlobalKey();

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

  void _quickAdd(Product product) {
    context.read<CartCubit>().addItem(CartItem.fromProduct(product));
    AppOverlay.showSuccess(LocaleKeys.store_added_to_cart.tr());
  }

  void _discover() {
    setState(() => _category = ProductCategory.nfcCards);
    final target = _productsKey.currentContext;
    if (target != null) {
      Scrollable.ensureVisible(
        target,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor.themeColor,
      body: Column(
        children: [
          SafeArea(
            bottom: false,
            child: FlowTopBar(
              eyebrow: LocaleKeys.shop_headerEyebrow.tr(),
              title: LocaleKeys.shop_headerTitle.tr(),
              action: const ShopCartButton(),
            ),
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
                  builder: (context) => _content(products),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _content(List<Product> products) {
    final categories = products
        .map((product) => product.category)
        .whereType<ProductCategory>()
        .toSet()
        .toList(growable: false);
    final filtered = ProductFilters.search(
      ProductFilters.byCategory(products, _category),
      _searchQuery,
    );
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      padding: EdgeInsets.fromLTRB(22.w, 8.h, 22.w, 28.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ShopHeroBanner(onDiscover: _discover),
          const ShopFeaturesRow(),
          ShopSearchField(
            onChanged: (value) => setState(() => _searchQuery = value),
          ),
          SizedBox(height: 14.h),
          FilterChipsBar<ProductCategory>(
            allLabel: LocaleKeys.shop_all.tr(),
            options: categories,
            labelOf: (category) => category.labelKey.tr(),
            selected: _category,
            onSelected: (category) => setState(() => _category = category),
          ),
          SizedBox(height: 24.h),
          AppText(
            LocaleKeys.shop_pickTitle.tr(),
            key: _productsKey,
            fontSize: 15.sp,
            fontWeight: FontWeight.w800,
          ),
          SizedBox(height: 5.h),
          AppText(
            LocaleKeys.shop_productsCount.tr(args: ['${filtered.length}']),
            fontSize: 8.5.sp,
            color: AppColors.textSecondaryColor.themeColor,
          ),
          SizedBox(height: 14.h),
          if (filtered.isEmpty)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 30.h),
              child: AppText(
                LocaleKeys.shop_empty.tr(),
                fontSize: 10.sp,
                textAlign: TextAlign.center,
                color: AppColors.textSecondaryColor.themeColor,
              ),
            )
          else
            GridView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: filtered.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12.h,
                crossAxisSpacing: 12.w,
                mainAxisExtent: 238.h,
              ),
              itemBuilder: (context, index) {
                final product = filtered[index];
                return ShopProductCard(
                  product: product,
                  onTap: () => _openProduct(product),
                  onAdd: () => _quickAdd(product),
                );
              },
            ),
        ],
      ),
    );
  }
}

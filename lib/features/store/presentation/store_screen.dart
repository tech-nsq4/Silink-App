import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/router/navigation_services.dart';
import '../../../app/router/routes.dart';
import '../../../core/extensions/extensions.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/locale_keys.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/screen_header_bar.dart';
import '../../../core/widgets/screen_state_layout.dart';
import '../data/models/product.dart';
import '../logic/product_filters.dart';
import '../logic/store_cubit.dart';
import 'widgets/cart_badge_button.dart';
import 'widgets/category_filter_chips.dart';
import 'widgets/product_grid.dart';
import 'widgets/product_search_field.dart';
import 'widgets/section_header.dart';
import 'widgets/special_offer_card.dart';
import 'widgets/store_breadcrumb.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  String _searchQuery = '';

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

  void _openCategoryProducts(ProductCategory? category) {
    NavigationService.push(
      Routes.categoryProductsScreen,
      arguments: {'category': category},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ScreenHeaderBar(
            title: LocaleKeys.store_title.tr(),
            trailing: CartBadgeButton(
              onTap: () => NavigationService.push(Routes.cartScreen),
            ),
          ),
          Expanded(
            child: BlocBuilder<StoreCubit, StoreState>(
              builder: (context, state) {
                final cubit = context.read<StoreCubit>();
                final products = cubit.products;
                final visibleProducts =
                    ProductFilters.search(products, _searchQuery);
                final specialOffer = cubit.specialOffer;

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
                        const StoreBreadcrumb(),
                        12.height,
                        ProductSearchField(
                          onChanged: (value) =>
                              setState(() => _searchQuery = value),
                        ),
                        12.height,
                        CategoryFilterChips(
                          selected: null,
                          onSelected: _openCategoryProducts,
                        ),
                        if (specialOffer != null) ...[
                          16.height,
                          SectionHeader(
                            title: LocaleKeys.store_offers.tr(),
                            onViewAll: () => _openCategoryProducts(null),
                          ),
                          12.height,
                          SpecialOfferCard(
                            product: specialOffer,
                            onTap: () => _openProduct(specialOffer),
                          ),
                        ],
                        16.height,
                        SectionHeader(
                          title: LocaleKeys.store_featured_products.tr(),
                          onViewAll: () => _openCategoryProducts(null),
                        ),
                        12.height,
                        ProductGrid(
                          products: visibleProducts,
                          onProductTap: _openProduct,
                        ),
                        16.height,
                        DottedBorder(
                          options: RoundedRectDottedBorderOptions(
                            dashPattern: [10, 5],
                            strokeWidth: 2,
                            radius: Radius.circular(16.r),
                            color: AppColors.borderColor.themeColor,
                          ),
                          child: CustomButton(
                            onTap: () => _openCategoryProducts(null),
                            title: LocaleKeys.store_view_all_count.tr(
                              namedArgs: {'count': '${products.length}'},
                            ),
                            color: AppColors.backgroundColor.themeColor,
                            textColor: AppColors.textPrimaryColor.themeColor,
                          ),
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

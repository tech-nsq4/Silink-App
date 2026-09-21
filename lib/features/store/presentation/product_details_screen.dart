import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/router/navigation_services.dart';
import '../../../app/router/routes.dart';
import '../../../core/extensions/extensions.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/locale_keys.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/screen_header_bar.dart';
import '../models/store_catalog.dart';
import '../widgets/cart_badge_button.dart';
import '../widgets/package_contents_list.dart';
import '../widgets/product_color_swatches.dart';
import '../widgets/product_details_hero.dart';
import '../widgets/product_details_summary.dart';
import '../widgets/product_info_row.dart';
import '../widgets/product_purchase_bar.dart';
import '../widgets/products_empty_view.dart';
import '../widgets/quantity_stepper.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.productId});

  final String productId;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int _quantity = 1;
  int? _selectedColorIndex;

  @override
  Widget build(BuildContext context) {
    final product = StoreCatalog.productById(widget.productId);

    if (product == null) {
      return Scaffold(
        body: Column(
          children: [
            ScreenHeaderBar(title: LocaleKeys.store_products_title.tr()),
            const Expanded(child: ProductsEmptyView()),
          ],
        ),
      );
    }

    final selectedColorIndex =
        _selectedColorIndex ?? product.defaultColorIndex;

    return Scaffold(
      body: Column(
        children: [
          ScreenHeaderBar(
            title: product.name,
            trailing: CartBadgeButton(
              onTap: () => NavigationService.push(Routes.cartScreen),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: 16.paddingBottom,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ProductDetailsHero(product: product),
                  ProductDetailsSummary(product: product),
                  16.height,
                  Padding(
                    padding: 19.paddingHorizontal,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Divider(
                          height: 1,
                          color: AppColors.borderColor.themeColor,
                        ),
                        16.height,
                        if (product.hasColors) ...[
                          AppText(
                            LocaleKeys.store_color.tr(),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                          ),
                          6.height,
                          ProductColorSwatches(
                            product: product,
                            selectedIndex: selectedColorIndex,
                            onSelected: (index) =>
                                setState(() => _selectedColorIndex = index),
                          ),
                          16.height,
                        ],
                        AppText(
                          LocaleKeys.store_quantity.tr(),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                        ),
                        10.height,
                        QuantityStepper(
                          quantity: _quantity,
                          onChanged: (value) =>
                              setState(() => _quantity = value),
                        ),
                        16.height,
                        Divider(
                          height: 1,
                          color: AppColors.borderColor.themeColor,
                        ),
                        16.height,
                        if (product.compatibility.trim().isNotEmpty)
                          ProductInfoRow(
                            label: LocaleKeys.store_compatibility.tr(),
                            value: product.compatibility,
                          ),
                        if (product.deliveryTime.trim().isNotEmpty) ...[
                          8.height,
                          ProductInfoRow(
                            label: LocaleKeys.store_delivery.tr(),
                            value: product.deliveryTime,
                          ),
                        ],
                        if (product.packageContents.isNotEmpty) ...[
                          16.height,
                          AppText(
                            LocaleKeys.store_package_contents.tr(),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,
                          ),
                          10.height,
                          PackageContentsList(
                            items: product.packageContents,
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: ProductPurchaseBar(
        product: product,
        quantity: _quantity,
        colorIndex: selectedColorIndex,
      ),
    );
  }
}

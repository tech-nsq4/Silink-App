import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/extensions/extensions.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/locale_keys.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/quantity_stepper.dart';
import '../../../core/widgets/screen_header_bar.dart';
import '../../cart/presentation/widgets/cart_badge_button.dart';
import '../data/models/product.dart';
import '../widgets/package_contents_list.dart';
import '../widgets/product_color_swatches.dart';
import '../widgets/product_details_hero.dart';
import '../widgets/product_details_summary.dart';
import '../widgets/product_info_row.dart';
import '../widgets/product_purchase_bar.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.product});

  final Product product;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int _quantity = 1;
  int? _selectedColorIndex;

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final selectedColorIndex = _selectedColorIndex ?? product.defaultColorIndex;

    return Scaffold(
      body: Column(
        children: [
          ScreenHeaderBar(
            title: product.name,
            trailing: const CartBadgeButton(),
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
                    padding: 16.paddingHorizontal,
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
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w800,
                          ),
                          10.height,
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
                        ProductInfoRow(
                          label: LocaleKeys.store_compatibility.tr(),
                          value: product.compatibility.trim().isNotEmpty
                              ? product.compatibility
                              : LocaleKeys.store_default_compatibility.tr(),
                        ),
                        10.height,
                        ProductInfoRow(
                          label: LocaleKeys.store_delivery.tr(),
                          value: product.deliveryTime.trim().isNotEmpty
                              ? product.deliveryTime
                              : LocaleKeys.store_delivery_days.tr(),
                        ),
                        16.height,
                        AppText(
                          LocaleKeys.store_package_contents.tr(),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textSecondaryColor.themeColor,
                        ),
                        10.height,
                        PackageContentsList(
                          items: product.packageContents.isNotEmpty
                              ? product.packageContents
                              : [
                                  LocaleKeys.store_package_item_product
                                      .tr(namedArgs: {'name': product.name}),
                                  LocaleKeys.store_package_item_guide.tr(),
                                  LocaleKeys.store_package_item_qr.tr(),
                                ],
                        ),
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

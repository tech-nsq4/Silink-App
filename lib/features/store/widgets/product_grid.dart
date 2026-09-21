import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/app_constants.dart';
import '../models/product.dart';
import 'product_grid_card.dart';
import 'products_empty_view.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({super.key, required this.products, this.onProductTap});

  final List<Product> products;
  final ValueChanged<Product>? onProductTap;

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) return const ProductsEmptyView();

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: AppConstants.storeGridColumns,
        mainAxisSpacing: 12.h,
        crossAxisSpacing: 12.w,
        childAspectRatio: AppConstants.productGridAspectRatio,
      ),
      itemBuilder: (context, index) {
        final product = products[index];
        return ProductGridCard(
          product: product,
          onTap: onProductTap == null ? null : () => onProductTap!(product),
        );
      },
    );
  }
}

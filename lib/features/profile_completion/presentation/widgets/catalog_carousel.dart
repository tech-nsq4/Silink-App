import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/convert_helper.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/features/profile_completion/data/models/catalog_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'product_preview_card.dart';

class CatalogCarousel extends StatelessWidget {
  const CatalogCarousel({
    super.key,
    required this.items,
    required this.onItemTap,
  });

  final List<CatalogItemModel> items;
  final ValueChanged<CatalogItemModel> onItemTap;

  String _kindLabel(String kind) => kind == 'service'
      ? LocaleKeys.products_kindService.tr()
      : LocaleKeys.products_kindProduct.tr();

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: 205.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: items.length,
        separatorBuilder: (_, __) => 10.width,
        itemBuilder: (context, index) {
          final item = items[index];
          return SizedBox(
            width: 140.w,
            child: InkWell(
              onTap: () => onItemTap(item),
              borderRadius: BorderRadius.circular(16.r),
              child: ProductPreviewCard(
                name: item.name,
                kindLabel: _kindLabel(item.kind),
                price: item.priceLabel.isEmpty
                    ? ConvertHelper.formatPriceWithCurrency(item.price)
                    : '${item.priceLabel} ${ConvertHelper.formatPriceWithCurrency(item.price)}',
                imageUrl: item.imageUrl,
              ),
            ),
          );
        },
      ),
    );
  }
}

import '../../../core/utils/locale_keys.dart';
import 'product.dart';

enum SortOption { featured, mostOrdered, priceLowToHigh, priceHighToLow }

extension SortOptionX on SortOption {
  String get labelKey => switch (this) {
        SortOption.featured => LocaleKeys.store_sort_featured,
        SortOption.mostOrdered => LocaleKeys.store_sort_most_ordered,
        SortOption.priceLowToHigh => LocaleKeys.store_sort_price_low,
        SortOption.priceHighToLow => LocaleKeys.store_sort_price_high,
      };
}

class ProductFilters {
  ProductFilters._();

  static List<Product> search(List<Product> products, String query) {
    final normalized = query.trim().toLowerCase();
    if (normalized.isEmpty) return products;
    return products
        .where((product) =>
            product.name.toLowerCase().contains(normalized) ||
            product.description.toLowerCase().contains(normalized) ||
            product.category.value.contains(normalized))
        .toList(growable: false);
  }

  static List<Product> byCategory(
    List<Product> products,
    ProductCategory? category,
  ) {
    if (category == null) return products;
    return products
        .where((product) => product.category == category)
        .toList(growable: false);
  }

  static List<Product> sorted(List<Product> products, SortOption option) {
    final result = [...products];
    switch (option) {
      case SortOption.featured:
        break;
      case SortOption.mostOrdered:
        result.sort(
          (a, b) => (b.reviewCount ?? 0).compareTo(a.reviewCount ?? 0),
        );
      case SortOption.priceLowToHigh:
        result.sort((a, b) => a.price.compareTo(b.price));
      case SortOption.priceHighToLow:
        result.sort((a, b) => b.price.compareTo(a.price));
    }
    return result;
  }
}

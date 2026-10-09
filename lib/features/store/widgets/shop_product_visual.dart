import 'package:flutter/material.dart';

import '../../../core/utils/app_colors.dart';
import '../data/models/product.dart';
import 'shop_tilted_card.dart';

class ShopProductVisual extends StatelessWidget {
  const ShopProductVisual({
    super.key,
    required this.product,
    required this.cardWidth,
    this.colorIndex,
  });

  final Product product;
  final double cardWidth;
  final int? colorIndex;

  @override
  Widget build(BuildContext context) {
    final color = product.hasColors
        ? product.colorAt(colorIndex ?? product.defaultColorIndex)
        : AppColors.studioCardStart.themeColor;
    final fallback = Center(
      child: ShopTiltedCard(color: color, width: cardWidth),
    );
    if (!product.hasImage) return fallback;
    return Image.network(
      product.image,
      fit: BoxFit.contain,
      errorBuilder: (_, __, ___) => fallback,
      loadingBuilder: (_, child, progress) =>
          progress == null ? child : fallback,
    );
  }
}

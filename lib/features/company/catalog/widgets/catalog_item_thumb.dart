import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/features/company/data/models/company_catalog_item.dart';

class CatalogItemThumb extends StatelessWidget {
  const CatalogItemThumb({
    super.key,
    required this.item,
    this.category,
    this.radius = 14,
    this.iconSize = 30,
  });

  final CompanyCatalogItem item;
  final CompanyCatalogCategory? category;
  final double radius;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final imageUrl = item.imageUrl?.trim();
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius.r),
      child: imageUrl == null || imageUrl.isEmpty
          ? _placeholder()
          : Image.network(
              imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              errorBuilder: (_, __, ___) => _placeholder(),
            ),
    );
  }

  Widget _placeholder() {
    final gradient =
        category?.gradient ?? const [Color(0xFFD8D8D8), Color(0xFFB8B8B8)];
    return Container(
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Icon(
        category?.icon ?? Icons.local_dining_outlined,
        size: iconSize.sp,
        color: AppColors.overlayOnDark.themeColor.withValues(alpha: 0.9),
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/app_text.dart';
import '../models/product.dart';

class ProductBadgePill extends StatelessWidget {
  const ProductBadgePill(
      {super.key, required this.badge, this.compact = false});

  final ProductBadge badge;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    if (badge == ProductBadge.none) return const SizedBox.shrink();

    final isBestSeller = badge == ProductBadge.bestSeller;
    final background = compact
        ? (isBestSeller
            ? AppColors.dropdownSurface.themeColor
            : AppColors.white.themeColor)
        : AppColors.white.themeColor.withValues(alpha: 0.9);
    final textColor = compact
        ? (isBestSeller
            ? AppColors.overlayOnDark.themeColor
            : AppColors.saleRed.themeColor)
        : AppColors.textPrimaryColor.themeColor;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: (compact ? 8 : 12).w,
        vertical: (compact ? 3 : 4).h,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: AppText(
        badge.labelKey.tr(),
        fontSize: (compact ? 8 : 12).sp,
        fontWeight: FontWeight.w700,
        color: textColor,
      ),
    );
  }
}

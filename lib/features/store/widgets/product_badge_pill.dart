import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/app_text.dart';
import '../data/models/product.dart';

class ProductBadgePill extends StatelessWidget {
  const ProductBadgePill({
    super.key,
    required this.badge,
    this.compact = false,
    this.tinted = false,
  });

  final ProductBadge badge;
  final bool compact;
  final bool tinted;

  @override
  Widget build(BuildContext context) {
    if (badge == ProductBadge.none) return const SizedBox.shrink();

    final isSpecialOffer = badge == ProductBadge.specialOffer;
    final background = !tinted
        ? AppColors.cardColor.themeColor.withValues(alpha: 0.95)
        : isSpecialOffer
            ? AppColors.saleRedSoft.themeColor
            : AppColors.dropdownSurface.themeColor;
    final textColor = !tinted
        ? AppColors.textPrimaryColor.themeColor
        : isSpecialOffer
            ? AppColors.saleRed.themeColor
            : AppColors.overlayOnDark.themeColor;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: (compact ? 8 : 12).w,
        vertical: (compact ? 3 : 5).h,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: AppText(
        badge.labelKey.tr(),
        fontSize: (compact ? 9.5 : 12).sp,
        fontWeight: FontWeight.w800,
        color: textColor,
      ),
    );
  }
}

import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:Silink/features/company/data/models/company_catalog_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'catalog_item_thumb.dart';

class CatalogItemCard extends StatelessWidget {
  const CatalogItemCard({
    super.key,
    required this.item,
    this.category,
    required this.onTap,
    this.onAdd,
    this.showHiddenBadge = false,
  });

  final CompanyCatalogItem item;
  final CompanyCatalogCategory? category;
  final VoidCallback onTap;
  final VoidCallback? onAdd;
  final bool showHiddenBadge;

  @override
  Widget build(BuildContext context) {
    final hasPrice = item.price.trim().isNotEmpty;
    return Material(
      color: AppColors.cardColor.themeColor,
      borderRadius: BorderRadius.circular(16.r),
      clipBehavior: Clip.antiAlias,
      elevation: 1,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned.fill(
                    child: CatalogItemThumb(
                      item: item,
                      category: category,
                      radius: 0,
                    ),
                  ),
                  if (showHiddenBadge && !item.visible)
                    PositionedDirectional(
                      start: 6.w,
                      top: 6.h,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 7.w,
                          vertical: 2.h,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFEF3C7),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: AppText(
                          LocaleKeys.company_hidden.tr(),
                          fontSize: 9.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF92400E),
                        ),
                      ),
                    ),
                  if (onAdd != null)
                    PositionedDirectional(
                      end: 6.w,
                      bottom: 6.h,
                      child: _AddButton(onTap: onAdd!),
                    ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  5.height,
                  AppText(
                    item.name,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (hasPrice)
                    AppText(
                      '${item.price} ${LocaleKeys.store_currency.tr()}',
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w700,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      color: AppColors.companyBrand.themeColor,
                    )
                  else
                    AppText(
                      LocaleKeys.company_no_price.tr(),
                      fontSize: 10.sp,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      color: AppColors.textSecondaryColor.themeColor,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  const _AddButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18.r),
      child: Container(
        width: 30.w,
        height: 30.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.cardColor.themeColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.12),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(
          Icons.add_rounded,
          size: 18.sp,
          color: AppColors.companyBrand.themeColor,
        ),
      ),
    );
  }
}

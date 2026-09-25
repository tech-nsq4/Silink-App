import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:Silink/features/company/data/models/company_catalog_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'catalog_item_thumb.dart';

class CatalogItemDetailsContent extends StatelessWidget {
  const CatalogItemDetailsContent({
    super.key,
    required this.item,
    required this.category,
    this.providerName,
    this.providerType,
    this.providerCity,
    this.showHiddenBadge = false,
  });

  final CompanyCatalogItem item;
  final CompanyCatalogCategory? category;
  final String? providerName;
  final String? providerType;
  final String? providerCity;
  final bool showHiddenBadge;

  String get _price {
    final amount = item.price.trim();
    final label = item.priceLabel.trim();
    final currency = LocaleKeys.store_currency.tr();
    return label.isEmpty ? '$amount $currency' : '$label $amount $currency';
  }

  @override
  Widget build(BuildContext context) {
    final normalizedProviderName = providerName?.trim() ?? '';
    final normalizedProviderType = providerType?.trim() ?? '';
    final normalizedProviderCity = providerCity?.trim() ?? '';
    final hasProviderInfo = normalizedProviderName.isNotEmpty ||
        normalizedProviderType.isNotEmpty ||
        normalizedProviderCity.isNotEmpty;
    final hasPrice = item.price.trim().isNotEmpty;
    final hasDescription = item.description.trim().isNotEmpty;
    final typeLabel = category?.id == 'service'
        ? LocaleKeys.company_kind_service.tr()
        : LocaleKeys.company_kind_product.tr();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Stack(
          children: [
            AspectRatio(
              aspectRatio: 1.06,
              child: CatalogItemThumb(
                item: item,
                category: category,
                radius: 0,
                iconSize: 68,
              ),
            ),
            if (showHiddenBadge && !item.visible)
              PositionedDirectional(
                start: 12.w,
                top: 12.h,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 5.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEF3C7),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: AppText(
                    LocaleKeys.company_hidden.tr(),
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF92400E),
                  ),
                ),
              ),
          ],
        ),
        ColoredBox(
          color: AppColors.catalogDetailsBackground.themeColor,
          child: Padding(
            padding: EdgeInsets.fromLTRB(16.w, 15.h, 16.w, 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (hasPrice)
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 7.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.cardColor.themeColor,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: AppText(
                          _price,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                          maxLines: 1,
                        ),
                      ),
                    ),
                  ),
                10.height,
                AppText(
                  typeLabel,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textSecondaryColor.themeColor,
                ),
                10.height,
                AppText(
                  item.name,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w800,
                  height: 1.25,
                ),
                if (hasDescription) ...[
                  8.height,
                  AppText(
                    item.description,
                    fontSize: 14.sp,
                    height: 1.45,
                    color: AppColors.textSecondaryColor.themeColor,
                  ),
                ],
                if (hasProviderInfo) ...[
                  18.height,
                  _ProviderDetailsCard(
                    providerName: normalizedProviderName,
                    providerType: normalizedProviderType,
                    providerCity: normalizedProviderCity,
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ProviderDetailsCard extends StatelessWidget {
  const _ProviderDetailsCard({
    required this.providerName,
    required this.providerType,
    required this.providerCity,
  });

  final String providerName;
  final String providerType;
  final String providerCity;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(14.w, 11.h, 14.w, 12.h),
      decoration: BoxDecoration(
        color: AppColors.cardColor.themeColor,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.dividerColor.themeColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            LocaleKeys.company_provided_by.tr(),
            fontSize: 10.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.textSecondaryColor.themeColor,
          ),
          if (providerName.isNotEmpty) ...[
            3.height,
            AppText(
              providerName,
              fontSize: 14.sp,
              fontWeight: FontWeight.w800,
            ),
          ],
          if (providerType.isNotEmpty) ...[
            3.height,
            AppText(
              providerType,
              fontSize: 12.sp,
              color: AppColors.textSecondaryColor.themeColor,
            ),
          ],
          if (providerCity.isNotEmpty) ...[
            3.height,
            AppText(
              providerCity,
              fontSize: 12.sp,
              color: AppColors.textSecondaryColor.themeColor,
            ),
          ],
        ],
      ),
    );
  }
}

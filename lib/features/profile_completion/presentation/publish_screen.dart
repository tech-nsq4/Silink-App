import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/app_overlay.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:Silink/features/profile_completion/models/profile_completion_data.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widgets/product_preview_card.dart';

class PublishStep extends StatelessWidget {
  const PublishStep({
    super.key,
    required this.data,
    required this.onViewAllProducts,
  });

  final ProfileCompletionData data;
  final VoidCallback onViewAllProducts;

  double get _elementRadius {
    switch (data.elementShape) {
      case ProfileElementShape.square:
        return 0;
      case ProfileElementShape.curved:
        return 8.r;
      case ProfileElementShape.rounded:
        return 999;
    }
  }

  String get _fontFamily {
    switch (data.fontStyle) {
      case ProfileFontStyle.tajawal:
        return 'Tajawal';
      case ProfileFontStyle.cairo:
        return 'Cairo';
      case ProfileFontStyle.almarai:
        return 'Almarai';
    }
  }

  @override
  Widget build(BuildContext context) {
    final initial = data.fullName.trim().isEmpty
        ? 'س'
        : data.fullName.trim().characters.first.toUpperCase();
    final enabledProducts =
        data.products.where((p) => p.enabled).take(2).toList();
    final showProducts = data.productsEnabled && enabledProducts.isNotEmpty;

    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Container(
        margin: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: AppColors.white.themeColor,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            Container(height: 100.h, width: double.infinity, color: data.coverColor),
            Transform.translate(
              offset: Offset(0, -36.h),
              child: Column(
                children: [
                  Container(
                    width: 72.w,
                    height: 72.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: data.primaryColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4),
                    ),
                    child: AppText(
                      initial,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      fontFamily: _fontFamily,
                    ),
                  ),
                  8.height,
                  AppText(
                    data.fullName.trim().isEmpty
                        ? LocaleKeys.profile_type_basic_info_full_name_hint.tr()
                        : data.fullName.trim(),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w800,
                    fontFamily: _fontFamily,
                  ),
                  4.height,
                  if (data.jobTitle.trim().isNotEmpty)
                    AppText(
                      data.jobTitle.trim(),
                      fontSize: 12.sp,
                      color: AppColors.textSecondaryColor.themeColor,
                      fontFamily: _fontFamily,
                    ),
                  18.height,
                  InkWell(
                    onTap: () => AppOverlay.showSuccess(
                      LocaleKeys.publish_saveContact.tr(),
                    ),
                    borderRadius: BorderRadius.circular(999),
                    child: Container(
                      width: 44.w,
                      height: 44.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color(0xFF17212B),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.person_add_alt_1,
                          size: 18.sp, color: Colors.white),
                    ),
                  ),
                  6.height,
                  AppText(
                    LocaleKeys.publish_saveContact.tr(),
                    fontSize: 11.sp,
                    color: AppColors.textSecondaryColor.themeColor,
                    textAlign: TextAlign.center,
                  ),
                  18.height,
                  Divider(
                      height: 1, color: AppColors.dividerColor.themeColor),
                  if (showProducts) ...[
                    16.height,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: onViewAllProducts,
                            child: AppText(
                              LocaleKeys.publish_viewAll.tr(),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textSecondaryColor.themeColor,
                            ),
                          ),
                          AppText(
                            LocaleKeys.products_title.tr(),
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w800,
                          ),
                        ],
                      ),
                    ),
                    12.height,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Row(
                        children: [
                          for (int i = 0; i < enabledProducts.length; i++) ...[
                            if (i > 0) 10.width,
                            Expanded(
                              child: ProductPreviewCard(
                                name: enabledProducts[i].name,
                                price: enabledProducts[i].price,
                                radius: _elementRadius,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    16.height,
                  ] else
                    16.height,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

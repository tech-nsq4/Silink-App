import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/app_overlay.dart';
import 'package:Silink/core/utils/convert_helper.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:Silink/features/profile_completion/data/models/catalog_model.dart';
import 'package:Silink/features/profile_completion/logic/profile_completion_cubit.dart';
import 'package:Silink/features/profile_completion/data/models/profile_completion_data.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widgets/catalog_carousel.dart';

class PublishStep extends StatelessWidget {
  const PublishStep({
    super.key,
    required this.data,
    required this.onViewAllProducts,
    required this.repaintKey,
  });

  final ProfileCompletionData data;
  final VoidCallback onViewAllProducts;
  final GlobalKey repaintKey;

  String _fontFamily(String fontFamily) =>
      fontFamily.isEmpty ? 'Tajawal' : fontFamily;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCompletionCubit, ProfileCompletionState>(
      builder: (context, state) {
        final appearance = state.appearance;
        final catalog = state.catalog;
        final primaryColor = appearance != null
            ? ConvertHelper.hexToColor(appearance.primaryColor)
            : AppColors.primaryColor.themeColor;
        final coverColor = appearance != null
            ? ConvertHelper.hexToColor(appearance.coverColor)
            : AppColors.primaryColor.themeColor;
        final matchingFonts = appearance?.fonts
                .where((f) => f.id == appearance.fontId)
                .toList() ??
            const [];
        final fontFamily =
            _fontFamily(matchingFonts.isEmpty ? '' : matchingFonts.first.family);

        final products = (catalog?.productsEnabled ?? false)
            ? (catalog?.items ?? const <CatalogItemModel>[])
                .where((p) => p.kind == 'product')
                .toList()
            : const <CatalogItemModel>[];
        final services = (catalog?.servicesEnabled ?? false)
            ? (catalog?.items ?? const <CatalogItemModel>[])
                .where((p) => p.kind == 'service')
                .toList()
            : const <CatalogItemModel>[];
        final catalogItems = <CatalogItemModel>[
          for (int i = 0; i < products.length || i < services.length; i++) ...[
            if (i < products.length) products[i],
            if (i < services.length) services[i],
          ],
        ];
        final showCatalog = catalogItems.isNotEmpty;

        return SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 16.h),
          child: RepaintBoundary(
            key: repaintKey,
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
                  Container(
                      height: 100.h, width: double.infinity, color: coverColor),
                  Transform.translate(
                    offset: Offset(0, -36.h),
                    child: Column(
                      children: [
                        Container(
                          width: 72.w,
                          height: 72.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 4),
                          ),
                          child: AppText(
                            data.fullName.initial,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            fontFamily: fontFamily,
                          ),
                        ),
                        8.height,
                        AppText(
                          data.fullName.trim().isEmpty
                              ? LocaleKeys.profile_type_basic_info_full_name_hint
                                  .tr()
                              : data.fullName.trim(),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w800,
                          fontFamily: fontFamily,
                        ),
                        4.height,
                        if (data.jobTitle.trim().isNotEmpty)
                          AppText(
                            data.jobTitle.trim(),
                            fontSize: 12.sp,
                            color: AppColors.textSecondaryColor.themeColor,
                            fontFamily: fontFamily,
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
                        if (showCatalog) ...[
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
                                    color:
                                        AppColors.textSecondaryColor.themeColor,
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
                          CatalogCarousel(items: catalogItems),
                          16.height,
                        ] else
                          16.height,
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

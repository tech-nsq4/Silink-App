import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/router/navigation_services.dart';
import '../../../app/router/routes.dart';
import '../../../core/extensions/extensions.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_overlay.dart';
import '../../../core/utils/convert_helper.dart';
import '../../../core/utils/locale_keys.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/flow_top_bar.dart';
import '../../../core/widgets/gradient_action_button.dart';
import '../../cart/data/models/cart_item.dart';
import '../../cart/logic/cart_cubit.dart';
import '../data/models/product.dart';
import '../widgets/shop_badge.dart';
import '../widgets/shop_cart_button.dart';
import '../widgets/shop_color_picker.dart';
import '../widgets/shop_identity_banner.dart';
import '../widgets/shop_info_tabs.dart';
import '../widgets/shop_product_visual.dart';
import '../widgets/shop_quantity_box.dart';
import '../widgets/shop_section_label.dart';
import '../widgets/shop_trust_row.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.product});

  final Product product;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int _quantity = 1;
  late int _colorIndex = widget.product.defaultColorIndex;

  Product get _product => widget.product;

  void _addToCart() {
    context.read<CartCubit>().addItem(
          CartItem.fromProduct(
            _product,
            quantity: _quantity,
            colorIndex: _colorIndex,
          ),
        );
    AppOverlay.showSuccess(LocaleKeys.store_added_to_cart.tr());
  }

  void _customize() => NavigationService.push(
        Routes.cardCustomizationScreen,
        arguments: {'product': _product},
      );

  Widget _divider() => Padding(
        padding: EdgeInsets.symmetric(vertical: 18.h),
        child: Divider(height: 1, color: AppColors.studioStepLine.themeColor),
      );

  List<ShopInfoTab> get _tabs {
    final compatibility = _product.compatibility.trim().isNotEmpty
        ? _product.compatibility
        : LocaleKeys.store_default_compatibility.tr();
    final delivery = _product.deliveryTime.trim().isNotEmpty
        ? _product.deliveryTime
        : LocaleKeys.store_delivery_days.tr();
    return [
      ShopInfoTab(
        label: LocaleKeys.shop_tabIdea.tr(),
        lines: [_product.description],
      ),
      ShopInfoTab(
        label: LocaleKeys.shop_tabSpecs.tr(),
        lines: [
          LocaleKeys.shop_specMaterial
              .tr(args: [LocaleKeys.shop_materialDefault.tr()]),
          LocaleKeys.shop_specCompatibility.tr(args: [compatibility]),
          LocaleKeys.shop_specDelivery.tr(args: [delivery]),
        ],
      ),
      ShopInfoTab(
        label: LocaleKeys.shop_tabBox.tr(),
        checks: true,
        lines: _product.packageContents.isNotEmpty
            ? _product.packageContents
            : [
                LocaleKeys.store_package_item_product
                    .tr(namedArgs: {'name': _product.name}),
                LocaleKeys.store_package_item_guide.tr(),
                LocaleKeys.store_package_item_qr.tr(),
              ],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final product = _product;
    final secondary = AppColors.textSecondaryColor.themeColor;
    final currency = LocaleKeys.store_currency.tr();
    final category = product.category?.labelKey.tr() ?? '';
    return Scaffold(
      backgroundColor: AppColors.backgroundColor.themeColor,
      body: Column(
        children: [
          SafeArea(
            bottom: false,
            child: FlowTopBar(
              eyebrow: LocaleKeys.shop_headerTitle.tr(),
              title: LocaleKeys.shop_detailsTitle.tr(),
              action: const ShopCartButton(),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.only(bottom: 24.h),
              children: [
                Container(
                  height: 230.h,
                  color: AppColors.studioSelectFill.themeColor,
                  padding: EdgeInsets.all(18.w),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 200.w,
                        height: 200.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.white.themeColor
                                .withValues(alpha: 0.8),
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: ShopProductVisual(
                          product: product,
                          cardWidth: 190.w,
                          colorIndex: _colorIndex,
                        ),
                      ),
                      if (product.badge != ProductBadge.none)
                        PositionedDirectional(
                          top: 0,
                          start: 0,
                          child: ShopBadge(label: product.badge.labelKey.tr()),
                        ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(22.w, 22.h, 22.w, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (category.isNotEmpty)
                        AppText(category, fontSize: 8.5.sp, color: secondary),
                      SizedBox(height: 8.h),
                      AppText(
                        product.name,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w800,
                        height: 1.3,
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          AppText(
                            ConvertHelper.formatPrice(product.price),
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w800,
                          ),
                          5.width,
                          Padding(
                            padding: EdgeInsets.only(bottom: 4.h),
                            child: AppText(currency,
                                fontSize: 8.5.sp, color: secondary),
                          ),
                          const Spacer(),
                          if (product.hasRating) ...[
                            Icon(Icons.star_rounded,
                                size: 15.sp,
                                color: AppColors.accentGold.themeColor),
                            4.width,
                            AppText(
                              '${product.rating}',
                              fontSize: 9.sp,
                              fontWeight: FontWeight.w700,
                            ),
                            4.width,
                            AppText(
                              '(${product.reviewCount ?? 0})',
                              fontSize: 8.sp,
                              color: secondary,
                            ),
                          ],
                        ],
                      ),
                      _divider(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (product.hasColors)
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ShopSectionLabel(
                                      text: LocaleKeys.shop_color.tr()),
                                  ShopColorPicker(
                                    colors: product.colors,
                                    selected: _colorIndex,
                                    onSelected: (index) =>
                                        setState(() => _colorIndex = index),
                                  ),
                                ],
                              ),
                            )
                          else
                            const Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ShopSectionLabel(
                                  text: LocaleKeys.shop_quantity.tr()),
                              ShopQuantityBox(
                                quantity: _quantity,
                                onChanged: (value) =>
                                    setState(() => _quantity = value),
                              ),
                            ],
                          ),
                        ],
                      ),
                      _divider(),
                      if (product.customizable) ...[
                        ShopIdentityBanner(onTap: _customize),
                        SizedBox(height: 18.h),
                      ],
                      ShopInfoTabs(tabs: _tabs),
                      SizedBox(height: 4.h),
                      const ShopTrustRow(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(22.w, 12.h, 22.w, 12.h),
            decoration: BoxDecoration(
              color: AppColors.white.themeColor,
              border: Border(
                top: BorderSide(color: AppColors.studioStepLine.themeColor),
              ),
            ),
            child: SafeArea(
              top: false,
              child: GradientActionButton(
                title: LocaleKeys.shop_addToCart.tr(),
                trailing:
                    '${ConvertHelper.formatPrice(product.totalFor(_quantity))} $currency',
                radius: 14,
                minHeight: 50,
                onTap: _addToCart,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

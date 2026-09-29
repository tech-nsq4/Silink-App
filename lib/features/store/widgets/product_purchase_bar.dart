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
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text.dart';
import '../../cart/data/models/cart_item.dart';
import '../../cart/logic/cart_cubit.dart';
import '../data/models/product.dart';

class ProductPurchaseBar extends StatelessWidget {
  const ProductPurchaseBar({
    super.key,
    required this.product,
    required this.quantity,
    required this.colorIndex,
  });

  final Product product;
  final int quantity;
  final int colorIndex;

  void _addToCart(BuildContext context) {
    context.read<CartCubit>().addItem(
          CartItem.fromProduct(
            product,
            quantity: quantity,
            colorIndex: colorIndex,
          ),
        );
    AppOverlay.showSuccess(LocaleKeys.store_added_to_cart.tr());
  }

  @override
  Widget build(BuildContext context) {
    final currency = LocaleKeys.store_currency.tr();
    final note = '${ConvertHelper.formatPrice(product.totalFor(quantity))} '
        '$currency · '
        '${LocaleKeys.store_shipping_note.tr(namedArgs: {
          'shipping':
              '${ConvertHelper.formatPrice(product.shippingCost)} $currency',
          'free':
              '${ConvertHelper.formatPrice(product.freeShippingThreshold)} $currency',
        })}';
    final textColor = AppColors.textPrimaryColor.themeColor;
    final onPrimary = AppColors.overlayOnDark.themeColor;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundColor.themeColor,
        border: Border(
          top: BorderSide(color: AppColors.borderColor.themeColor, width: 0.5),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: 16.paddingHorizontal + 14.paddingVert,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  if (product.customizable) ...[
                    Expanded(
                      child: CustomButton(
                        onTap: () => NavigationService.push(
                          Routes.cardCustomizationScreen,
                          arguments: {'product': product},
                        ),
                        height: 50,
                        color: AppColors.cardColor.themeColor,
                        borderColor: AppColors.borderColor.themeColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.palette_outlined,
                              size: 18.sp,
                              color: textColor,
                            ),
                            8.width,
                            AppText(
                              LocaleKeys.store_customize.tr(),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w800,
                              color: textColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                    10.width,
                  ],
                  Expanded(
                    child: CustomButton(
                      onTap: () => _addToCart(context),
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.shopping_cart_outlined,
                            size: 18.sp,
                            color: onPrimary,
                          ),
                          8.width,
                          AppText(
                            LocaleKeys.store_add_to_cart.tr(),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w800,
                            color: onPrimary,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              8.height,
              AppText(
                note,
                fontSize: 11.sp,
                color: AppColors.textSecondaryColor.themeColor,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

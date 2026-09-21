import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
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
import '../models/product.dart';

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

  void _addToCart() =>
      AppOverlay.showSuccess(LocaleKeys.store_added_to_cart.tr());

  @override
  Widget build(BuildContext context) {
    final currency = LocaleKeys.store_currency.tr();
    final total = product.totalFor(quantity);
    final shippingAmount =
        '${ConvertHelper.formatPrice(product.shippingCost)} $currency';
    final freeShippingAmount =
        '${ConvertHelper.formatPrice(product.freeShippingThreshold)} $currency';
    final note = total >= product.freeShippingThreshold
        ? LocaleKeys.store_free_shipping_over
            .tr(namedArgs: {'amount': freeShippingAmount})
        : '${LocaleKeys.store_shipping_fee.tr(namedArgs: {
                'amount': shippingAmount
              })}'
            ' · ${LocaleKeys.store_free_shipping_over.tr(namedArgs: {
                'amount': freeShippingAmount
              })}';

    return Padding(
      padding: 19.paddingHorizontal + 12.paddingVert,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(height: 1, color: AppColors.borderColor.themeColor),
          16.height,
          Row(
            children: [
              if (product.customizable) ...[
                Expanded(
                  child: CustomButton(
                    onTap: () => NavigationService.push(
                      Routes.cardCustomizationScreen,
                      arguments: {'productId': product.id},
                    ),
                    color: AppColors.white.themeColor,
                    borderColor: AppColors.borderColor.themeColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.palette_outlined,
                          size: 17.sp,
                          color: AppColors.textPrimaryColor.themeColor,
                        ),
                        8.width,
                        AppText(
                          LocaleKeys.store_customize.tr(),
                          fontSize: 13.5.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimaryColor.themeColor,
                        ),
                      ],
                    ),
                  ),
                ),
                8.width,
              ],
              Expanded(
                child: CustomButton(
                  onTap: _addToCart,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shopping_cart_outlined,
                        size: 18.sp,
                        color: AppColors.overlayOnDark.themeColor,
                      ),
                      8.width,
                      AppText(
                        LocaleKeys.store_add_to_cart.tr(),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.overlayOnDark.themeColor,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          8.height,
          AppText(
            '${LocaleKeys.store_total.tr()}: '
            '${ConvertHelper.formatPrice(total)} $currency · $note',
            fontSize: 10.5.sp,
            color: AppColors.textSecondaryColor.themeColor,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

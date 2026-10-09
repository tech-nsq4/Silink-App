import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/extensions/extensions.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/convert_helper.dart';
import '../../../../../core/utils/locale_keys.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../core/widgets/product_thumb.dart';
import '../../../../cart/data/models/cart_item.dart';
import '../../../../store/widgets/shop_quantity_box.dart';

class OrderCartItemCard extends StatelessWidget {
  const OrderCartItemCard({
    super.key,
    required this.item,
    required this.onQuantityChanged,
    required this.onRemove,
  });

  final CartItem item;
  final ValueChanged<int> onQuantityChanged;
  final VoidCallback onRemove;

  String get _customizedName {
    final summary = item.summary.trim();
    if (summary.isEmpty) return '';
    return summary.split(' · ').first;
  }

  @override
  Widget build(BuildContext context) {
    final accent = AppColors.accentTeal.themeColor;
    final secondary = AppColors.textSecondaryColor.themeColor;
    final customized = _customizedName;
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.white.themeColor,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: AppColors.studioPanelBorder.themeColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 78.w,
            height: 84.w,
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: AppColors.studioSelectFill.themeColor,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: ProductThumb(
              gradient: item.imageGradient,
              imageUrl: item.image,
              radius: 8,
              iconSize: 20,
            ),
          ),
          14.width,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  LocaleKeys.store_category_nfc.tr(),
                  fontSize: 7.5.sp,
                  color: secondary,
                ),
                SizedBox(height: 6.h),
                AppText(
                  item.name,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w800,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                if (customized.isNotEmpty) ...[
                  SizedBox(height: 5.h),
                  Row(
                    children: [
                      Icon(Icons.check_rounded, size: 11.sp, color: accent),
                      4.width,
                      Flexible(
                        child: AppText(
                          LocaleKeys.orderFlow_customizedFor
                              .tr(args: [customized]),
                          fontSize: 7.5.sp,
                          color: accent,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
                SizedBox(height: 8.h),
                AppText(
                  '${ConvertHelper.formatPrice(item.total)} ${LocaleKeys.store_currency.tr()}',
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w800,
                  color: AppColors.studioCardStart.themeColor,
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    ShopQuantityBox(
                      quantity: item.quantity,
                      onChanged: onQuantityChanged,
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: onRemove,
                      customBorder: const CircleBorder(),
                      child: Padding(
                        padding: EdgeInsets.all(6.w),
                        child: Icon(Icons.delete_outline_rounded,
                            size: 17.sp, color: secondary),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

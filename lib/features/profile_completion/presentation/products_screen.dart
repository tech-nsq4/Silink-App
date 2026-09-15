import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:Silink/features/profile_completion/models/profile_completion_data.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widgets/product_edit_sheet.dart';
import 'widgets/product_row_card.dart';

class ProductsStep extends StatefulWidget {
  const ProductsStep({super.key, required this.data});

  final ProfileCompletionData data;

  @override
  State<ProductsStep> createState() => _ProductsStepState();
}

class _ProductsStepState extends State<ProductsStep> {
  void _move(int index, int delta) {
    setState(() {
      final list = widget.data.products;
      final target = index + delta;
      final item = list.removeAt(index);
      list.insert(target, item);
    });
  }

  Future<void> _addProduct() async {
    final result = await showProductEditSheet(
      context,
      title: LocaleKeys.products_addTitle.tr(),
    );
    if (result == null) return;
    setState(() {
      widget.data.products.add(
        ProductItem(name: result.name, price: result.price),
      );
    });
  }

  Future<void> _editProduct(int index) async {
    final product = widget.data.products[index];
    final result = await showProductEditSheet(
      context,
      title: LocaleKeys.products_editTitle.tr(),
      initialName: product.name,
      initialPrice: product.price,
    );
    if (result == null) return;
    setState(() {
      product.name = result.name;
      product.price = result.price;
    });
  }

  void _deleteProduct(int index) {
    setState(() => widget.data.products.removeAt(index));
  }

  @override
  Widget build(BuildContext context) {
    final products = widget.data.products;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 19.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            LocaleKeys.products_title.tr(),
            fontSize: 20.sp,
            fontWeight: FontWeight.w800,
          ),
          4.height,
          AppText(
            LocaleKeys.products_subtitle.tr(),
            fontSize: 14.sp,
          ),
          16.height,
          Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: AppColors.white.themeColor,
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(color: AppColors.dividerColor.themeColor),
            ),
            child: Row(
              children: [
                Container(
                  width: 36.w,
                  height: 36.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.fieldFill,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(Icons.inventory_2_outlined,
                      size: 18.sp,
                      color: AppColors.textSecondaryColor.themeColor),
                ),
                10.width,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        LocaleKeys.products_enableTitle.tr(),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                      ),
                      AppText(
                        LocaleKeys.products_enableSubtitle.tr(),
                        fontSize: 11.sp,
                        color: AppColors.textSecondaryColor.themeColor,
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: widget.data.productsEnabled,
                  onChanged: (v) =>
                      setState(() => widget.data.productsEnabled = v),
                  activeThumbColor: AppColors.mint.themeColor,
                ),
              ],
            ),
          ),
          20.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: _addProduct,
                borderRadius: BorderRadius.circular(20.r),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: AppColors.mint.themeColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.add, size: 16.sp, color: AppColors.mint.themeColor),
                      4.width,
                      AppText(
                        LocaleKeys.products_addProduct.tr(),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.mint.themeColor,
                      ),
                    ],
                  ),
                ),
              ),
              AppText(
                LocaleKeys.products_countLabel.tr(
                  namedArgs: {'count': products.length.toString()},
                ),
                fontSize: 13.sp,
                fontWeight: FontWeight.w700,
              ),
            ],
          ),
          16.height,
          if (products.isEmpty)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 24.h),
              child: Center(
                child: AppText(
                  LocaleKeys.products_emptyHint.tr(),
                  fontSize: 13.sp,
                  color: AppColors.textSecondaryColor.themeColor,
                  textAlign: TextAlign.center,
                ),
              ),
            )
          else
            for (int i = 0; i < products.length; i++)
              ProductRowCard(
                name: products[i].name,
                price: products[i].price,
                enabled: products[i].enabled,
                canMoveUp: i > 0,
                canMoveDown: i < products.length - 1,
                onToggle: (v) => setState(() => products[i].enabled = v),
                onMoveUp: () => _move(i, -1),
                onMoveDown: () => _move(i, 1),
                onEdit: () => _editProduct(i),
                onDelete: () => _deleteProduct(i),
              ),
        ],
      ),
    );
  }
}

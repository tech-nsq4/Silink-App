import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_button.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:Silink/core/widgets/app_text_field.dart';
import 'package:Silink/features/company/data/models/company_catalog_item.dart';

Future<CompanyCatalogItem?> showCatalogItemFormSheet(
  BuildContext context, {
  required String title,
  required List<CompanyCatalogCategory> categories,
  required CompanyCatalogCategory initialCategory,
  CompanyCatalogItem? initial,
}) {
  return showModalBottomSheet<CompanyCatalogItem>(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.cardColor.themeColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
    ),
    builder: (_) => CatalogItemFormSheet(
      title: title,
      categories: categories,
      initialCategoryId: initialCategory.id,
      initial: initial,
    ),
  );
}

class CatalogItemFormSheet extends StatefulWidget {
  const CatalogItemFormSheet({
    super.key,
    required this.title,
    required this.categories,
    required this.initialCategoryId,
    this.initial,
  });

  final String title;
  final List<CompanyCatalogCategory> categories;
  final String initialCategoryId;
  final CompanyCatalogItem? initial;

  @override
  State<CatalogItemFormSheet> createState() => CatalogItemFormSheetState();
}

class CatalogItemFormSheetState extends State<CatalogItemFormSheet> {
  late String _categoryId = widget.initialCategoryId;
  final _nameCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  final _priceCtrl = TextEditingController();
  final _priceLabelCtrl = TextEditingController();
  final _imageUrlCtrl = TextEditingController();
  String? _error;

  @override
  void initState() {
    super.initState();
    final initial = widget.initial;
    if (initial == null) return;
    _nameCtrl.text = initial.name;
    _descCtrl.text = initial.description;
    _priceCtrl.text = initial.price;
    _priceLabelCtrl.text = initial.priceLabel;
    _imageUrlCtrl.text = initial.imageUrl ?? '';
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _descCtrl.dispose();
    _priceCtrl.dispose();
    _priceLabelCtrl.dispose();
    _imageUrlCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        20.w,
        20.h,
        20.w,
        MediaQuery.of(context).viewInsets.bottom + 24.h,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: AppText(
                  widget.title,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(Icons.close_rounded, size: 20.sp),
              ),
            ],
          ),
          12.height,
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: [
              for (final category in widget.categories)
                InkWell(
                  onTap: () => setState(() => _categoryId = category.id),
                  borderRadius: BorderRadius.circular(12.r),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 9.h,
                    ),
                    decoration: BoxDecoration(
                      color: _categoryId == category.id
                          ? AppColors.companyBrand.themeColor
                              .withValues(alpha: 0.1)
                          : AppColors.cardColor.themeColor,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: _categoryId == category.id
                            ? AppColors.companyBrand.themeColor
                            : AppColors.borderColor.themeColor,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          category.icon,
                          size: 14.sp,
                          color: _categoryId == category.id
                              ? AppColors.companyBrand.themeColor
                              : AppColors.textSecondaryColor.themeColor,
                        ),
                        5.width,
                        AppText(
                          category.labelKey.tr(),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                          color: _categoryId == category.id
                              ? AppColors.companyBrand.themeColor
                              : AppColors.textSecondaryColor.themeColor,
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          14.height,
          AppText(
            '${LocaleKeys.company_item_name.tr()} *',
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
          ),
          8.height,
          CustomTextField(
            controller: _nameCtrl,
            hint: LocaleKeys.company_example_consult.tr(),
            borderRadius: 12,
            focusedBorderColor: AppColors.blue.themeColor,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
          ),
          if (_error != null) ...[
            6.height,
            AppText(
              _error!,
              fontSize: 11.sp,
              color: AppColors.errorColor.themeColor,
            ),
          ],
          14.height,
          AppText(
            LocaleKeys.company_item_desc.tr(),
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
          ),
          8.height,
          CustomTextField(
            controller: _descCtrl,
            hint: LocaleKeys.company_item_desc_hint.tr(),
            maxLines: 3,
            borderRadius: 12,
            focusedBorderColor: AppColors.blue.themeColor,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
          ),
          14.height,
          AppText(
            LocaleKeys.company_item_image_url.tr(),
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
          ),
          8.height,
          CustomTextField(
            controller: _imageUrlCtrl,
            hint: 'https://',
            keyboardType: TextInputType.url,
            borderRadius: 12,
            focusedBorderColor: AppColors.blue.themeColor,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
          ),
          14.height,
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      LocaleKeys.company_item_price.tr(),
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    8.height,
                    CustomTextField(
                      controller: _priceCtrl,
                      hint: '500',
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      borderRadius: 12,
                      focusedBorderColor: AppColors.blue.themeColor,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                        vertical: 14.h,
                      ),
                    ),
                  ],
                ),
              ),
              12.width,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      LocaleKeys.company_item_price_label.tr(),
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    8.height,
                    CustomTextField(
                      controller: _priceLabelCtrl,
                      hint: LocaleKeys.company_price_label_hint.tr(),
                      borderRadius: 12,
                      focusedBorderColor: AppColors.blue.themeColor,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                        vertical: 14.h,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          20.height,
          CustomButton(
            onTap: _submit,
            title: LocaleKeys.company_save_item.tr(),
            color: AppColors.companyBrand.themeColor,
            height: 48,
            radius: 16,
            fontSize: 15,
          ),
        ],
      ),
    );
  }

  void _submit() {
    if (_nameCtrl.text.trim().isEmpty) {
      setState(() => _error = LocaleKeys.company_item_name_required.tr());
      return;
    }
    final initial = widget.initial;
    Navigator.of(context).pop(
      CompanyCatalogItem(
        id: initial?.id ?? '',
        name: _nameCtrl.text.trim(),
        categoryId: _categoryId,
        description: _descCtrl.text.trim(),
        price: _priceCtrl.text.trim(),
        priceLabel: _priceLabelCtrl.text.trim(),
        actionType: initial?.actionType ?? '',
        actionUrl: initial?.actionUrl ?? '',
        imageUrl: _imageUrlCtrl.text.trim(),
        visible: initial?.visible ?? true,
      ),
    );
  }
}

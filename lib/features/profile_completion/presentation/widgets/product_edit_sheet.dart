import 'dart:io';

import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/app_overlay.dart';
import 'package:Silink/core/utils/convert_helper.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_button.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:Silink/core/widgets/app_text_field.dart';
import 'package:Silink/core/widgets/field_label.dart';
import 'package:Silink/core/widgets/photo_source_sheet.dart';
import 'package:Silink/features/profile_completion/data/models/catalog_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class ProductEditResult {
  final String kind;
  final String name;
  final String description;
  final String priceLabel;
  final String price;
  final String actionType;
  final String actionUrl;
  final File? image;

  ProductEditResult({
    required this.kind,
    required this.name,
    required this.description,
    required this.priceLabel,
    required this.price,
    required this.actionType,
    required this.actionUrl,
    this.image,
  });
}

Future<ProductEditResult?> showProductEditSheet(
  BuildContext context, {
  required String title,
  required List<CatalogActionType> actionTypes,
  String initialKind = 'product',
  CatalogItemModel? initial,
}) {
  return showModalBottomSheet<ProductEditResult>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (sheetContext) => ProductEditSheetContent(
      title: title,
      actionTypes: actionTypes,
      initialKind: initial?.kind ?? initialKind,
      initial: initial,
    ),
  );
}

class ProductEditSheetContent extends StatefulWidget {
  const ProductEditSheetContent({
    super.key,
    required this.title,
    required this.actionTypes,
    required this.initialKind,
    this.initial,
  });

  final String title;
  final List<CatalogActionType> actionTypes;
  final String initialKind;
  final CatalogItemModel? initial;

  @override
  State<ProductEditSheetContent> createState() =>
      ProductEditSheetContentState();
}

class ProductEditSheetContentState extends State<ProductEditSheetContent> {
  late final TextEditingController _nameCtrl =
      TextEditingController(text: widget.initial?.name ?? '')
        ..addListener(_refresh);
  late final TextEditingController _descriptionCtrl =
      TextEditingController(text: widget.initial?.description ?? '')
        ..addListener(_refresh);
  late final TextEditingController _priceLabelCtrl =
      TextEditingController(text: widget.initial?.priceLabel ?? '')
        ..addListener(_refresh);
  late final TextEditingController _priceCtrl =
      TextEditingController(text: widget.initial?.price ?? '')
        ..addListener(_refresh);
  late final TextEditingController _actionUrlCtrl =
      TextEditingController(text: widget.initial?.actionUrl ?? '');

  late final String _kind = widget.initialKind;
  late String _actionType = widget.initial?.actionType ??
      (widget.actionTypes.isNotEmpty ? widget.actionTypes.first.type : '');
  File? _image;
  bool _removeExistingImage = false;

  void _refresh() => setState(() {});

  @override
  void dispose() {
    _nameCtrl.dispose();
    _descriptionCtrl.dispose();
    _priceLabelCtrl.dispose();
    _priceCtrl.dispose();
    _actionUrlCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final source = await PhotoSourceSheet.show(context);
    if (source == null || !mounted) return;
    try {
      final picked = await ImagePicker().pickImage(
        source: source,
        maxWidth: 1024,
        imageQuality: 85,
      );
      if (picked == null || !mounted) return;
      setState(() {
        _image = File(picked.path);
        _removeExistingImage = false;
      });
    } catch (_) {
      if (!mounted) return;
      AppOverlay.showError(LocaleKeys.common_somethingWentWrong.tr());
    }
  }

  void _removeImage() {
    setState(() {
      _image = null;
      _removeExistingImage = true;
    });
  }

  bool get _hasImage =>
      _image != null ||
      (!_removeExistingImage &&
          (widget.initial?.imageUrl ?? '').trim().isNotEmpty);

  Widget _chip({
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: AppColors.white.themeColor,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: selected
                ? AppColors.mint.themeColor
                : AppColors.dividerColor.themeColor,
            width: selected ? 1.6 : 1,
          ),
        ),
        child: AppText(
          label,
          fontSize: 12.sp,
          fontWeight: FontWeight.w700,
          color:
              selected ? AppColors.mint.themeColor : AppColors.textPrimaryColor.themeColor,
        ),
      ),
    );
  }

  void _submit() {
    final name = _nameCtrl.text.trim();
    final actionUrl = _actionUrlCtrl.text.trim();
    if (name.isEmpty || _actionType.isEmpty || actionUrl.isEmpty) return;
    Navigator.pop(
      context,
      ProductEditResult(
        kind: _kind,
        name: name,
        description: _descriptionCtrl.text.trim(),
        priceLabel: _priceLabelCtrl.text.trim(),
        price: _priceCtrl.text.trim(),
        actionType: _actionType,
        actionUrl: actionUrl,
        image: _image,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: EdgeInsets.fromLTRB(19.w, 20.h, 19.w, 20.h),
        constraints: BoxConstraints(maxHeight: 0.9.sh),
        decoration: BoxDecoration(
          color: AppColors.white.themeColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText(widget.title,
                      fontSize: 16.sp, fontWeight: FontWeight.w700),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: AppColors.mint.themeColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: AppText(
                      _kind == 'service'
                          ? LocaleKeys.products_kindService.tr()
                          : LocaleKeys.products_kindProduct.tr(),
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.mint.themeColor,
                    ),
                  ),
                ],
              ),
              16.height,
              FieldLabel(text: LocaleKeys.products_nameLabel.tr(), required: true),
              CustomTextField(
                controller: _nameCtrl,
                hint: LocaleKeys.products_nameHint.tr(),
              ),
              12.height,
              FieldLabel(text: LocaleKeys.products_descriptionLabel.tr()),
              CustomTextField(
                controller: _descriptionCtrl,
                hint: LocaleKeys.products_descriptionHint.tr(),
                maxLines: 3,
              ),
              12.height,
              FieldLabel(text: LocaleKeys.products_imageLabel.tr()),
              Row(
                children: [
                  if (_hasImage) ...[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: Container(
                        width: 48.h,
                        height: 48.h,
                        color: AppColors.fieldFill,
                        child: _image != null
                            ? Image.file(_image!, fit: BoxFit.cover)
                            : Image.network(
                                widget.initial!.imageUrl!,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Icon(
                                  Icons.image_not_supported_outlined,
                                  size: 18.sp,
                                  color: AppColors.textSecondaryColor.themeColor,
                                ),
                              ),
                      ),
                    ),
                    10.width,
                  ],
                  Expanded(
                    child: InkWell(
                      onTap: _pickImage,
                      borderRadius: BorderRadius.circular(999),
                      child: Container(
                        height: 48.h,
                        width: double.infinity,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.fieldFill,
                          borderRadius: BorderRadius.circular(999),
                          border:
                              Border.all(color: AppColors.dividerColor.themeColor),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.camera_alt_outlined,
                                size: 17.sp,
                                color: AppColors.textPrimaryColor.themeColor),
                            8.width,
                            AppText(
                              _hasImage
                                  ? LocaleKeys.products_changeImage.tr()
                                  : LocaleKeys.products_addImage.tr(),
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              if (_hasImage) ...[
                6.height,
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: InkWell(
                    onTap: _removeImage,
                    child: AppText(
                      LocaleKeys.products_removeImage.tr(),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.errorColor.themeColor,
                    ),
                  ),
                ),
              ],
              12.height,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FieldLabel(text: LocaleKeys.products_priceLabel.tr()),
                        CustomTextField(
                          controller: _priceCtrl,
                          hint: "",
                          keyboardType: TextInputType.number,
                        ),
                      ],
                    ),
                  ),
                  10.width,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FieldLabel(text: LocaleKeys.products_pricePrefixLabel.tr()),
                        CustomTextField(
                          controller: _priceLabelCtrl,
                          hint: "",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              12.height,
              FieldLabel(
                  text: LocaleKeys.products_actionTypeLabel.tr(), required: true),
              Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: [
                  for (final type in widget.actionTypes)
                    _chip(
                      label: type.label,
                      selected: _actionType == type.type,
                      onTap: () => setState(() => _actionType = type.type),
                    ),
                ],
              ),
              12.height,
              FieldLabel(
                  text: LocaleKeys.products_actionUrlLabel.tr(), required: true),
              CustomTextField(
                controller: _actionUrlCtrl,
                hint: LocaleKeys.products_actionUrlHint.tr(),
                keyboardType: TextInputType.url,
              ),
              20.height,
              AppText(
                LocaleKeys.products_previewLabel.tr(),
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
              ),
              10.height,
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: AppColors.white.themeColor,
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border.all(color: AppColors.dividerColor.themeColor),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          AppText(
                            _nameCtrl.text.trim().isEmpty
                                ? widget.title
                                : _nameCtrl.text.trim(),
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w700,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.end,
                          ),
                          2.height,
                          AppText(
                            _priceCtrl.text.trim().isEmpty
                                ? ''
                                : (_priceLabelCtrl.text.trim().isEmpty
                                    ? ConvertHelper.formatPriceWithCurrency(
                                        _priceCtrl.text.trim())
                                    : '${_priceLabelCtrl.text.trim()} ${ConvertHelper.formatPriceWithCurrency(_priceCtrl.text.trim())}'),
                            fontSize: 12.sp,
                            color: AppColors.textSecondaryColor.themeColor,
                          ),
                        ],
                      ),
                    ),
                    8.width,
                    Container(
                      width: 44.w,
                      height: 44.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.fieldFill,
                        borderRadius: BorderRadius.circular(10.r),
                        image: _image != null
                            ? DecorationImage(
                                image: FileImage(_image!), fit: BoxFit.cover)
                            : (!_removeExistingImage &&
                                    (widget.initial?.imageUrl ?? '')
                                        .trim()
                                        .isNotEmpty)
                                ? DecorationImage(
                                    image: NetworkImage(
                                        widget.initial!.imageUrl!),
                                    fit: BoxFit.cover)
                                : null,
                      ),
                      child: !_hasImage
                          ? Icon(Icons.inventory_2_outlined,
                              size: 18.sp,
                              color: AppColors.textSecondaryColor.themeColor)
                          : null,
                    ),
                  ],
                ),
              ),
              20.height,
              CustomButton(
                title: LocaleKeys.common_confirm.tr(),
                onTap: _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
